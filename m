Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264501AbUEJDbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264501AbUEJDbt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 23:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUEJDbt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 23:31:49 -0400
Received: from main.gmane.org ([80.91.224.249]:15240 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264501AbUEJDa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 23:30:59 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Erik Meitner <usenet@kwax.hn.org>
Subject: Re: Athlon Mobile XP CPU speed problem
Date: Sun, 09 May 2004 22:26:39 -0500
Message-ID: <c7msu2$onb$1@sea.gmane.org>
References: <200404091723.55628.andre@ironcreek.net> <20040506100512.GA226@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: mdsnwi13-vlan446-68.dsl.tds.net
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
In-Reply-To: <20040506100512.GA226@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 
>>My notebook [1], powered by a AMD Athlon XP2400+ (k7) is slowing down when 
>>running on battery. This happens regardless of whether or not cpu frequency 
>>scaling is enabled or not. /proc/cpuinfo still shows maximum frequency, but 
>>the computer is definitely slowed down considerably.
> 
> 
> That may well be bios feature. Maybe battery is not even able to get
> you enough juice for full speed....
> 									Pavel

I have also noticed the same problem. I have an HP nx9005(model DK993A
with an AMD XP-M 2400+) installed with Debian/testing and kernel 2.6.4 
and 2.6.5. ACPI is used for power management.

When powered by AC the system performance is excellent. When powered by
battery, the system is so sluggish that I prefer to just not use it. It
is like it was running at 200 MHz.
This occurs with frequency scaling turned OFF and the CPU running at
1788MHz.

ONLY when I reboot with acpi=off does this behavior not occur - of 
course all other power management is off too.

Note the differences in the results of the bogomips benchmark below. Let 
   me know if any other information is needed.

Thanks,
Erik



Relevant lines from kernel messages:


On AC power with ACPI:
============
============

nx9:~# bogomips
Calibrating delay loop.. ok - 1760.00 BogoMips

/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:
1795500
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:
532000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:
532000 665000 798000 931000 1330000 1795500:
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:
powersave userspace performance
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:
powernow-k7
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:
performance
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:
1795500
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:
532000

/proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : mobile AMD Athlon(tm) XP2400+
stepping        : 0
cpu MHz         : 1788.828
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3538.94


nx9:/proc/acpi/processor/CPU0# more *
::::::::::::::
info
::::::::::::::
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
limit interface:         no
::::::::::::::
limit
::::::::::::::
<not supported>
::::::::::::::
power
::::::::::::::
active state:            C2
default state:           C1
bus master activity:     00000000
states:
     C1:                  promotion[C2] demotion[--] latency[000]
usage[00029760]
    *C2:                  promotion[--] demotion[C1] latency[100]
usage[00418342]
     C3:                  <not supported>
::::::::::::::
throttling
::::::::::::::
<not supported>



On battery power with ACPI:
================
================

nx9:~# bogomips
Calibrating delay loop.. ok - 612.00 BogoMips

/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq:
1795500
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq:
532000
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies:
532000 665000 798000 931000 1330000 1795500
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors:
powersave userspace performance
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_driver:
powernow-k7
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor:
performance
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq:
1795500
::::::::::::::
/sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq:
532000

cat /proc/cpuinfo:
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : mobile AMD Athlon(tm) XP2400+
stepping        : 0
cpu MHz         : 1788.828
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips        : 3538.94


nx9:/proc/acpi/processor/CPU0# more *
::::::::::::::
info
::::::::::::::
processor id:            0
acpi id:                 0
bus mastering control:   yes
power management:        yes
throttling control:      no
limit interface:         no
::::::::::::::
limit
::::::::::::::
<not supported>
::::::::::::::
power
::::::::::::::
active state:            C2
default state:           C1
bus master activity:     00000000
states:
     C1:                  promotion[C2] demotion[--] latency[000]
usage[00028280]
    *C2:                  promotion[--] demotion[C1] latency[100]
usage[00379537]
     C3:                  <not supported>
::::::::::::::
throttling
::::::::::::::
<not supported>


On battery power without ACPI:
================
================
nx9:~# bogomips
Calibrating delay loop.. ok - 1760.00 BogoMips



