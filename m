Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279869AbRJ3E6K>; Mon, 29 Oct 2001 23:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279868AbRJ3E5x>; Mon, 29 Oct 2001 23:57:53 -0500
Received: from chmls05.mediaone.net ([24.147.1.143]:48598 "EHLO
	chmls05.mediaone.net") by vger.kernel.org with ESMTP
	id <S279870AbRJ3E5d>; Mon, 29 Oct 2001 23:57:33 -0500
Message-Id: <200110300458.f9U4w6N17353@chmls05.mediaone.net>
From: Skip Gaede <sgaede@mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH]  driver: ide-floppy.c  kernel >=2.4.7 
Date: Tue, 30 Oct 2001 00:00:42 -0500
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_6X5021CIXDOZNMXZM83K"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_6X5021CIXDOZNMXZM83K
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

This patch fixes a lost interrupt problem with the Iomega ATAPI Zip 100 drive 
on an Asus A7V133 board (uses South Bridge VIA VT82C686 chip). The problem 
occurs when trying to format the drive using mke2fs /dev/hdx1. The patch 
introduces an adjustable delay between the time the drive asserts DRQ and 
deasserts BSY after issuing the packet command and before transferring the 12 
byte packet.. With delays of 3-5 ticks, the filesystem creation occurs 
without retries/resets. The delay can be adjusted through the proc interface 
by adjusting the value assigned to the parameter ticks. (Without the patch, I 
experienced 111 lost interrupts, resulting in an elapsed time of over 2 hours 
to format the drive. With the patch, mke2fs completed in <15 seconds.)
I am looking for testing, by others who have the internal Zip drive and may 
have experienced the same problem, as well as comments.

Thanks,
--Skip
--------------Boundary-00=_6X5021CIXDOZNMXZM83K
Content-Type: application/x-bzip2;
  name="ide-floppy-p7.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="ide-floppy-p7.patch.bz2"

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
brl4qpZ9ZC/2xSRIai7/4u5IpwoSGaoEeIA=

--------------Boundary-00=_6X5021CIXDOZNMXZM83K
Content-Type: text/plain;
  charset="iso-8859-1";
  name="README"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="README"

TG9zdCBpbnRlcnJ1cHQgcGF0Y2ggZm9yIGlkZS1mbG9wcHkuYyBieSBTa2lwIEdhZWRlIDxzZ2Fl
ZGVAbWVkaWFvbmUubmV0Pgo=

--------------Boundary-00=_6X5021CIXDOZNMXZM83K--
