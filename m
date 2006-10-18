Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422926AbWJRVH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422926AbWJRVH0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbWJRVH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:07:26 -0400
Received: from dxv00.wellsfargo.com ([151.151.5.40]:47244 "EHLO
	dxv00.wellsfargo.com") by vger.kernel.org with ESMTP
	id S1030282AbWJRVHZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:07:25 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: kernel oops with extended serial stuff turned on...
Date: Wed, 18 Oct 2006 16:07:21 -0500
Message-ID: <E8C008223DD5F64485DFBDF6D4B7F71D020C6071@msgswbmnmsp25.wellsfargo.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel oops with extended serial stuff turned on...
Thread-Index: Acby9I1hWM0wMGB7S2+2ZuFFKwTmIgABNvtA
From: <Greg.Chandler@wellsfargo.com>
To: <Scott_Kilau@digi.com>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 18 Oct 2006 21:07:21.0903 (UTC) FILETIME=[673653F0:01C6F2F9]
X-WFMX: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Should that be made a permanent patch then? 

-----Original Message-----
From: Kilau, Scott [mailto:Scott_Kilau@digi.com] 
Sent: Wednesday, October 18, 2006 3:33 PM
To: Chandler, Greg
Cc: linux-kernel@vger.kernel.org
Subject: RE: kernel oops with extended serial stuff turned on...

Hi Greg,

> kobject_add failed for ttyM0 with -EEXIST, don't try to register
things
> with the same name in the same directory.
> [<c01f4fe2>] kobject_add+0xd2/0xe0
> [<c02a4e8f>] class_device_add+0x9f/0x2a0 [<c02a5117>] 
> class_device_create+0x77/0x90 [<c02423ff>] 
> tty_register_device+0x5f/0x70 [<c02a5c9c>] kobj_map+0xec/0x100 
> [<c015493d>] cdev_add+0x1d/0x30 [<c02426ea>] 
> tty_register_driver+0x19a/0x1b0 [<c0272e4c>] 
> isicom_register_tty_driver+0xac/0xd0


I saw this same warning/problem in my out-of-tree drivers when the
"TTY_DRIVER_NO_DEVFS" flag went away somewhere between 2.6.17 and
2.6.18.

You need to change this line:

isicom_normal->flags                    = TTY_DRIVER_REAL_RAW;

To:

isicom_normal->flags                    = TTY_DRIVER_REAL_RAW |
TTY_DRIVER_DYNAMIC_DEV;

In the "drivers/char/isicom.c" file.

Scott




