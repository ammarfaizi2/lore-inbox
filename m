Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCSHPZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 02:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbUCSHPZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 02:15:25 -0500
Received: from smtp-out3.iol.cz ([194.228.2.91]:22942 "EHLO smtp-out3.iol.cz")
	by vger.kernel.org with ESMTP id S261451AbUCSHPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 02:15:16 -0500
From: Chris Moore <chris.moore@mail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16474.40447.453039.89445@chrislap.ourcpu.com>
Date: Fri, 19 Mar 2004 08:15:11 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: problem with sbp2 / ieee1394 in kernel 2.6.3
In-Reply-To: <16470.13793.211260.738789@chrislap.ourcpu.com>
References: <16470.13793.211260.738789@chrislap.ourcpu.com>
X-Mailer: VM 7.18 under Emacs 21.3.50.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bob Gill, Mon Mar 15 2004 - 22:10:19 EST:

> There were a lot of changes to ieee1394 between 2.6.3 and 2.6.4, and
> haven't seen sbp2 fail since (two or three patches) before
> 2.6.4. Try the 2.6.4 kernel (or newer) and see if that helps.

I just compiled 2.6.4.  It fails just the same as in 2.4.x and 2.6.3,
but this time I got a message I hadn't noticed before - the first
line, the "unsolicited response" message is new to me:

  Mar 19 07:48:10 chrislap kernel: ieee1394: unsolicited response packet received - no tlabel match
  Mar 19 07:48:51 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 19 07:48:51 chrislap kernel: Read (10) 00 06 b5 82 bf 00 00 f8 00 
  Mar 19 07:49:01 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 19 07:49:01 chrislap kernel: Test Unit Ready 00 00 00 00 00 
  Mar 19 07:49:01 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 19 07:49:01 chrislap kernel: Read (10) 00 06 b5 83 b7 00 00 08 00 
  Mar 19 07:49:11 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 19 07:49:11 chrislap kernel: Test Unit Ready 00 00 00 00 00 
  Mar 19 07:49:11 chrislap kernel: ieee1394: sbp2: reset requested
  Mar 19 07:49:11 chrislap kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
  Mar 19 07:49:21 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 19 07:49:21 chrislap kernel: Test Unit Ready 00 00 00 00 00 
  Mar 19 07:49:21 chrislap kernel: ieee1394: sbp2: reset requested
  Mar 19 07:49:21 chrislap kernel: ieee1394: sbp2: Generating sbp2 fetch agent reset
  Mar 19 07:49:41 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 19 07:49:41 chrislap kernel: Test Unit Ready 00 00 00 00 00 
  Mar 19 07:49:51 chrislap kernel: ieee1394: sbp2: aborting sbp2 command
  Mar 19 07:49:51 chrislap kernel: Test Unit Ready 00 00 00 00 00 
  Mar 19 07:49:51 chrislap kernel: ieee1394: sbp2: reset requested
  [...]

I umounted the drive - got some errors, but it umounted:

  [root@chrislap firewire]# umount g
  messages:Mar 19 07:55:12 chrislap kernel: scsi1 (1:0): rejecting I/O to offline device
  messages:Mar 19 07:55:12 chrislap kernel: Buffer I/O error on device sda2, logical block 524
  messages:Mar 19 07:55:12 chrislap kernel: lost page write due to I/O error on sda2
  [root@chrislap firewire]# 

but then modprobe hung:

  [root@chrislap firewire]# modprobe -r -v sbp2
  unloading the sbp2 module:
  rmmod /lib/modules/2.6.4/kernel/drivers/ieee1394/sbp2.ko
  ^--note no root prompt came back

So what should I do next?  Incidentally, I don't suppose it is of any
interest, but the drive has a USB 2 interface too.  My PC doesn't
have a USB 2 port, but it does have USB 1.  I've managed to read the
whole disk using the USB 1 interface (albeit VERY slowly).  Perhaps
that's interesting...

Chris.
