Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265959AbUAKT2d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 14:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265961AbUAKT2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 14:28:33 -0500
Received: from dotnetslash.net ([66.199.224.19]:32006 "EHLO
	mail.dotnetslash.net") by vger.kernel.org with ESMTP
	id S265959AbUAKT2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 14:28:30 -0500
Date: Sun, 11 Jan 2004 14:28:29 -0500
From: "Mark W. Alexander" <slash@dotnetslash.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.0->2.6.1 /proc/cpuinfo behavior change
Message-ID: <20040111192829.GA27147@dotnetslash.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not currently subscribed. Please cc: me on responses.

The behavior of /proc/cpuinfo on cpu frequency scaling has changed
between 2.6.0 and 2.6.1(-mm2). On 2.6.0, /proc/cpuinfo reports the cpu
MHz as set by scaling_setspeed, with bogo-mips numbers along traditional
values.

On 2.6.1-mm2, /proc/cpuinfo _always_ reports cpu MHz == cpuinfo_max_freq, with
bogo-mips values closer to the setting of scaling_setspeed.

In both cases, /proc/stat information appears appropriate to the actual
speed. (At least, AFAICT, that's where gKrellm get's it's info and it seems
to report correctly.)

I didn't glean anything from the changelogs that explains this behavior. Is
it a bug or a feature?

Example output:
########################### 2.6.0 ######################
bash-2.05b# uname -r
2.6.0-ze4400-3
bash-2.05b# echo 1800000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed 
bash-2.05b# cat /proc/cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: mobile AMD Athlon(tm) XP2200+
stepping	: 1
cpu MHz		: 1788.655
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3538.94

bash-2.05b# echo 532000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
bash-2.05b# cat /proc/cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: mobile AMD Athlon(tm) XP2200+
stepping	: 1
cpu MHz		: 529.971
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 1048.57

########################### 2.6.1-mm2 ######################
bash-2.05b# uname -r
2.6.1-mm2-ze4400-1
bash-2.05b# echo 1800000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed 
bash-2.05b# cat /proc/cpuinfo 
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: mobile AMD Athlon(tm) XP2200+
stepping	: 1
cpu MHz		: 1789.000
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 1777.66

bash-2.05b# echo 532000 >/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed 
bash-2.05b# cat /proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: mobile AMD Athlon(tm) XP2200+
stepping	: 1
cpu MHz		: 1789.000
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 526.71
-- 
Mark W. Alexander
slash@dotnetslash.net
