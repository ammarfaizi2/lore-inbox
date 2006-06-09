Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965124AbWFIDup@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965124AbWFIDup (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 23:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbWFIDuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 23:50:25 -0400
Received: from xenotime.net ([66.160.160.81]:64455 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S965124AbWFIDuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 23:50:24 -0400
Date: Thu, 8 Jun 2006 20:45:18 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: lkml <linux-kernel@vger.kernel.org>
Cc: mhw@wittsend.com, akpm <akpm@osdl.org>
Subject: [PATCH] char/ip2: more section fixes (replacement)
Message-Id: <20060608204518.013bc5a5.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Priority: tossup.
In theory some of these (previously) __init functions could be called
after init, but that problem has not been observed AFAIK.

There were 2 cases of cleanup_module() (module_exit) calling __init
functions (clear_requested_irq() & have_requested_irq()).
These are more serious, but still not observed AFAIK.

Fix sections mismatch:
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'cleanup_module' (at offset 0x228b) and 'ip2_loadmain'
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'cleanup_module' (at offset 0x22ae) and 'ip2_loadmain'
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'ip2_loadmain' (at offset 0x2501) and 'set_irq'
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'ip2_loadmain' (at offset 0x25de) and 'set_irq'
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'ip2_loadmain' (at offset 0x2698) and 'set_irq'
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'ip2_loadmain' (at offset 0x2922) and 'set_irq'
WARNING: drivers/char/ip2/ip2main.o - Section mismatch: reference to .init.text: from .text between 'ip2_loadmain' (at offset 0x299e) and 'set_irq'

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/ip2/ip2main.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2617-rc6.orig/drivers/char/ip2/ip2main.c
+++ linux-2617-rc6/drivers/char/ip2/ip2main.c
@@ -305,7 +305,7 @@ static struct class *ip2_class;
 
 // Some functions to keep track of what irq's we have
 
-static int __init
+static int
 is_valid_irq(int irq)
 {
 	int *i = Valid_Irqs;
@@ -316,14 +316,14 @@ is_valid_irq(int irq)
 	return (*i);
 }
 
-static void __init
+static void
 mark_requested_irq( char irq )
 {
 	rirqs[iindx++] = irq;
 }
 
 #ifdef MODULE
-static int __init
+static int
 clear_requested_irq( char irq )
 {
 	int i;
@@ -337,7 +337,7 @@ clear_requested_irq( char irq )
 }
 #endif
 
-static int __init
+static int
 have_requested_irq( char irq )
 {
 	// array init to zeros so 0 irq will not be requested as a side effect
@@ -818,7 +818,7 @@ EXPORT_SYMBOL(ip2_loadmain);
 /* the board, the channel structures are initialized, and the board details   */
 /* are reported on the console.                                               */
 /******************************************************************************/
-static void __init
+static void
 ip2_init_board( int boardnum )
 {
 	int i;
@@ -961,7 +961,7 @@ err_initialize:
 /* EISA motherboard, or no valid board ID is selected it returns 0. Otherwise */
 /* it returns the base address of the controller.                             */
 /******************************************************************************/
-static unsigned short __init
+static unsigned short
 find_eisa_board( int start_slot )
 {
 	int i, j;


---
