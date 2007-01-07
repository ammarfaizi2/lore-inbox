Return-Path: <linux-kernel-owner+w=401wt.eu-S932348AbXAGChu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbXAGChu (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 21:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932349AbXAGChu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 21:37:50 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:18984 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932348AbXAGCht (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 21:37:49 -0500
Date: Sat, 6 Jan 2007 18:36:28 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Dave Jones <davej@redhat.com>
Cc: Torsten Kaiser <tk13@bardioc.dyndns.org>, Olaf Hering <olaf@aepfle.de>,
       lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
Subject: [PATCH 1/2 v4] sysrq: showBlockedTasks is sysrq-W
Message-Id: <20070106183628.60670a1b.randy.dunlap@oracle.com>
In-Reply-To: <20070107000945.GA1533@redhat.com>
References: <20070105110628.5f1e487d.rdunlap@xenotime.net>
	<20070105193605.GA14592@aepfle.de>
	<20070106102531.29ce662c.randy.dunlap@oracle.com>
	<200701062019.29974.tk13@bardioc.dyndns.org>
	<20070106140424.2a4fa38b.randy.dunlap@oracle.com>
	<20070107000945.GA1533@redhat.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jan 2007 19:09:45 -0500 Dave Jones wrote:

> On Sat, Jan 06, 2007 at 02:04:24PM -0800, Randy Dunlap wrote:
> 
>  > +	.help_msg	= "showBlockedTasks(W)",
> 
> Why not the same scheme as the existing help msgs..

Yes.  Thanks.

> shoWblockedtasks  ?

Would shoW-blocked-tasks be OK?

---
From: Randy Dunlap <randy.dunlap@oracle.com>

Change SysRq showBlockedTasks from sysrq-X to sysrq-W and show that
in the Help message.

It was previously done via X, but X is already used for Xmon
on ppc & powerpc platforms and this collision needs to be avoided.

All callers of register_sysrq_key() are now marked in the
sysrq op/key table.  I didn't mark 'h' as Help because Help
is just printed for any unknown key, such as '?'.

Added some omitted sysrq key entries in the sysrq.txt file.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 Documentation/sysrq.txt |   66 +++++++++++++++++++++++++-----------------------
 drivers/char/sysrq.c    |   20 ++++++++------
 2 files changed, 46 insertions(+), 40 deletions(-)

--- linux-2620-rc3g4.orig/drivers/char/sysrq.c
+++ linux-2620-rc3g4/drivers/char/sysrq.c
@@ -215,7 +215,7 @@ static void sysrq_handle_showstate_block
 }
 static struct sysrq_key_op sysrq_showstate_blocked_op = {
 	.handler	= sysrq_handle_showstate_blocked,
-	.help_msg	= "showBlockedTasks",
+	.help_msg	= "shoW-blocked-tasks",
 	.action_msg	= "Show Blocked State",
 	.enable_mask	= SYSRQ_ENABLE_DUMP,
 };
@@ -315,15 +315,16 @@ static struct sysrq_key_op *sysrq_key_ta
 	&sysrq_loglevel_op,		/* 9 */
 
 	/*
-	 * Don't use for system provided sysrqs, it is handled specially on
-	 * sparc and will never arrive
+	 * a: Don't use for system provided sysrqs, it is handled specially on
+	 * sparc and will never arrive.
 	 */
 	NULL,				/* a */
 	&sysrq_reboot_op,		/* b */
-	&sysrq_crashdump_op,		/* c */
+	&sysrq_crashdump_op,		/* c & ibm_emac driver debug */
 	&sysrq_showlocks_op,		/* d */
 	&sysrq_term_op,			/* e */
 	&sysrq_moom_op,			/* f */
+	/* g: May be registered by ppc for kgdb */
 	NULL,				/* g */
 	NULL,				/* h */
 	&sysrq_kill_op,			/* i */
@@ -332,18 +333,19 @@ static struct sysrq_key_op *sysrq_key_ta
 	NULL,				/* l */
 	&sysrq_showmem_op,		/* m */
 	&sysrq_unrt_op,			/* n */
-	/* This will often be registered as 'Off' at init time */
+	/* o: This will often be registered as 'Off' at init time */
 	NULL,				/* o */
 	&sysrq_showregs_op,		/* p */
 	NULL,				/* q */
-	&sysrq_unraw_op,			/* r */
+	&sysrq_unraw_op,		/* r */
 	&sysrq_sync_op,			/* s */
 	&sysrq_showstate_op,		/* t */
 	&sysrq_mountro_op,		/* u */
-	/* May be assigned at init time by SMP VOYAGER */
+	/* v: May be registered at init time by SMP VOYAGER */
 	NULL,				/* v */
-	NULL,				/* w */
-	&sysrq_showstate_blocked_op,	/* x */
+	&sysrq_showstate_blocked_op,	/* w */
+	/* x: May be registered on ppc/powerpc for xmon */
+	NULL,				/* x */
 	NULL,				/* y */
 	NULL				/* z */
 };
