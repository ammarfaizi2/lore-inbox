Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264364AbUBKNAj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 08:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264365AbUBKNAh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 08:00:37 -0500
Received: from post.tau.ac.il ([132.66.16.11]:52383 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S264364AbUBKNAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 08:00:35 -0500
Date: Wed, 11 Feb 2004 15:00:24 +0200
From: Micha Feigin <michf@post.tau.ac.il>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Laptop-mode v7 for linux 2.6.1
Message-ID: <20040211130024.GJ3854@luna.mooo.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FFFD61C.7070706@samwel.tk> <200401131200.16025.lkml@kcore.org> <20040113110110.GA6711@suse.de> <200402110724.18676.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402110724.18676.lkml@kcore.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.23.0.3; VDF: 6.23.0.65; host: localhost)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 11, 2004 at 07:24:18AM +0100, Jan De Luyck wrote:
> On Tuesday 13 January 2004 12:01, Jens Axboe wrote:
> > On Tue, Jan 13 2004, Jan De Luyck wrote:
> > > On Monday 12 January 2004 15:02, Jens Axboe wrote:
> > > > bo is accounted when io is actually put on the pending queue for the
> > > > disk, so they really do go hand in hand. So you should use block_dump
> > > > to find out why.
> > >
> > > It's nearly always reiserfs that causes the disk to spin up. Also, I'm
> > > seeting the harddisk led light up every 5-7 seconds :-( weird.
> >
> > Does 2.6 laptop mode patch even include the necessary reiser changes to
> > make this work properly?
> 
> To followup on this: I've recently moved my entire installation to ext3 (I had 
> to RMA the disk, tarred everything up, formatted another disk, put everything 
> back but on ext3 this time), on which the laptopmode actually makes a 
> difference. I can hear the disk spindown, and it stays that way for a 
> reasonably long time (e.g. +- 10 minutes has happened).
> 
> So there does seem to be a serious difference between the reiserfs commit 
> option and the ext3 option.
> 

The reiserfs commit option doesn't work to suppress reiserfs journal
writing to disk. The value that needs to be changes is the transaction
max age instead of the commit max age which is being change now.

This is under work along with adding xfs support and fixing the ext3
commit option (there is no reset to default commit value option at the
moment).

It won't take too long but if anyone is impatient I can send them a
patch to fix reiserfs.

> Just letting you folks know.
> 
> Jan
> 
> -- 
> Baruch's Observation:
> 	If all you have is a hammer, everything looks like a nail.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
