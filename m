Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268618AbUHLRCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268618AbUHLRCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 13:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268617AbUHLRCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 13:02:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:59299 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268618AbUHLRCV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 13:02:21 -0400
Date: Thu, 12 Aug 2004 10:02:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
In-Reply-To: <411BA0F4.9060201@pobox.com>
Message-ID: <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
References: <1092313030.21978.34.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <411BA0F4.9060201@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Aug 2004, Jeff Garzik wrote:
>
> Linus Torvalds wrote:
> > 
> > On Thu, 12 Aug 2004, Linus Torvalds wrote:
> > 
> >>Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
> > 
> > 
> > Btw, I think the _right_ thing to check is the write access of the file 
> > descriptor. If you have write access to a block device, you can delete the 
> > data, so you might as well be able to do the raw commands. And that would 
> > allow things like "disk" groups etc to work and burn CD's.
> 
> Define raw commands.  I certainly don't want non-root users to be able 
> to issue FORMAT UNIT on my hard drive.

Ehh? The same ones you allow to write all over the raw device?

Let's see now:

	brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda

would you put people you don't trust with your disk in the "disk" group?

Right. If you trust somebody enough that you give him write access to the 
disk, then you might as well trust him enough to do commands on it. 

Conversely, if you don't trust him enough to do things like that, you 
shouldn't give him write access in the first place.

It's a hell of a lot easier to destroy a disk with

	dd if=/dev/zero of=/dev/xxx bs=8k

than it is to do it with some special malicious command. 

And yes, there's clearly a difference, but in general I'd say it is the 
_data_ on the disk that is worth something to you. The disk itself? Do you 
really fundamentally care?

		Linus
