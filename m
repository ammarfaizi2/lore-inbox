Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269247AbTCBBeg>; Sat, 1 Mar 2003 20:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269248AbTCBBeg>; Sat, 1 Mar 2003 20:34:36 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:55801 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S269247AbTCBBee>; Sat, 1 Mar 2003 20:34:34 -0500
Message-ID: <3E616196.9A47D80@verizon.net>
Date: Sat, 01 Mar 2003 17:42:46 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.63 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, clausen@gnu.org
Subject: [PATCH] reduce ntfs function stack usage (take 2)
Content-Type: multipart/mixed;
 boundary="------------91052580460C5B81FB9A7132"
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [4.64.238.61] at Sat, 1 Mar 2003 19:44:53 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------91052580460C5B81FB9A7132
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch to 2.5.63 reduces stack usage in the NTFS
generate_default_upcase() function from 0x3d4 bytes to noise.

Please apply.

Thanks,
~Randy
--------------91052580460C5B81FB9A7132
Content-Type: text/plain; charset=us-ascii;
 name="ntfs_stack2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ntfs_stack2.patch"

patch_name:	ntfs_stack2.patch
patch_version:	2003-03-01.13:30:45
author:		Randy.Dunlap <rddunlap@osdl.org>
description:	ntfs: reduce function local stack usage from 0x3d4 bytes to just noise;
product:	Linux
product_versions: linux-2563
changelog:	_
URL:		_
requires:	_
conflicts:	_
maintainer:	Anton Altaparmakov <aia21@cantab.net>
diffstat:	=
 fs/ntfs/upcase.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Naur ./fs/ntfs/upcase.c%NTSTK ./fs/ntfs/upcase.c
--- ./fs/ntfs/upcase.c%NTSTK	Mon Feb 24 11:05:05 2003
+++ ./fs/ntfs/upcase.c	Sat Mar  1 13:28:07 2003
@@ -28,7 +28,7 @@
 
 uchar_t *generate_default_upcase(void)
 {
-	const int uc_run_table[][3] = { /* Start, End, Add */
+static const int uc_run_table[][3] = { /* Start, End, Add */
 	{0x0061, 0x007B,  -32}, {0x0451, 0x045D, -80}, {0x1F70, 0x1F72,  74},
 	{0x00E0, 0x00F7,  -32}, {0x045E, 0x0460, -80}, {0x1F72, 0x1F76,  86},
 	{0x00F8, 0x00FF,  -32}, {0x0561, 0x0587, -48}, {0x1F76, 0x1F78, 100},
@@ -45,7 +45,7 @@
 	{0}
 	};
 
-	const int uc_dup_table[][2] = { /* Start, End */
+static const int uc_dup_table[][2] = { /* Start, End */
 	{0x0100, 0x012F}, {0x01A0, 0x01A6}, {0x03E2, 0x03EF}, {0x04CB, 0x04CC},
 	{0x0132, 0x0137}, {0x01B3, 0x01B7}, {0x0460, 0x0481}, {0x04D0, 0x04EB},
 	{0x0139, 0x0149}, {0x01CD, 0x01DD}, {0x0490, 0x04BF}, {0x04EE, 0x04F5},
@@ -55,7 +55,7 @@
 	{0}
 	};
 
-	const int uc_word_table[][2] = { /* Offset, Value */
+static const int uc_word_table[][2] = { /* Offset, Value */
 	{0x00FF, 0x0178}, {0x01AD, 0x01AC}, {0x01F3, 0x01F1}, {0x0269, 0x0196},
 	{0x0183, 0x0182}, {0x01B0, 0x01AF}, {0x0253, 0x0181}, {0x026F, 0x019C},
 	{0x0185, 0x0184}, {0x01B9, 0x01B8}, {0x0254, 0x0186}, {0x0272, 0x019D},

--------------91052580460C5B81FB9A7132--

