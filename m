Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262581AbTCIT2D>; Sun, 9 Mar 2003 14:28:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262585AbTCIT1A>; Sun, 9 Mar 2003 14:27:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37394 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262581AbTCIT0T>; Sun, 9 Mar 2003 14:26:19 -0500
Date: Sun, 9 Mar 2003 19:36:56 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Fwd: [PATCH] cpufreq (7/7): update documentation
Message-ID: <20030309193656.H26266@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Dominik Brodowski <linux@brodo.de> -----

From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: cpufreq@www.linux.org.uk
Subject: [PATCH] cpufreq (7/7): update documentation
Date: Fri, 7 Mar 2003 11:09:28 +0100

The sysfs directory where the cpufreq-related files are stored changed due
to the new device interface code, so the documentation needs to be updated
accordingly. Also, add some information about the reference counting and the
exporting of sysfs files by the drivers.

Please apply,
	Dominik

 core.txt        |    4 ++++
 cpu-drivers.txt |    3 +++
 user-guide.txt  |    8 ++++----
 3 files changed, 11 insertions(+), 4 deletions(-)


diff -ruN linux-original/Documentation/cpu-freq/core.txt linux/Documentation/cpu-freq/core.txt
--- linux-original/Documentation/cpu-freq/core.txt	2003-03-06 19:13:31.000000000 +0100
+++ linux/Documentation/cpu-freq/core.txt	2003-03-06 22:05:27.000000000 +0100
@@ -35,6 +35,10 @@
 kernel "constant" loops_per_jiffy is updated on frequency changes
 here.
 
+Reference counting is done by cpufreq_get_cpu and cpufreq_put_cpu,
+which make sure that the cpufreq processor driver is correctly
+registered with the core, and will not be unloaded until
+cpufreq_put_cpu is called.
 
 2. CPUFreq notifiers
 ====================
diff -ruN linux-original/Documentation/cpu-freq/cpu-drivers.txt linux/Documentation/cpu-freq/cpu-drivers.txt
--- linux-original/Documentation/cpu-freq/cpu-drivers.txt	2003-03-06 19:13:31.000000000 +0100
+++ linux/Documentation/cpu-freq/cpu-drivers.txt	2003-03-06 23:15:39.000000000 +0100
@@ -63,6 +63,9 @@
 
 cpufreq_driver.exit -		A pointer to a per-CPU cleanup function.
 
+cpufreq_driver.attr -		A pointer to a NULL-terminated list of
+				"struct freq_attr" which allow to
+				export values to sysfs.
 
 
 1.2 Per-CPU Initialization
diff -ruN linux-original/Documentation/cpu-freq/user-guide.txt linux/Documentation/cpu-freq/user-guide.txt
--- linux-original/Documentation/cpu-freq/user-guide.txt	2003-03-06 19:13:31.000000000 +0100
+++ linux/Documentation/cpu-freq/user-guide.txt	2003-03-06 22:08:21.000000000 +0100
@@ -114,9 +114,9 @@
 ------------------------------
 
 The preferred interface is located in the sysfs filesystem. If you
-mounted it at /sys, the cpufreq interface is located in the 
-cpu-device directory (e.g. /sys/devices/sys/cpu0/ for the first
-CPU).
+mounted it at /sys, the cpufreq interface is located in a subdirectory
+"cpufreq" within the cpu-device directory
+(e.g. /sys/devices/sys/cpu0/cpufreq/ for the first CPU).
 
 cpuinfo_min_freq :		this file shows the minimum operating
 				frequency the processor can run at(in kHz) 
@@ -125,7 +125,7 @@
 scaling_driver :		this file shows what cpufreq driver is
 				used to set the frequency on this CPU
 
-available_scaling_governors :	this file shows the CPUfreq governors
+scaling_available_governors :	this file shows the CPUfreq governors
 				available in this kernel. You can see the
 				currently activated governor in
 

_______________________________________________
Cpufreq mailing list
Cpufreq@www.linux.org.uk
http://www.linux.org.uk/mailman/listinfo/cpufreq

----- End forwarded message -----

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

