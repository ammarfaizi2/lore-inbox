Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261609AbSJUUTp>; Mon, 21 Oct 2002 16:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSJUUTp>; Mon, 21 Oct 2002 16:19:45 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57775 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261609AbSJUUTn>;
	Mon, 21 Oct 2002 16:19:43 -0400
Date: Mon, 21 Oct 2002 13:23:17 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] configurable corename: sysctl docs.
In-Reply-To: <Pine.LNX.4.33L2.0210122002480.11896-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0210211317490.29900-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Oct 2002, Randy.Dunlap wrote:

| On Sun, 13 Oct 2002, Linux Kernel Mailing List wrote:
|
| | ChangeSet 1.824, 2002/10/12 17:19:08-07:00, alan@lxorguk.ukuu.org.uk
| |
| | 	[PATCH] configurable corename
| |
| | 	To my suprise a lot of big site/beowulf type people all really want this
| | 	diff, which I'd otherwise filed as 'interesting but not important'
|
| a additional patch to linux/Documentation/{core|dump}.txt (e.g.)
| or Documentation/sysctl/kernel.txt sure would be nice.  :)

Here's an addition to Documentation/sysctl/kernel.txt for
core_uses_pid and core_pattern plus a few other corrections.

Comments on it?

otherwise: Alan, Rik, Andrew, Dave, anybody?  Please apply to 2.5.45.

Thanks,
-- 
~Randy



--- ./Documentation/sysctl/kernel.txt.core	Fri Oct 18 21:01:55 2002
+++ ./Documentation/sysctl/kernel.txt	Mon Oct 21 13:20:50 2002
@@ -17,29 +17,42 @@
 Currently, these files might (depending on your configuration)
 show up in /proc/sys/kernel:
 - acct
+- core_pattern
+- core_uses_pid
 - ctrl-alt-del
 - dentry-state
 - domainname
 - hostname
 - htab-reclaim                [ PPC only ]
+- hotplug
 - java-appletviewer           [ binfmt_java, obsolete ]
 - java-interpreter            [ binfmt_java, obsolete ]
 - l2cr                        [ PPC only ]
 - modprobe                    ==> Documentation/kmod.txt
+- msgmax
+- msgmnb
+- msgmni
 - osrelease
 - ostype
 - overflowgid
 - overflowuid
 - panic
+- pid_max
 - powersave-nap               [ PPC only ]
 - printk
 - real-root-dev               ==> Documentation/initrd.txt
 - reboot-cmd                  [ SPARC only ]
-- rtsig-nr
 - rtsig-max
+- rtsig-nr
+- sem
 - sg-big-buff                 [ generic SCSI device (sg) ]
+- shmall
 - shmmax                      [ sysv ipc ]
+- shmmni
+- stop-a                      [ SPARC only ]
+- sysrq                       ==> Documentation/sysrq.txt
 - tainted
+- threads-max
 - version
 - zero-paged                  [ PPC only ]

@@ -62,6 +75,41 @@

 ==============================================================

+core_pattern:
+
+core_pattern is used to specify a core dumpfile pattern name.
+. max length 64 characters; default value is "core"
+. core_pattern is used as a pattern template for the output filename;
+  certain string patterns (beginning with '%') are substituted with
+  their actual values.
+. backward compatibility with core_uses_pid:
+	If core_pattern does not include "%p" (default does not)
+	and core_uses_pid is set, then .PID will be appended to
+	the filename.
+. corename format specifiers:
+	%<NUL>	'%' is dropped
+	%%	output one '%'
+	%p	pid
+	%u	uid
+	%g	gid
+	%s	signal number
+	%t	UNIX time of dump
+	%h	hostname
+	%e	executable filename
+	%<OTHER> both are dropped
+
+==============================================================
+
+core_uses_pid:
+
+The default coredump filename is "core".  By setting
+core_uses_pid to 1, the coredump filename becomes core.PID.
+If core_pattern does not include "%p" (default does not)
+and core_uses_pid is set, then .PID will be appended to
+the filename.
+
+==============================================================
+
 ctrl-alt-del:

 When the value in this file is 0, ctrl-alt-del is trapped and
@@ -105,6 +153,13 @@

 ==============================================================

+hotplug:
+
+Path for the hotplug policy agent.
+Default value is "/sbin/hotplug".
+
+==============================================================
+
 l2cr: (PPC only)

 This flag controls the L2 cache of G3 processor boards. If
@@ -149,6 +204,14 @@

 ==============================================================

+pid_max:
+
+PID allocation wrap value.  When the kenrel's next PID value
+reaches this value, it wraps back to a minimum PID value.
+PIDs of value pid_max or larger are not allocated.
+
+==============================================================
+
 powersave-nap: (PPC only)

 If set, Linux-PPC will use the 'nap' mode of powersaving,
@@ -195,7 +258,7 @@
 of POSIX realtime (queued) signals that can be outstanding
 in the system.

-Rtsig-nr shows the number of RT signals currently queued.
+rtsig-nr shows the number of RT signals currently queued.

 ==============================================================

@@ -231,6 +294,7 @@
       Set by modutils >= 2.4.9.
   2 - A module was force loaded by insmod -f.
       Set by modutils >= 2.4.9.
+  4 - Unsafe SMP processors: SMP with CPUs not designed for SMP.

 ==============================================================


