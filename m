Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268516AbTCAG6N>; Sat, 1 Mar 2003 01:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268517AbTCAG6N>; Sat, 1 Mar 2003 01:58:13 -0500
Received: from pop017pub.verizon.net ([206.46.170.210]:40435 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S268516AbTCAG6L>; Sat, 1 Mar 2003 01:58:11 -0500
Message-ID: <3E605BEF.89DB801F@verizon.net>
Date: Fri, 28 Feb 2003 23:06:23 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.63 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: aia21@cantab.net, linux-kernel@vger.kernel.org,
       linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH] reduce large stack usage
Content-Type: multipart/mixed;
 boundary="------------663C30BDF877A6934CB2E60C"
X-Authentication-Info: Submitted using SMTP AUTH at pop017.verizon.net from [4.64.238.61] at Sat, 1 Mar 2003 01:08:28 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------663C30BDF877A6934CB2E60C
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

This patch to 2.5.63 reduces stack usage in generate_default_upcase()
from 0x3d4 bytes to just noise (on x86).

The arrays are static so they are still private (hidden), but
now they aren't allocated on the stack and copied there for
temp use.

Please apply.

Thanks,
~Randy
--------------663C30BDF877A6934CB2E60C
Content-Type: text/plain; charset=us-ascii;
 name="ntfs_stack_2563.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ntfs_stack_2563.patch"

patch_name:	ntfs_stack_2563.patch
patch_version:	2003-02-28.22:42:57
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
 fs/ntfs/upcase.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -Naur ./fs/ntfs/upcase.c%NTSTK ./fs/ntfs/upcase.c
--- ./fs/ntfs/upcase.c%NTSTK	Mon Feb 24 11:05:05 2003
+++ ./fs/ntfs/upcase.c	Fri Feb 28 22:37:32 2003
@@ -26,9 +26,7 @@
 
 #include "ntfs.h"
 
-uchar_t *generate_default_upcase(void)
-{
-	const int uc_run_table[][3] = { /* Start, End, Add */
+static const int uc_run_table[][3] = { /* Start, End, Add */
 	{0x0061, 0x007B,  -32}, {0x0451, 0x045D, -80}, {0x1F70, 0x1F72,  74},
 	{0x00E0, 0x00F7,  -32}, {0x045E, 0x0460, -80}, {0x1F72, 0x1F76,  86},
 	{0x00F8, 0x00FF,  -32}, {0x0561, 0x0587, -48}, {0x1F76, 0x1F78, 100},
@@ -45,7 +43,7 @@
 	{0}
 	};
 
-	const int uc_dup_table[][2] = { /* Start, End */
+static const int uc_dup_table[][2] = { /* Start, End */
 	{0x0100, 0x012F}, {0x01A0, 0x01A6}, {0x03E2, 0x03EF}, {0x04CB, 0x04CC},
 	{0x0132, 0x0137}, {0x01B3, 0x01B7}, {0x0460, 0x0481}, {0x04D0, 0x04EB},
 	{0x0139, 0x0149}, {0x01CD, 0x01DD}, {0x0490, 0x04BF}, {0x04EE, 0x04F5},
@@ -55,7 +53,7 @@
 	{0}
 	};
 
-	const int uc_word_table[][2] = { /* Offset, Value */
+static const int uc_word_table[][2] = { /* Offset, Value */
 	{0x00FF, 0x0178}, {0x01AD, 0x01AC}, {0x01F3, 0x01F1}, {0x0269, 0x0196},
 	{0x0183, 0x0182}, {0x01B0, 0x01AF}, {0x0253, 0x0181}, {0x026F, 0x019C},
 	{0x0185, 0x0184}, {0x01B9, 0x01B8}, {0x0254, 0x0186}, {0x0272, 0x019D},
@@ -67,6 +65,8 @@
 	{0}
 	};
 
+uchar_t *generate_default_upcase(void)
+{
 	int i, r;
 	uchar_t *uc;
 

--------------663C30BDF877A6934CB2E60C--

