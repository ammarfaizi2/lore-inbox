Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268671AbUHLTWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268671AbUHLTWm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268673AbUHLTWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:22:42 -0400
Received: from fep22-0.kolumbus.fi ([193.229.0.60]:25022 "EHLO
	fep22-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S268671AbUHLTWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:22:38 -0400
Date: Thu, 12 Aug 2004 22:22:36 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: Linus Torvalds <torvalds@osdl.org>
cc: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
In-Reply-To: <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0408122216300.4586@kai.makisara.local>
References: <1092313030.21978.34.camel@localhost.localdomain>
 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> <411BA0F4.9060201@pobox.com>
 <Pine.LNX.4.58.0408120958000.1839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Linus Torvalds wrote:

> 
> 
> On Thu, 12 Aug 2004, Jeff Garzik wrote:
> >
> > Linus Torvalds wrote:
> > > 
> > > On Thu, 12 Aug 2004, Linus Torvalds wrote:
> > > 
> > >>Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
> > > 
> > > 
> > > Btw, I think the _right_ thing to check is the write access of the file 
> > > descriptor. If you have write access to a block device, you can delete the 
> > > data, so you might as well be able to do the raw commands. And that would 
> > > allow things like "disk" groups etc to work and burn CD's.
> > 
> > Define raw commands.  I certainly don't want non-root users to be able 
> > to issue FORMAT UNIT on my hard drive.
> 
> Ehh? The same ones you allow to write all over the raw device?
> 
> Let's see now:
> 
> 	brw-rw----    1 root     disk       3,   0 Jan 30  2003 /dev/hda
> 
> would you put people you don't trust with your disk in the "disk" group?
> 
This protects disks in practice but SG_IO is currently supported by other 
devices, at least SCSI tapes. It is reasonable in some organizations to 
give r/w access to ordinary users so that they can read/write tapes. I 
would be worried if this would enable the users, for instance, to mess up 
the mode page contents of the drive or change the firmware.

-- 
Kai
