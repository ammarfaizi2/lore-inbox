Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbRCJBBm>; Fri, 9 Mar 2001 20:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130796AbRCJBBc>; Fri, 9 Mar 2001 20:01:32 -0500
Received: from linuxcare.com.au ([203.29.91.49]:30476 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130794AbRCJBBX>; Fri, 9 Mar 2001 20:01:23 -0500
From: Anton Blanchard <anton@linuxcare.com.au>
Date: Sat, 10 Mar 2001 11:58:29 +1100
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH]: allow notsc option for buggy cpus
Message-ID: <20010310115828.A7514@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

My IBM Thinkpad 600E changes between 100MHz and 400MHz depending if the
power is on. This means gettimeofday goes backwards if you boot with the
power out (tsc calibrated at 100MHz) and then plug the power in. (tsc is now
spinning at 4x speed, so offsets within the HZ timer period are 4x out!).

The answer is to boot with the notsc option, however since the
CONFIG_X86_TSC option is enabled for CONFIG_M686, we cannot do this. Saving
one indirect function call for do_gettimeofset is not enough of a reason for
CONFIG_X86_TSC. Should we trash this option?

Even so, we should really catch these cpus at run time. 

Anton


--- linux/arch/i386/config.in	Wed Jan 10 12:19:57 2001
+++ linux_intel/arch/i386/config.in	Fri Mar  9 07:59:39 2001
@@ -80,7 +80,6 @@
 fi
 if [ "$CONFIG_M686" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
-   define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y


# cat /proc/cpuinfo
processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 6
model name	: Mobile Pentium II
stepping	: 10
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr
bogomips	: 104.44
