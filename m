Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750917AbWGDMxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWGDMxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 08:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWGDMxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 08:53:16 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:49557 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750917AbWGDMxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 08:53:15 -0400
Date: Tue, 4 Jul 2006 14:49:05 +0200
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Neil Brown <neilb@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ext4 features (checksums)
Message-ID: <20060704124905.GB11458@aitel.hist.no>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <20060701170729.GB8763@irc.pl> <20060701174716.GC24570@cip.informatik.uni-erlangen.de> <20060701181702.GC8763@irc.pl> <20060703202219.GA9707@aitel.hist.no> <20060703205523.GA17122@irc.pl> <1151960503.3108.55.camel@laptopd505.fenrus.org> <1151964720.16528.22.camel@localhost.localdomain> <17577.43190.724583.146845@cse.unsw.edu.au> <m3psglhb2o.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3psglhb2o.fsf@defiant.localdomain>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 01:19:11PM +0200, Krzysztof Halasa wrote:
> Neil Brown <neilb@suse.de> writes:
> 
> > With checksums - the filesystem is in a better position to:
> >  - be selective about what is checksummed - no point checksumming
> >    blocks that aren't part of any file.  Some blocks (highlevel
> >    metadata) might always be checksummed, while other blocks
> >    (regular data) might not if a 'fast' option was chosen.
> 
> The same applies to RAID - for example, why "synchronise" unused area?
> 
Indeed.  RAID usually avoid checksumming unused area, it sums on write
and you don't write "unused" stuff.  

Not syncing unused area is possible, if there was a way for raid resync
to ask the fs what blocks are not in use.  I.e. get the
free block list in disk block order.  Then raid resync could skip those.

Helge Hafting
