Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266754AbSKLSih>; Tue, 12 Nov 2002 13:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266760AbSKLSih>; Tue, 12 Nov 2002 13:38:37 -0500
Received: from 209-76-113-226.ded.pacbell.net ([209.76.113.226]:22057 "EHLO
	siamese.engr.3ware.com") by vger.kernel.org with ESMTP
	id <S266754AbSKLSif>; Tue, 12 Nov 2002 13:38:35 -0500
Message-ID: <A1964EDB64C8094DA12D2271C04B812672C85A@tabby>
From: Adam Radford <aradford@3WARE.com>
To: "'Manish Lachwani'" <manish@Zambeel.com>, linux-kernel@vger.kernel.org
Subject: RE: Hangs seen with the 3ware controller and the 2.4.17 kernel ..
	.
Date: Tue, 12 Nov 2002 10:47:28 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're using an old driver before the conversion to
documentation/DMA-mapping.  This
will cause raw io to 'not work'.   If you upgrade to the latest driver
1.02.00.031
driver, you should be fine.

-Adam

-----Original Message-----
From: Manish Lachwani [mailto:manish@Zambeel.com]
Sent: Monday, November 11, 2002 11:54 PM
To: linux-kernel@vger.kernel.org
Cc: Manish Lachwani
Subject: Hangs seen with the 3ware controller and the 2.4.17 kernel ...


Hello,

I am using a 2.4.17 SMP kernel and .018 version of the 3ware driver. This
happens when we have two controllers (8-port and 4-port), IO is going on
with both the controllers and on one controller (4-port in my experiment),
there is  command timeout and the reset sequence fails. This is a hard
kernel hang. The last message on the window is "reset sequence failed"

kdb for the eh_1 shows:

scsi_error_handler -> scsi_unjam_host -> scsi_try_host_reset -> schedule

I do know that the scsi_try_host_reset(..) calls scsi_sleep for 10*HZ. 

Anyway, another scenario that causes a hang:

scsi_error_handler -> scsi_unjam_host -> scsi_try_to_abort_command ->
schedule

Also, This hang seems to occur when there are two controllers only. When I
tried with 
one controller numerous times, I could not reproduce this problem. Is it
possible that scsi_unjam_host is getting confused with two devices and when
reset fails on one host?

Any help is appreciated ...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
