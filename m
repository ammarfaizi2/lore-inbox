Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262396AbVAKD7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262396AbVAKD7b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 22:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVAJRxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 12:53:04 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:16388 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262366AbVAJRhE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 12:37:04 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] NLS: Fix overflow of nls_ascii
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 11 Jan 2005 02:36:54 +0900
Message-ID: <87k6qlxk21.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please apply.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


The nls_ascii is using 128 for conversion table, but it should be 256.
This became the oops.

Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/nls/nls_ascii.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff -puN fs/nls/nls_ascii.c~nls_ascii-fix fs/nls/nls_ascii.c
--- linux-2.6.10/fs/nls/nls_ascii.c~nls_ascii-fix	2005-01-11 02:31:32.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/nls/nls_ascii.c	2005-01-11 02:31:32.000000000 +0900
@@ -13,7 +13,7 @@
 #include <linux/nls.h>
 #include <linux/errno.h>
 
-static wchar_t charset2uni[128] = {
+static wchar_t charset2uni[256] = {
 	/* 0x00*/
 	0x0000, 0x0001, 0x0002, 0x0003,
 	0x0004, 0x0005, 0x0006, 0x0007,
@@ -56,7 +56,7 @@ static wchar_t charset2uni[128] = {
 	0x007c, 0x007d, 0x007e, 0x007f,
 };
 
-static unsigned char page00[128] = {
+static unsigned char page00[256] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
@@ -75,11 +75,11 @@ static unsigned char page00[128] = {
 	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */
 };
 
-static unsigned char *page_uni2charset[128] = {
-	page00, NULL,   NULL,   NULL,   NULL,   NULL,   NULL,   NULL,
+static unsigned char *page_uni2charset[256] = {
+	page00,
 };
 
-static unsigned char charset2lower[128] = {
+static unsigned char charset2lower[256] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
@@ -98,7 +98,7 @@ static unsigned char charset2lower[128] 
 	0x78, 0x79, 0x7a, 0x7b, 0x7c, 0x7d, 0x7e, 0x7f, /* 0x78-0x7f */
 };
 
-static unsigned char charset2upper[128] = {
+static unsigned char charset2upper[256] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, /* 0x00-0x07 */
 	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, /* 0x08-0x0f */
 	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, /* 0x10-0x17 */
_
