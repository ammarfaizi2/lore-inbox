Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264282AbUDSCx0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 22:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264272AbUDSCwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 22:52:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:38317 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264251AbUDSCv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 22:51:59 -0400
Date: Sun, 18 Apr 2004 19:51:35 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: akpm <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: [PATCH] floppy98.c: use C99 struct initializers
Message-Id: <20040418195135.5dedf652.rddunlap@osdl.org>
In-Reply-To: <20040418194813.629e75bd.randy.dunlap@verizon.net>
References: <20040418194357.4cd02a06.rddunlap@osdl.org>
	<20040418194813.629e75bd.randy.dunlap@verizon.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert (most of) floppy98.c to use C99 struct initializers,
like floppy.c.


diffstat:=
 drivers/block/floppy98.c |   60 +++++++++++++++++++++++------------------------
 1 files changed, 30 insertions(+), 30 deletions(-)

diff -Naurp ./drivers/block/floppy98.c~fd98_c99 ./drivers/block/floppy98.c
--- ./drivers/block/floppy98.c~fd98_c99	2004-04-18 18:12:10.000000000 -0700
+++ ./drivers/block/floppy98.c	2004-04-18 19:20:18.000000000 -0700
@@ -907,9 +907,9 @@ static void motor_off_callback(unsigned 
 }
 
 static struct timer_list motor_off_timer[N_FDC] = {
-      {data: 0, function: motor_off_callback},
+      {.data = 0, .function = motor_off_callback},
 #if N_FDC > 1
-      {data: 1, function: motor_off_callback},
+      {.data = 1, .function = motor_off_callback},
 #endif
 #if N_FDC > 2
 # error "N_FDC > 2; please fix initializer for motor_off_timer[]"
@@ -2071,17 +2071,17 @@ static void do_wakeup(void)
 }
 
 static struct cont_t wakeup_cont = {
-	empty,
-	do_wakeup,
-	empty,
-	(done_f) empty
+	.interrupt	= empty,
+	.redo		= do_wakeup,
+	.error		= empty,
+	.done		= (done_f) empty
 };
 
 static struct cont_t intr_cont = {
-	empty,
-	process_fd_request,
-	empty,
-	(done_f) empty
+	.interrupt	= empty,
+	.redo		= process_fd_request,
+	.error		= empty,
+	.done		= (done_f) empty
 };
 
 static int wait_til_done(void (*handler) (void), int interruptible)
@@ -2303,10 +2303,10 @@ static void redo_format(void)
 }
 
 static struct cont_t format_cont = {
-	format_interrupt,
-	redo_format,
-	bad_flp_intr,
-	generic_done
+	.interrupt	= format_interrupt,
+	.redo		= redo_format,
+	.error		= bad_flp_intr,
+	.done		= generic_done
 };
 
 static int do_format(int drive, struct format_descr *tmp_format_req)
@@ -3026,10 +3026,10 @@ static void redo_fd_request(void)
 }
 
 static struct cont_t rw_cont = {
-	rw_interrupt,
-	redo_fd_request,
-	bad_flp_intr,
-	request_done
+	.interrupt	= rw_interrupt,
+	.redo		= redo_fd_request,
+	.error		= bad_flp_intr,
+	.done		= request_done
 };
 
 static void process_fd_request(void)
@@ -3064,10 +3064,10 @@ static void do_fd_request(request_queue_
 }
 
 static struct cont_t poll_cont = {
-	success_and_wakeup,
-	floppy_ready,
-	generic_failure,
-	generic_done
+	.interrupt	= success_and_wakeup,
+	.redo		= floppy_ready,
+	.error		= generic_failure,
+	.done		= generic_done
 };
 
 static int poll_drive(int interruptible, int flag)
@@ -3100,10 +3100,10 @@ static void reset_intr(void)
 }
 
 static struct cont_t reset_cont = {
-	reset_intr,
-	success_and_wakeup,
-	generic_failure,
-	generic_done
+	.interrupt	= reset_intr,
+	.redo		= success_and_wakeup,
+	.error		= generic_failure,
+	.done		= generic_done
 };
 
 static int user_reset_fdc(int drive, int arg, int interruptible)
@@ -3207,10 +3207,10 @@ static void raw_cmd_done(int flag)
 }
 
 static struct cont_t raw_cmd_cont = {
-	success_and_wakeup,
-	floppy_start,
-	generic_failure,
-	raw_cmd_done
+	.interrupt	= success_and_wakeup,
+	.redo		= floppy_start,
+	.error		= generic_failure,
+	.done		= raw_cmd_done
 };
 
 static inline int raw_cmd_copyout(int cmd, char *param,
