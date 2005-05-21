Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVEUVzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVEUVzG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 17:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVEUVzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 17:55:06 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13323 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261644AbVEUVy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 17:54:59 -0400
Date: Sat, 21 May 2005 22:54:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Double 'block' link for floppy
Message-ID: <20050521225454.B25980@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	viro@parcelfarce.linux.theplanet.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing an oddity with floppy:

$ vdir /sys/devices/platform/floppy.0/
total 0
lrwxrwxrwx    1 root     root            0 May 21 22:43 block -> ../../../block/fd1
lrwxrwxrwx    1 root     root            0 May 21 22:43 block -> ../../../block/fd1
lrwxrwxrwx    1 root     root            0 May 21 22:43 bus -> ../../../bus/platform
-rw-r--r--    1 root     root         4096 May 21 22:43 detach_state

I suspect the first is actually supposed to be 'fd0' since:

$ vdir /sys/block/fd*/device
lrwxrwxrwx    1 root     root            0 May 21 22:52 /sys/block/fd0/device -> ../../devices/platform/floppy.0
lrwxrwxrwx    1 root     root            0 May 21 22:52 /sys/block/fd1/device -> ../../devices/platform/floppy.0

It seems that the block sysfs layer can't cope with one device having
multiple block devices hanging off it, which is the case with floppy
controllers.

Maybe a possible solution would be for the floppy driver to register
platform devices beneath the main device for each floppy drive?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
