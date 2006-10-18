Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422966AbWJRVQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422966AbWJRVQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422973AbWJRVQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:16:58 -0400
Received: from mail29.messagelabs.com ([216.82.249.147]:19366 "HELO
	mail29.messagelabs.com") by vger.kernel.org with SMTP
	id S1422966AbWJRVQ5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:16:57 -0400
X-VirusChecked: Checked
X-Env-Sender: Scott_Kilau@digi.com
X-Msg-Ref: server-4.tower-29.messagelabs.com!1161206215!32838495!1
X-StarScan-Version: 5.5.10.7; banners=-,-,-
X-Originating-IP: [66.77.174.21]
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: kernel oops with extended serial stuff turned on...
Date: Wed, 18 Oct 2006 16:16:54 -0500
Message-ID: <335DD0B75189FB428E5C32680089FB9F803FDE@mtk-sms-mail01.digi.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel oops with extended serial stuff turned on...
Thread-Index: Acby9I1hWM0wMGB7S2+2ZuFFKwTmIgABNvtAAAAVxrA=
From: "Kilau, Scott" <Scott_Kilau@digi.com>
To: <Greg.Chandler@wellsfargo.com>
Cc: <linux-kernel@vger.kernel.org>, <greg@kroah.com>
X-OriginalArrivalTime: 18 Oct 2006 21:16:54.0780 (UTC) FILETIME=[BCAC6BC0:01C6F2FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg C,

> -----Original Message-----
> From: Greg.Chandler@wellsfargo.com 
> [mailto:Greg.Chandler@wellsfargo.com] 
> Sent: Wednesday, October 18, 2006 4:07 PM
> To: Kilau, Scott
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: kernel oops with extended serial stuff turned on...
> 
> 
> Should that be made a permanent patch then? 

In my out-of-tree drivers, yes, it was the correct way to fix
the problem.

I am probably not the best one to ask about the
other serial drivers however...

The "DEVFS" stuff was removed by Greg KH, I believe, so
he  probably is the best to decide upon the correct way of
"fixing" it.

Ie, I am not sure whether his intentions were to slide in a
new patch on it later on to fix the problem with trying to
register with sysfs/udev twice...

Scott


> -----Original Message-----
> From: Kilau, Scott [mailto:Scott_Kilau@digi.com] 
> Sent: Wednesday, October 18, 2006 3:33 PM
> To: Chandler, Greg
> Cc: linux-kernel@vger.kernel.org
> Subject: RE: kernel oops with extended serial stuff turned on...
> 
> Hi Greg,
> 
> > kobject_add failed for ttyM0 with -EEXIST, don't try to register
> things
> > with the same name in the same directory.
> > [<c01f4fe2>] kobject_add+0xd2/0xe0
> > [<c02a4e8f>] class_device_add+0x9f/0x2a0 [<c02a5117>] 
> > class_device_create+0x77/0x90 [<c02423ff>] 
> > tty_register_device+0x5f/0x70 [<c02a5c9c>] kobj_map+0xec/0x100 
> > [<c015493d>] cdev_add+0x1d/0x30 [<c02426ea>] 
> > tty_register_driver+0x19a/0x1b0 [<c0272e4c>] 
> > isicom_register_tty_driver+0xac/0xd0
> 
> 
> I saw this same warning/problem in my out-of-tree drivers when the
> "TTY_DRIVER_NO_DEVFS" flag went away somewhere between 2.6.17 and
> 2.6.18.
> 
> You need to change this line:
> 
> isicom_normal->flags                    = TTY_DRIVER_REAL_RAW;
> 
> To:
> 
> isicom_normal->flags                    = TTY_DRIVER_REAL_RAW |
> TTY_DRIVER_DYNAMIC_DEV;
> 
> In the "drivers/char/isicom.c" file.
> 
> Scott
> 
> 
> 
> 
> 
