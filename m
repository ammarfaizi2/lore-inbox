Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbUDOWhE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 18:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDOWhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 18:37:04 -0400
Received: from mail0.lsil.com ([147.145.40.20]:44686 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S262351AbUDOWgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 18:36:55 -0400
Message-ID: <0E3FA95632D6D047BA649F95DAB60E57033BC533@exa-atlanta.se.lsil.com>
From: "Mukker, Atul" <Atulm@lsil.com>
To: "'Paul Wagland'" <paul@wagland.net>,
       Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: "Mukker, Atul" <Atulm@lsil.com>
Subject: RE: assertion failure with new megaraid beta driver leads to sche
	duling failure
Date: Thu, 15 Apr 2004 18:36:50 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

Random deletion has issues with this version of the driver. Sreenivas will
release the next version tomorrow morning with the fix.

Thanks
-Atul

> -----Original Message-----
> From: Paul Wagland [mailto:paul@wagland.net]
> Sent: Thursday, April 15, 2004 5:57 PM
> To: Linux SCSI mailing list; Linux kernel mailing list
> Cc: Atul Mukker
> Subject: assertion failure with new megaraid beta driver leads to
> scheduling failure
> 
> 
> Hi all,
> 
> Well, seems I have a penchance for causing trouble ;-)
> 
> I was playing around with the new beta driver, and was trying 
> to remove
> some logical drives using the dellmgr utility.
> 
> Well, something between the driver and the BIOS got unhappy, 
> and all of
> a sudden I got about 20 of the following lines:
> 
> assertion failed:(spin_is_locked(adapter->host_lock)), file: 
> drivers/scsi/megaraid.c, line: 3061:megaraid_abort_handler
> 
> followed by (copied by hand... maybe I should set up a serial 
> console :-):
> 
> bad: scheduling while atomic!
> Call Trace:
>  [<c011cd5f>] schedule+0x58f/0x5a0
>  [<c01209a7>] __call_console_drivers+0x57/0x60
>  [<c0108126>] __down+0x86/0x100
>  [<c011cdc0>] default_wake_function+0x0/0x20
>  [<f8832790>] megaraid_reset_handler+0x0/0xc0 [megaraid]
>  [<c010833c>] __down_failed+0x8/0xc
>  [<f8833fee>] .text.lock.megaraid_clib+0x5/0x17 [megaraid]
>  [<f88327be>] megaraid_reset_handler+0x2e/0xc0 [megaraid]
> 
> this was called from:
> scsi_try_bus_device_reset
> scsi_eh_bus_device_reset
> scsi_eh_ready_devs
> scsi_unjam_host
> default_wake_function
> scsi_error_handler
> scsi_error_handler
> kernel_thread_helper
> 
> 
> 
> Thoughts and/or suggestions?
> 
> Cheers,
> Paul
> 
