Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268809AbUHLVXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268809AbUHLVXq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268576AbUHLVVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:21:34 -0400
Received: from the-village.bc.nu ([81.2.110.252]:52949 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268809AbUHLVT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:19:58 -0400
Subject: Re: SG_IO and security
From: Alan Cox <alan@www.pagan.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
References: <1092313030.21978.34.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
	 <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092341803.22458.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 12 Aug 2004 21:16:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-12 at 17:45, Linus Torvalds wrote:
> On Thu, 12 Aug 2004, Linus Torvalds wrote:
> > 
> > Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).

That uses sg_io() so gets caught as well unless I screwed up following
the code paths.

> Btw, I think the _right_ thing to check is the write access of the file 
> descriptor. If you have write access to a block device, you can delete the 
> data, so you might as well be able to do the raw commands. And that would 
> allow things like "disk" groups etc to work and burn CD's.

With the current code I can destroy all your hard disks given read
access to the drive. With checks on writable I can destroy all your hard
disks/cdroms as appropriate with write access.

Destroy here means "dead, defunct, pushing up the daisies, go order
a new one kind of dead".

In essence the interface (and the SCSI/ATA/.. layers below) don't
seperate media and device. This also kicks in for partitioning since
write access to /dev/hda1 giving me SG_IO scsi access doesn't enforce
partitioning.

We end up needing some notion of what commands should be allowed to any
user and what commands should be allowed solely to superusers. That
leads to a second question for you which is one I had an argument about
Jens on.

Do we

a) Have code that essentially says "if read on base device can do ....,
if write can do ... , else capable(...)"

b) ioctls/other command functionality for the stuff users should be
allowed to do. 

Option (a) means parsing command blocks which are pretty regular and
parseable. 

Alan

