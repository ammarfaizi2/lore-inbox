Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268628AbUHLRfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268628AbUHLRfk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:35:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268629AbUHLRfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:35:40 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:673 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268628AbUHLRfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:35:37 -0400
Date: Thu, 12 Aug 2004 19:35:32 +0200
From: Jens Axboe <axboe@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
Message-ID: <20040812173532.GD5136@suse.de>
References: <1092313030.21978.34.camel@localhost.localdomain> <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org> <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12 2004, Linus Torvalds wrote:
> 
> 
> On Thu, 12 Aug 2004, Linus Torvalds wrote:
> > 
> > Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
> 
> Btw, I think the _right_ thing to check is the write access of the file 
> descriptor. If you have write access to a block device, you can delete the 
> data, so you might as well be able to do the raw commands. And that would 
> allow things like "disk" groups etc to work and burn CD's.
> 
> However, right now we don't even pass down the "struct file" to this 
> function. We probably should. Anybody willing to go through the callers? 
> (just a few callers, but things like cdrom_command() doesn't even have the 
> file, so it has to be recursive).

Precisely, I guess that's a 2.6.9 job then. CDROM_SEND_PACKET works
directly on top of SG_IO now, so should just work as long as sg_io() is
translated.

I have no problem going over this, if somebody beats me to it, fine.
I'll be gone on vacation next week.

-- 
Jens Axboe