--- linux-2620-rc3g4.orig/Documentation/sysrq.txt
+++ linux-2620-rc3g4/Documentation/sysrq.txt
@@ -1,6 +1,6 @@
 Linux Magic System Request Key Hacks
-Documentation for sysrq.c version 1.15
-Last update: $Date: 2001/01/28 10:15:59 $
+Documentation for sysrq.c
+Last update: 2007-JAN-06
 
 *  What is the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -35,7 +35,7 @@ You can set the value in the file by the
 
 Note that the value of /proc/sys/kernel/sysrq influences only the invocation
 via a keyboard. Invocation of any operation via /proc/sysrq-trigger is always
-allowed.
+allowed (by a user with admin privileges).
 
 *  How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -58,7 +58,7 @@ On PowerPC - Press 'ALT - Print Screen (
 On other - If you know of the key combos for other architectures, please
            let me know so I can add them to this section.
 
-On all -  write a character to /proc/sysrq-trigger.  eg:
+On all -  write a character to /proc/sysrq-trigger.  e.g.:
 
 		echo t > /proc/sysrq-trigger
 
@@ -74,6 +74,8 @@ On all -  write a character to /proc/sys
 
 'c'	- Will perform a kexec reboot in order to take a crashdump.
 
+'d'	- Shows all locks that are held.
+
 'o'     - Will shut your system off (if configured and supported).
 
 's'     - Will attempt to sync all mounted filesystems.
@@ -87,38 +89,43 @@ On all -  write a character to /proc/sys
 
 'm'     - Will dump current memory info to your console.
 
+'n'	- Used to make RT tasks nice-able
+
 'v'	- Dumps Voyager SMP processor info to your console.
 
+'w'	- Dumps tasks that are in uninterruptable (blocked) state.
+
+'x'	- Used by xmon interface on ppc/powerpc platforms.
+
 '0'-'9' - Sets the console log level, controlling which kernel messages
           will be printed to your console. ('0', for example would make
           it so that only emergency messages like PANICs or OOPSes would
           make it to your console.)
 
-'f'	- Will call oom_kill to kill a memory hog process
+'f'	- Will call oom_kill to kill a memory hog process.
 
 'e'     - Send a SIGTERM to all processes, except for init.
 
-'i'     - Send a SIGKILL to all processes, except for init.
+'g'	- Used by kgdb on ppc platforms.
 
-'l'     - Send a SIGKILL to all processes, INCLUDING init. (Your system
-          will be non-functional after this.)
+'i'     - Send a SIGKILL to all processes, except for init.
 
