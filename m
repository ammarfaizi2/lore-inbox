Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWBWBO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWBWBO1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 20:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbWBWBO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 20:14:27 -0500
Received: from mail04.hansenet.de ([213.191.73.12]:2689 "EHLO
	webmail.hansenet.de") by vger.kernel.org with ESMTP
	id S1030359AbWBWBO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 20:14:26 -0500
From: Thomas Koeller <thomas@koeller.dyndns.org>
To: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] tty flip buffer handling
Date: Thu, 23 Feb 2006 02:14:08 +0100
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602230214.08548.thomas@koeller.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of 'const' qualifiers to the TTY flip buffer APIs,
where appropriate.

Signed-off-by: Thomas Koeller <thomas@koeller.dyndns.org>

diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
index e9bba94..2d041bc 100644
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -354,7 +354,7 @@ int tty_buffer_request_room(struct tty_s
 
 EXPORT_SYMBOL_GPL(tty_buffer_request_room);
 
-int tty_insert_flip_string(struct tty_struct *tty, unsigned char *chars, size_t size)
+int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars, size_t size)
 {
 	int copied = 0;
 	do {
@@ -378,7 +378,7 @@ int tty_insert_flip_string(struct tty_st
 
 EXPORT_SYMBOL_GPL(tty_insert_flip_string);
 
-int tty_insert_flip_string_flags(struct tty_struct *tty, unsigned char *chars, char *flags, size_t size)
+int tty_insert_flip_string_flags(struct tty_struct *tty, const unsigned char *chars, const char *flags, size_t size)
 {
 	int copied = 0;
 	do {
diff --git a/include/linux/tty_flip.h b/include/linux/tty_flip.h
index 222faf9..cbe5ce3 100644
--- a/include/linux/tty_flip.h
+++ b/include/linux/tty_flip.h
@@ -2,8 +2,8 @@
 #define _LINUX_TTY_FLIP_H
 
 extern int tty_buffer_request_room(struct tty_struct *tty, size_t size);
-extern int tty_insert_flip_string(struct tty_struct *tty, unsigned char *chars, size_t size);
-extern int tty_insert_flip_string_flags(struct tty_struct *tty, unsigned char *chars, char *flags, size_t size);
+extern int tty_insert_flip_string(struct tty_struct *tty, const unsigned char *chars, size_t size);
+extern int tty_insert_flip_string_flags(struct tty_struct *tty, const unsigned char *chars, const char *flags, size_t size);
 extern int tty_prepare_flip_string(struct tty_struct *tty, unsigned char **chars, size_t size);
 extern int tty_prepare_flip_string_flags(struct tty_struct *tty, unsigned char **chars, char **flags, size_t size);
 

-- 
Thomas Koeller
thomas@koeller.dyndns.org
