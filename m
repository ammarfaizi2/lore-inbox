Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTGBOen (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 10:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTGBOen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 10:34:43 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22024 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264047AbTGBOem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 10:34:42 -0400
Date: Wed, 2 Jul 2003 16:49:05 +0200
From: Jan Kara <jack@suse.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: viro@parcelfarce.linux.theplanet.co.uk, rmoser <mlmoser@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030702144905.GD19563@atrey.karlin.mff.cuni.cz>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net> <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk> <20030701200309.GB6810@zaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701200309.GB6810@zaurus.ucw.cz>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

> > > >Uh-huh.  You want to get in-kernel conversion between ext* and reiserfs?
> > > >With recoverable state if aborted?  Get real.
> > > 
> > > no, in-kernel conversion between everything.  You don't think it can be done?
> > > It's not that difficult a problem to manage data like that :D
> > 
> > I think that I will believe it when I see the patchset implementing it.
> > Provided that it will be convincing enough.  Other than that...  Not
> > really.  You will need code for each pair of filesystems, since
> > convertor will need to know *both* layouts.  No amount of handwaving
> > is likely to work around that.  And we have what, something between
> > 10 and 20 local filesystems?  Have fun...
> > 
> > If you want your idea to be considered seriously - take reiserfs code,
> > take ext3 code, copy both to userland and put together a conversion
> > between them.  Both ways.  That, by definition, is easier than doing
> 
> Actually partition surprise should be able
> to do ext2<=>reiser. It does not have journal, IIRC :-(.
  Partition Surprise could handle the conversions in userspace but not
in-kernel ones (which I think are discussed above)... We had only set
of patches for online ext2 resizing and that was already non-trivial
(especially shifting block descriptors and such). Conversion could be
actually done in a similar way in principle - one could establish some
block remapper which would map metadata of new filesystem into free
space of the other one and could be moving files by deleting it from
one filesystem and creating them in the other one... But it would not
volunteer to write that (it would be really hard to do it atomicly and
almost impossible to not make garbage of your data when power fails..)

							Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