-'h'     - Will display help ( actually any other key than those listed
+'h'     - Will display help (actually any other key than those listed
           above will display help. but 'h' is easy to remember :-)
 
 *  Okay, so what can I use them for?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Well, un'R'aw is very handy when your X server or a svgalib program crashes.
 
-sa'K' (Secure Access Key) is useful when you want to be sure there are no
-trojan program is running at console and which could grab your password
-when you would try to login. It will kill all programs on given console
-and thus letting you make sure that the login prompt you see is actually
+sa'K' (Secure Access Key) is useful when you want to be sure there is no
+trojan program running at console which could grab your password
+when you would try to login. It will kill all programs on given console,
+thus letting you make sure that the login prompt you see is actually
 the one from init, not some trojan program.
 IMPORTANT: In its true form it is not a true SAK like the one in a :IMPORTANT
 IMPORTANT: c2 compliant system, and it should not be mistaken as   :IMPORTANT
 IMPORTANT: such.                                                   :IMPORTANT
-       It seems other find it useful as (System Attention Key) which is
+       It seems others find it useful as (System Attention Key) which is
 useful when you want to exit a program that will not let you switch consoles.
 (For example, X or a svgalib program.)
 
@@ -139,8 +146,8 @@ OK or Done message...)
 Again, the unmount (remount read-only) hasn't taken place until you see the
 "OK" and "Done" message appear on the screen.
 
-The loglevel'0'-'9' is useful when your console is being flooded with
-kernel messages you do not want to see. Setting '0' will prevent all but
+The loglevels '0'-'9' are useful when your console is being flooded with
+kernel messages you do not want to see. Selecting '0' will prevent all but
 the most urgent kernel messages from reaching your console. (They will
 still be logged if syslogd/klogd are alive, though.)
 
@@ -152,7 +159,7 @@ processes.
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 That happens to me, also. I've found that tapping shift, alt, and control
 on both sides of the keyboard, and hitting an invalid sysrq sequence again
-will fix the problem. (ie, something like alt-sysrq-z). Switching to another
+will fix the problem. (i.e., something like alt-sysrq-z). Switching to another
 virtual console (ALT+Fn) and then back again should also help.
 
 *  I hit SysRq, but nothing seems to happen, what's wrong?
@@ -174,11 +181,11 @@ handler function you will use, B) a help
 prints help, and C) an action_msg string, that will print right before your
 handler is called. Your handler must conform to the prototype in 'sysrq.h'.
 
-After the sysrq_key_op is created, you can call the macro 
-register_sysrq_key(int key, struct sysrq_key_op *op_p) that is defined in
-sysrq.h, this will register the operation pointed to by 'op_p' at table
-key 'key', if that slot in the table is blank. At module unload time, you must
-call the macro unregister_sysrq_key(int key, struct sysrq_key_op *op_p), which
+After the sysrq_key_op is created, you can call the kernel function
+register_sysrq_key(int key, struct sysrq_key_op *op_p); this will
+register the operation pointed to by 'op_p' at table key 'key',
+if that slot in the table is blank. At module unload time, you must call
+the function unregister_sysrq_key(int key, struct sysrq_key_op *op_p), which
 will remove the key op pointed to by 'op_p' from the key 'key', if and only if
 it is currently registered in that slot. This is in case the slot has been
 overwritten since you registered it.
@@ -186,15 +193,12 @@ overwritten since you registered it.
 The Magic SysRQ system works by registering key operations against a key op
 lookup table, which is defined in 'drivers/char/sysrq.c'. This key table has
 a number of operations registered into it at compile time, but is mutable,
-and 4 functions are exported for interface to it: __sysrq_lock_table,
-__sysrq_unlock_table, __sysrq_get_key_op, and __sysrq_put_key_op. The
-functions __sysrq_swap_key_ops and __sysrq_swap_key_ops_nolock are defined
-in the header itself, and the REGISTER and UNREGISTER macros are built from
-these. More complex (and dangerous!) manipulations of the table are possible
-using these functions, but you must be careful to always lock the table before
-you read or write from it, and to unlock it again when you are done. (And of
-course, to never ever leave an invalid pointer in the table). Null pointers in
-the table are always safe :)
+and 2 functions are exported for interface to it:
+	register_sysrq_key and unregister_sysrq_key.
+Of course, never ever leave an invalid pointer in the table. I.e., when
+your module that called register_sysrq_key() exits, it must call
+unregister_sysrq_key() to clean up the sysrq key table entry that it used.
+Null pointers in the table are always safe. :)
 
 If for some reason you feel the need to call the handle_sysrq function from
 within a function called by handle_sysrq, you must be aware that you are in
