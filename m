Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbTHXQse (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 12:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261240AbTHXQse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 12:48:34 -0400
Received: from adsl-217-226.38-151.net24.it ([151.38.226.217]:60941 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S261253AbTHXQsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 12:48:32 -0400
Date: Sun, 24 Aug 2003 18:48:29 +0200
From: Daniele Venzano <webvenza@libero.it>
To: davej@codemonkey.org.uk
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       cpufreq@www.linux.org.uk
Subject: Athlon XP-M and cpufreq freezing Asus laptop to death
Message-ID: <20030824164828.GA922@renditai.milesteg.arr>
Mail-Followup-To: davej@codemonkey.org.uk,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	cpufreq@www.linux.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.21
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if I'm hunting a bug or I have to add support for my
hardware somewhere.
I succeded in making C2 work adjusting the DSDT table, I'm uploading the 
new one on acpi.sf.net under Asus/L3100D

Now for cpufreq: I'm using the powernow-k7 driver, since the acpi 
P-state is not supported.
Whenever I try to change the governor by echoing "powersave" in
/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor everything stops
and a hard reset is required. It seemes to fall in some tight loop since
after a few seconds the fan goes on as if there is heavy processor
usage.

With some printk I have verified that it halts inside wrmsrl() at line
199, file powernow-k7.c (2.6.0-test4).
The call trace is:
powernow_target/change_speed/change_FID/wrmsrl

For what is my knowledge (very, very little) the frequency passed to
powernow_target is right, but I can't say nothing on all other
parameters...

Full dmesg and .config available here[2] and here[3], /proc/cpuinfo 
and /proc/acpi/processor/CPU0/{power,info} follows.

/proc/cpuinfo
processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 6
model		: 8
model name	: mobile AMD Athlon(tm) XP-M 2000+
stepping	: 1
cpu MHz		: 1673.782
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr sse syscall mp mmxext 3dnowext 3dnow
bogomips	: 3309.56

/proc/acpi/processor/CPU0/power
active state:            C2
default state:           C1
bus master activity:     00000000
states:
    C1:                  promotion[C2] demotion[--] latency[000] usage[00653320]
   *C2:                  promotion[--] demotion[C1] latency[090] usage[04958506]
    C3:                  <not supported>

/proc/acpi/processor/CPU0/info
processor id:            0
acpi id:                 1
bus mastering control:   no
power management:        yes
throttling control:      yes
performance management:  no
limit interface:         yes

Using the acpi p state driver I get a message saying something about
'unsupported address space' (see [1] for details) and the machine
stops working also by echoing 'performance' (that is already there) in
sysfs.

I don't know what to do next, someone here can give me any hint ?

Thanks for any help on this matter.

[1] http://www.ussg.lu.edu/hypermail/linux/kernel/0308.2/1892.html
[2] http://digilander.libero.it/webvenza/download/kpatches/dmesg-cpufreq
[3] http://digilander.libero.it/webvenza/download/kpatches/config-cpufreq


-- 
----------------------------------------
Daniele Venzano
Web: http://digilander.iol.it/webvenza/

