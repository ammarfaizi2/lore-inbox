Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUHMMzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUHMMzz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265212AbUHMMzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:55:55 -0400
Received: from mail.bencastricum.nl ([213.84.203.196]:51975 "EHLO
	gateway.bencastricum.nl") by vger.kernel.org with ESMTP
	id S265161AbUHMMzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:55:52 -0400
Message-ID: <001d01c48135$a0741b30$0502a8c0@tragebak>
From: "Ben Castricum" <lk@bencastricum.nl>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc doesn't detect USB modem/weird SSH problem
Date: Fri, 13 Aug 2004 14:59:32 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-bencastricum-MailScanner-Information: Please contact the ISP for more information
X-bencastricum-MailScanner: Found to be clean
X-MailScanner-From: lk@bencastricum.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are 2 issues I have since 2.6.8-rc1 (2.6.7 is fine). One is that my
Tornado SFM56.0 USB modem isn't detected anymory and the other is that I
can't seem te login with SSH.

This is from a "diff -u bootmessages-2.6.7 bootmessages-2.6.8-rc1":

@@ -159,13 +161,14 @@
 drivers/usb/class/cdc-acm.c: v0.23:USB Abstract Control Model driver for
USB modems and ISDN adapters
 hw_random hardware driver 1.0.0 loaded
 usb 1-2: new full speed USB device using address 2
-cdc_acm 1-2:1.0: ttyACM0: USB ACM device
 8139too Fast Ethernet driver 0.9.27
 PCI: Enabling device 0000:01:08.0 (0004 -> 0007)
-eth0: RealTek RTL8139 at 0xc887e000, 00:50:fc:85:89:e0, IRQ 12

My modem has the following info in /proc/bus/usb:

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.00 Cls=02(comm.) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=069f ProdID=0011 Rev= 1.00
S:  Manufacturer=Allied Data
S:  Product=Tornado SFM56.0-USB
C:* #Ifs= 2 Cfg#= 1 Atr=a0 MxPwr=400mA
I:  If#= 1 Alt= 0 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_acm
E:  Ad=81(I) Atr=02(Bulk) MxPS=  16 Ivl=0ms
E:  Ad=01(O) Atr=02(Bulk) MxPS=  16 Ivl=0ms
I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=02 Prot=01 Driver=cdc_acm
E:  Ad=82(I) Atr=03(Int.) MxPS=   8 Ivl=128ms


The SSH problem is a bit stranger. I know this is a user space application
but since 2.6.7 has no problems I thought I mention it just in case. If I
strace the daemon and compare a working with a non-working session the
non-working sessions fails on this:
open("/dev/ptmx", O_RDWR)         = -1 EIO (Input/output error)

Any suggestions?

Thanks,
Ben

