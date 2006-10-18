Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422780AbWJRTna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422780AbWJRTna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 15:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422789AbWJRTna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 15:43:30 -0400
Received: from bizon.gios.gov.pl ([212.244.124.8]:55229 "EHLO
	bizon.gios.gov.pl") by vger.kernel.org with ESMTP id S1422780AbWJRTn3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 15:43:29 -0400
Date: Wed, 18 Oct 2006 21:43:16 +0200 (CEST)
From: Krzysztof Oledzki <olel@ans.pl>
X-X-Sender: olel@bizon.gios.gov.pl
To: linux-kernel@vger.kernel.org, cpufreq@lists.linux.org.uk
Subject: 3.2GHz cpus with cpufreq become 2.8GHz
Message-ID: <Pine.LNX.4.64.0610182133130.29935@bizon.gios.gov.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-187430788-1139018627-1161200596=:29935"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---187430788-1139018627-1161200596=:29935
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello,

I have just noticed that enabling cpufreq on my Dell PowerEdge 1425SC=20
changes my secondary cpu clock to 2.8GHz.

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6403.72

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 3200.000
cache size      : 2048 KB
physical id     : 0
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.24

processor       : 2
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 2800.000
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.30

processor       : 3
vendor_id       : GenuineIntel
cpu family      : 15
model           : 4
model name      : Intel(R) Xeon(TM) CPU 3.20GHz
stepping        : 3
cpu MHz         : 2800.000
cache size      : 2048 KB
physical id     : 3
siblings        : 2
core id         : 0
cpu cores       : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 5
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca =
cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm consta=
nt_tsc pni monitor ds_cpl cid cx16 xtpr
bogomips        : 6400.29

According to cpuinfo the primary CPU (two HT logical CPUs) works with=20
3.2GHz clock but the secondary works with 2.8GHz.

What is also strange, this 3.2GHz freq is not listed on=20
scaling_available_frequencies for both CPUs:

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
p4-clockmod

# cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies
350000 700000 1050000 1400000 1750000 2100000 2450000 2800000

# cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_driver
p4-clockmod
# cat /sys/devices/system/cpu/cpu2/cpufreq/scaling_available_frequencies
350000 700000 1050000 1400000 1750000 2100000 2450000 2800000

I can confirm that this problem exists on 2.6.16/2.6.17/2.6.18 (just=20
tested). Is it a problem with BIOS or p4-clockmod cpufreq driver?

Best regards,


 =09=09=09=09Krzysztof Ol=EAdzki
---187430788-1139018627-1161200596=:29935--
