Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265773AbSKLHrt>; Tue, 12 Nov 2002 02:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265821AbSKLHrt>; Tue, 12 Nov 2002 02:47:49 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:37389 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265773AbSKLHrs>; Tue, 12 Nov 2002 02:47:48 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB18BE@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: linux-kernel@vger.kernel.org
Cc: Manish Lachwani <manish@Zambeel.com>
Subject: Hangs seen with the 3ware controller and the 2.4.17 kernel ...
Date: Mon, 11 Nov 2002 23:54:27 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

