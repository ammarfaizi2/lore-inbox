Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263158AbTKWCOS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 21:14:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTKWCOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 21:14:17 -0500
Received: from ipvpn069002.netvigator.com ([203.198.202.2]:30634 "EHLO
	mail.astri.org") by vger.kernel.org with ESMTP id S263158AbTKWCOQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 21:14:16 -0500
From: "jackylam" <jackylam@astri.org>
Reply-to: faichai0@yahoo.com
To: linux-kernel@vger.kernel.org
Subject: Buffer overflow in SCSI code?
X-Mailer: WebMAIL to Mail Gateway v3.0i
Date: Sun, 23 Nov 2003 10:13:42 +0800
Message-id: <3fc017d6.504e.1139768128@astri.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

    I am not very experience in SCSI. Currently, I try to
play with a ITE8212F PCI IDE RAID card. After compiling and
insert the driver module, there will be a kernel fault when
accessing file greater than 4K. After tracing the problem up
to kernel SCSI level, I find something very strange in the
SCSI buffer allocation.

    Here is the log:
.
.
.
SMalloc: 512 c03af000 [From:00000007]
SMalloc: 512 c03af000 [From:00000007]
Doing sd request, dev = 0x801, block = 62128
sda : real dev = /dev/0, block = 62191
sda : reading 32/32 512 byte blocks.
Adding timer for command d8ef7600 at 3000 (c0217700)
scsi_dispatch_cmnd (host = 1, channel = 0, target = 0,
command = d8ef7658, buffer = c03af000,
bufflen = 16384, done = c02295c0)
.
.
.
    It is showing that the buffer 0xc03af000 is allocated
for 512 bytes only.  However, it is used to hold 16K data in
the following code. And this pointer will finally pass to
the ITE driver.

    Can anyone explain to me that is it correct? Thanks.

Best regards,
Jacky
