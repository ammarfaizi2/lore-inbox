Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWEHWt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWEHWt2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750827AbWEHWt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:49:28 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:10032 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750785AbWEHWt2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:49:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=MPDQh3+3qNCXZXg5Ilx+Jb7iaCJMHTyeOOP03yZiVd1ehAI70UT/dwz3iwD/jIkenNd1PrfbT/xN2PZk7VuvqFazhVhJSz5Gn5bp+SzsN93zPFKCA4Kxj7r3oUtbvI8g2mJ2yquUhNeq2e0xFjhUbg2vsZNL1OJCQOdiUdFH6LI=
Date: Tue, 9 May 2006 00:48:37 +0200
From: Diego Calleja <diegocg@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] Update/kill Documentation/sysctl/* docs?
Message-Id: <20060509004837.d542d2d8.diegocg@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In http://bugzilla.kernel.org/show_bug.cgi?id=6145 you asked to update
the sysctl docs. I've updated them and added/deleted the neccesary
stuff (except the ones that I don't know what on earth are they doing
because they're not...documented). However it looks like there's
duplication - Documentation/filesystems/proc.txt seems to document all
that aswell (but in a single doc, which makes it a bit unreadable 
for such big document, IMO)

What should be the best step? Kill Documentation/sysctl/ and keep 
filesystems/proc.txt updated and maybe split it in several files
to make it more readable? Update it but maintain in sync with
filesystems/proc.txt? delete proc.txt and keep sysctl/ updated...?


--- temp/Documentation/sysctl/fs.txt.old	2006-05-09 00:34:32.000000000 +0200
+++ temp/Documentation/sysctl/fs.txt	2006-05-09 00:09:03.000000000 +0200
@@ -1,4 +1,4 @@
-Documentation for /proc/sys/fs/*	kernel version 2.2.10
+Documentation for /proc/sys/fs/*
 	(c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
 
 For general info and legal blurb, please look in README.
@@ -6,7 +6,7 @@
 ==============================================================
 
 This file contains documentation for the sysctl files in
-/proc/sys/fs/ and is valid for Linux kernel version 2.2.
+/proc/sys/fs/
 
 The files in this directory can be used to tune and monitor
 miscellaneous and general things in the operation of the Linux
@@ -15,21 +15,29 @@
 before actually making adjustments.
 
 Currently, these files are in /proc/sys/fs:
+- aio-max-nr
+- aio-nr
+- binfmt_misc/ ==> see Documentation/binfmt_misc.txt
 - dentry-state
 - dquot-max
 - dquot-nr
+- dir-notify-enable
 - file-max
 - file-nr
-- inode-max
 - inode-nr
 - inode-state
+- inotify/ ==> See Documentation/filesystem/inotify.txt
 - overflowuid
 - overflowgid
-- super-max
-- super-nr
+- suid_dumpable
 
-Documentation for the files in /proc/sys/fs/binfmt_misc is
-in Documentation/binfmt_misc.txt.
+==============================================================
+
+aio-nr & aio-max-nr:
+
+aio-nr shows the current system-wide number of asynchronous io
+requests.  aio-max-nr allows you to change the maximum value
+aio-nr can grow to.
 
 ==============================================================
 
@@ -71,6 +79,21 @@
 
 ==============================================================
 
+dir-notify-enable:
+
+This file controls dnotify, a directory notification mechanism,
+and will not appear if dnotify support is compiled out. It was
+introduced with inotify (see Documentation/filesystems/inotify.txt)
+in case some people want to disable dnotify support at runtime.
+There're two possible values:
+
+1 - dnotify is enabled (default)
+0 - dnotify is disabled
+
+For more information about dnotify, see Documentation/dnotify.txt
+
+==============================================================
+
 file-max & file-nr:
 
 The kernel allocates file handles dynamically, but as yet it
@@ -90,17 +113,11 @@
 
 ==============================================================
 
-inode-max, inode-nr & inode-state:
+inode-nr & inode-state:
 
 As with file handles, the kernel allocates the inode structures
 dynamically, but can't free them yet.
 
-The value in inode-max denotes the maximum number of inode
-handlers. This value should be 3-4 times larger than the value
-in file-max, since stdin, stdout and network sockets also
-need an inode struct to handle them. When you regularly run
-out of inodes, you need to increase this value.
-
 The file inode-nr contains the first two items from
 inode-state, so we'll skip to that file...
 
@@ -131,20 +148,21 @@
 
 ==============================================================
 
-super-max & super-nr:
-
-These numbers control the maximum number of superblocks, and
-thus the maximum number of mounted filesystems the kernel
-can have. You only need to increase super-max if you need to
-mount more filesystems than the current value in super-max
-allows you to.
-
-==============================================================
+suid_dumpable:
 
-aio-nr & aio-max-nr:
+This value can be used to query and set the core dump mode for setuid
+or otherwise protected/tainted binaries. The modes are
 
-aio-nr shows the current system-wide number of asynchronous io
-requests.  aio-max-nr allows you to change the maximum value
-aio-nr can grow to.
+0 - (default) - traditional behaviour. Any process which has changed
+    privilege levels or is execute only will not be dumped
+1 - (debug) - all processes dump core when possible. The core dump is
+    owned by the current user and no security is applied. This is
+    intended for system debugging situations only. Ptrace is unchecked.
+2 - (suidsafe) - any binary which normally would not be dumped is dumped
+    readable by root only. This allows the end user to remove
+    such a dump but not access it directly. For security reasons
+    core dumps in this mode will not overwrite one another or
+    other files. This mode is appropriate when adminstrators are
+    attempting to debug problems in a normal environment.
 
 ==============================================================

--- temp/Documentation/sysctl/kernel.txt.old	2006-05-09 00:34:39.000000000 +0200
+++ temp/Documentation/sysctl/kernel.txt	2006-05-09 00:24:15.000000000 +0200
@@ -1,4 +1,4 @@
-Documentation for /proc/sys/kernel/*	kernel version 2.2.10
+Documentation for /proc/sys/kernel/*
 	(c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
 
 For general info and legal blurb, please look in README.
@@ -6,7 +6,7 @@
 ==============================================================
 
 This file contains documentation for the sysctl files in
-/proc/sys/kernel/ and is valid for Linux kernel version 2.2.
+/proc/sys/kernel/
 
 The files in this directory can be used to tune and monitor
 miscellaneous and general things in the operation of the Linux
@@ -18,42 +18,47 @@
 show up in /proc/sys/kernel:
 - acpi_video_flags
 - acct
+- bootloader_type
+- cad_pid
+- cap-bound
 - core_pattern
 - core_uses_pid
 - ctrl-alt-del
-- dentry-state
 - domainname
 - hostname
 - hotplug
-- java-appletviewer           [ binfmt_java, obsolete ]
-- java-interpreter            [ binfmt_java, obsolete ]
 - l2cr                        [ PPC only ]
 - modprobe                    ==> Documentation/kmod.txt
 - msgmax
 - msgmnb
 - msgmni
+- ngroups_max
 - osrelease
 - ostype
 - overflowgid
 - overflowuid
 - panic
+- panic_on_oops
 - pid_max
 - powersave-nap               [ PPC only ]
 - printk
+- printk_ratelimit
+- printk_ratelimit_burst
+- pty/ ==> TODO
+- random ==> TODO
+- randomize_va_space
 - real-root-dev               ==> Documentation/initrd.txt
 - reboot-cmd                  [ SPARC only ]
-- rtsig-max
-- rtsig-nr
 - sem
 - sg-big-buff                 [ generic SCSI device (sg) ]
 - shmall
 - shmmax                      [ sysv ipc ]
 - shmmni
 - stop-a                      [ SPARC only ]
-- suid_dumpable
 - sysrq                       ==> Documentation/sysrq.txt
 - tainted
 - threads-max
+- unknown_nmi_panic
 - version
 
 ==============================================================
@@ -84,6 +89,24 @@
 
 ==============================================================
 
+bootloader_type:
+
+TODO
+
+==============================================================
+
+cad_pid:
+
+TODO
+
+==============================================================
+
+cap-bound:
+
+TODO
+
+==============================================================
+
 core_pattern:
 
 core_pattern is used to specify a core dumpfile pattern name.
@@ -168,6 +191,12 @@
 
 ==============================================================
 
+ngroups_max:
+
+TODO
+
+==============================================================
+
 osrelease, ostype & version:
 
 # cat osrelease
@@ -271,6 +300,12 @@
 
 ==============================================================
 
+randomize_va_space:
+
+TODO
+
+==============================================================
+
 reboot-cmd: (Sparc only)
 
 ??? This seems to be a way to give an argument to the Sparc
@@ -311,25 +346,6 @@
 
 ==============================================================
 
-suid_dumpable:
-
-This value can be used to query and set the core dump mode for setuid
-or otherwise protected/tainted binaries. The modes are
-
-0 - (default) - traditional behaviour. Any process which has changed
-	privilege levels or is execute only will not be dumped
-1 - (debug) - all processes dump core when possible. The core dump is
-	owned by the current user and no security is applied. This is
-	intended for system debugging situations only. Ptrace is unchecked.
-2 - (suidsafe) - any binary which normally would not be dumped is dumped
-	readable by root only. This allows the end user to remove
-	such a dump but not access it directly. For security reasons
-	core dumps in this mode will not overwrite one another or
-	other files. This mode is appropriate when adminstrators are
-	attempting to debug problems in a normal environment.
-
-==============================================================
-
 tainted: 
 
 Non-zero if the kernel has been tainted.  Numeric values, which
@@ -342,3 +358,10 @@
       Set by modutils >= 2.4.9 and module-init-tools.
   4 - Unsafe SMP processors: SMP with CPUs not designed for SMP.
 
+==============================================================
+
+unknown_nmi_panic:
+
+TODO
+
+==============================================================
