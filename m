Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318277AbSHZW5l>; Mon, 26 Aug 2002 18:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318283AbSHZW5l>; Mon, 26 Aug 2002 18:57:41 -0400
Received: from mail.actcom.co.il ([192.114.47.13]:13998 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318277AbSHZW5k>; Mon, 26 Aug 2002 18:57:40 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20-pre4-ac2
Date: Tue, 27 Aug 2002 02:01:53 +0300
User-Agent: KMail/1.4.3
References: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com>
In-Reply-To: <200208261035.g7QAZ4G19985@devserv.devel.redhat.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208270201.53750.nahshon@actcom.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 August 2002 13:35 pm, Alan Cox wrote:
> o       Error handling clean ups for USB storage        (Pete Zaitcev)

While USB-storage error handling is looked at...

--- linux-2.4.20-pre4-ac2-i2/drivers/usb/storage/transport.c.orig	Mon Aug 26 
23:24:09 2002
+++ linux-2.4.20-pre4-ac2-i2/drivers/usb/storage/transport.c	Mon Aug 26 
23:24:53 2002
@@ -1164,6 +1164,10 @@
 				ret = USB_STOR_TRANSPORT_ABORTED;
 				goto out;
 			}
+			if (result == US_BULK_TRANSFER_FAILED) {
+				ret = USB_STOR_TRANSPORT_FAILED;
+				goto out;
+			}
 		}
 	}

There's a check for US_BULK_TRANSFER_FAILED after
a call to usb_stor_transfer everywhere except here... Is it for 
a reason?

Backround:
A long time ago (linux-2.4.19-pre4-ac2) I got a USB disk
related hang (all processes accessing it stuck in state D).
It happened while reading from a USB-storage device
(disk attached to a USB-IDE bridge).

The system log has just these two errors:
usb-uhci.c: interrupt, status 3, frame# 1660
usb_control/bulk_msg: timeout

That problem happened only once. I had to reboot in order
to continue use the device.

Is it possible that the missing check is the cause for that
hang?

-- Itai

