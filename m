Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261488AbUK1O06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261488AbUK1O06 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 09:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbUK1O06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 09:26:58 -0500
Received: from aun.it.uu.se ([130.238.12.36]:15248 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261488AbUK1O0x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 09:26:53 -0500
Date: Sun, 28 Nov 2004 15:26:45 +0100 (MET)
Message-Id: <200411281426.iASEQjDt001350@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: marcelo.tosatti@cyclades.com
Subject: [PATCH][2.4.29-pre1] proc_tty.c warning fix
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The /proc/tty/driver/serial vulnerability fix in 2.4.29-pre1
calls a function without a prototype in scope, resulting in:

proc_tty.c: In function `proc_tty_init':
proc_tty.c:183: warning: implicit declaration of function `proc_mkdir_mode'
proc_tty.c:183: warning: assignment makes pointer from integer without a cast

Fixed by the trivial patch below.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.4.29-pre1/include/linux/proc_fs.h.~1~	2004-11-28 12:54:26.000000000 +0100
+++ linux-2.4.29-pre1/include/linux/proc_fs.h	2004-11-28 13:44:05.000000000 +0100
@@ -143,6 +143,7 @@ extern struct proc_dir_entry *proc_symli
 		struct proc_dir_entry *, const char *);
 extern struct proc_dir_entry *proc_mknod(const char *,mode_t,
 		struct proc_dir_entry *,kdev_t);
+extern struct proc_dir_entry *proc_mkdir_mode(const char *, mode_t, struct proc_dir_entry *);
 extern struct proc_dir_entry *proc_mkdir(const char *,struct proc_dir_entry *);
 
 static inline struct proc_dir_entry *create_proc_read_entry(const char *name,
