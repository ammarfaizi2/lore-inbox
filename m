Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285591AbRLWIel>; Sun, 23 Dec 2001 03:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285604AbRLWIeb>; Sun, 23 Dec 2001 03:34:31 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:57492 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S285591AbRLWIeS>; Sun, 23 Dec 2001 03:34:18 -0500
Date: Sun, 23 Dec 2001 03:34:17 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200112230834.fBN8YHl15225@devserv.devel.redhat.com>
To: geoffeg@sin.sloth.org, linux-kernel@vger.kernel.org
Subject: Re: Using USB floppy drive for root floppy
In-Reply-To: <mailman.1009060801.12605.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1009060801.12605.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> Originally, I just downloaded the standard boot and root floppies. I booted
> and got the "Insert root floppy disk to be loaded into RAM disk and press
> ENTER" message. Upon inserting the root disk and pressing ENTER I get a
> message saying "Unable to mount root fs on 02:00".
>[...] 
> To get around this problem I compiled my own kernel (2.4.12) with USB and
> SCSI floppy support. Upon booting that kernel, linux recognizes the USB
> floppy drive and apparently assigns it to sda. I then tried booting with
> root=/dev/fd0 which caused the "Unable to mount root fs on 02:00" again. I
> then tried root=/dev/sda which caused the kernel to panic with "Unable to
> mount root fs on 08:00".

There must be a delay before an attempt to mount is made.
Insert schedule_timeout(5*HZ) there (mdelay won't work because
it locks out khubd).

-- Pete
