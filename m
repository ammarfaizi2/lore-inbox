Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131842AbRA1LMs>; Sun, 28 Jan 2001 06:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136067AbRA1LMi>; Sun, 28 Jan 2001 06:12:38 -0500
Received: from [216.233.172.106] ([216.233.172.106]:58375 "EHLO
	foozle.axistangent.net") by vger.kernel.org with ESMTP
	id <S131842AbRA1LM3>; Sun, 28 Jan 2001 06:12:29 -0500
Date: Sun, 28 Jan 2001 05:11:18 -0600
From: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] doc update/fixes for sysrq.txt
Message-ID: <20010128051118.A7975@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updates Documentation/sysrq.txt for 2.4's behavior and cleans up a bit.

/jmd

--- linux-2.4.0-ac12/Documentation/sysrq.txt	Fri Jul 28 14:50:52 2000
+++ linux-2.4.0-ac12-jmd/Documentation/sysrq.txt	Sun Jan 28 04:15:59 2001
@@ -1,26 +1,27 @@
+Linux Magic System Request Key Hacks
+Documentation for sysrq.c version 1.15
+Last update: $Date: 2001/01/28 10:15:59 $
 
-                      MAGIC SYSRQ KEY DOCUMENTATION v1.32
-                     ------------------------------------
-                        [Sat Apr  8 22:15:03 CEST 2000]
-
-*  What is the magic SysRQ key?
+*  What is the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-It is a 'magical' key combo you can hit which kernel will respond to
+It is a 'magical' key combo you can hit which the kernel will respond to
 regardless of whatever else it is doing, unless it is completely locked up.
 
-*  How do I enable the magic SysRQ key?
+*  How do I enable the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 You need to say "yes" to 'Magic SysRq key (CONFIG_MAGIC_SYSRQ)' when
-configuring the kernel. This option is only available in 2.1.x or later
-kernels. Once you boot the new kernel, you need to enable it manually 
-using following command:
+configuring the kernel. When running on a kernel with SysRq compiled in, it
+may be DISABLED at run-time using following command:
+
+        echo "0" > /proc/sys/kernel/sysrq
 
-	 echo "1" > /proc/sys/kernel/sysrq
+Note that previous versions disabled sysrq by default, and you were required
+to specifically enable it at run-time. That is not the case any longer.
 
-*  How do I use the magic SysRQ key?
+*  How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-On x86   - You press the key combo 'ALT-SysRQ-<command key>'. Note - Some
-           (older?) may not have a key labeled 'SysRQ'. The 'SysRQ' key is
+On x86   - You press the key combo 'ALT-SysRq-<command key>'. Note - Some
+           keyboards may not have a key labeled 'SysRq'. The 'SysRq' key is
            also known as the 'Print Screen' key.
 
 On SPARC - You press 'ALT-STOP-<command key>', I believe.
@@ -30,14 +31,14 @@
            BREAK twice is interpreted as a normal BREAK.
 
 On other - If you know of the key combos for other architectures, please
-           let me know so I can add them to this section. 
+           let me know so I can add them to this section.
 
 *  What are the 'command' keys?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 'r'     - Turns off keyboard raw mode and sets it to XLATE.
 
-'k'     - Secure Access Key (SAK) Kills all programs on the current virtual 
-	  console. NOTE: See important comments below in SAK section.
+'k'     - Secure Access Key (SAK) Kills all programs on the current virtual
+          console. NOTE: See important comments below in SAK section.
 
 'b'     - Will immediately reboot the system without syncing or unmounting
           your disks.
@@ -67,8 +68,8 @@
 'l'     - Send a SIGKILL to all processes, INCLUDING init. (Your system
           will be non-functional after this.)
 
-'h'	- Will display help ( actually any other key than those listed
-	  above will display help. but 'h' is easy to remember :-)
+'h'     - Will display help ( actually any other key than those listed
+          above will display help. but 'h' is easy to remember :-)
 
 *  Okay, so what can I use them for?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -80,8 +81,8 @@
 and thus letting you make sure that the login prompt you see is actually
 the one from init, not some trojan program.
 IMPORTANT:In its true form it is not a true SAK like the one in   :IMPORTANT
-IMPORTATN:c2 compliant systems, and it should be mistook as such. :IMPORTANT
-	It seems other find it useful as (System Attention Key) which is
+IMPORTANT:c2 compliant systems, and it should be mistook as such. :IMPORTANT
+       It seems other find it useful as (System Attention Key) which is
 useful when you want to exit a program that will not let you switch consoles.
 (For example, X or a svgalib program.)
 
@@ -90,7 +91,7 @@
 
 'S'ync is great when your system is locked up, it allows you to sync your
 disks and will certainly lessen the chance of data loss and fscking. Note
-that the sync hasn't taken place until you see the "OK" and "Done" appear 
+that the sync hasn't taken place until you see the "OK" and "Done" appear
 on the screen. (If the kernel is really in strife, you may not ever get the
 OK or Done message...)
 
@@ -108,30 +109,31 @@
 are unable to kill any other way, especially if it's spawning other
 processes.
 
-*  Sometimes SysRQ seems to get 'stuck' after using it, what can I do?
+*  Sometimes SysRq seems to get 'stuck' after using it, what can I do?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 That happens to me, also. I've found that tapping shift, alt, and control
 on both sides of the keyboard, and hitting an invalid sysrq sequence again
 will fix the problem. (ie, something like alt-sysrq-z). Switching to another
 virtual console (ALT+Fn) and then back again should also help.
 
-*  I hit SysRQ, but nothing seems to happen, what's wrong?
+*  I hit SysRq, but nothing seems to happen, what's wrong?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-There are some keyboards that send different scancodes for SysRQ than the
-pre-defined 0x54. So if SysRQ doesn't work out of the box for a certain 
-keyboard, run 'showkey -s' to find out the proper scancode sequence. Then 
-use 'setkeycodes <sequence> 84' to define this sequence to the usual SysRQ 
+There are some keyboards that send different scancodes for SysRq than the
+pre-defined 0x54. So if SysRq doesn't work out of the box for a certain
+keyboard, run 'showkey -s' to find out the proper scancode sequence. Then
+use 'setkeycodes <sequence> 84' to define this sequence to the usual SysRq
 code (84 is decimal for 0x54). It's probably best to put this command in a
-boot script. Oh, and by the way, you exit 'showkey' by not typing anything 
+boot script. Oh, and by the way, you exit 'showkey' by not typing anything
 for ten seconds.
 
 *  I have more questions, who can I ask?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 You may feel free to send email to myrdraal@deathsdoor.com, and I will
-respond as soon as possible. 
+respond as soon as possible.
  -Myrdraal
 
 *  Credits
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Written by Mydraal <myrdraal@deathsdoor.com>
 Updated by Adam Sulmicki <adam@cfar.umd.edu>
+Updated by Jeremy M. Dolan <jmd@turbogeek.org> 2001/01/28 10:15:59
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
