Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264872AbTFCJvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 05:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264884AbTFCJvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 05:51:17 -0400
Received: from camus.xss.co.at ([194.152.162.19]:17934 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S264872AbTFCJvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 05:51:13 -0400
Message-ID: <3EDC72B3.9040109@xss.co.at>
Date: Tue, 03 Jun 2003 12:04:35 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: george anzinger <george@mvista.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: system clock speed too high?
References: <3EDBA83B.5050406@xss.co.at> <3EDBB4B0.6070601@mvista.com>
In-Reply-To: <3EDBB4B0.6070601@mvista.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

george anzinger wrote:
> Andreas Haumer wrote:
>
[...]
>> I have a quite strange phenomenon here: I see a ~2.5 times
>> speed up of system time on a Asus AP1700-S5 server with
>> Linux-2.4.21-rc6-ac1.
>> Simple proof: a "sleep 300" command terminates after exactly
>> 120 seconds of wall clock time.
>
>
> Just as a wild shot in the dark, what speed does the kernel think the
> cpu is running at and does this match what the BIOS thinks?
>
> It sounds like the CLOCK_TICK_RATE is wrong.  This would show up as the
> kernel thinking the cpu was fast also.
>
Hm, I don't think this is the case.
BIOS reports (correctly) a single, hyperthreaded Xeon CPU
with 2.4GHz

Kernel reports the same:
root@setup:~ {503} $ uname -a
Linux setup 2.4.21-rc6-ac1 #2 SMP Tue Jun 3 09:45:13 CEST 2003 i686 unknown

root@setup:~ {504} $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.065
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

processor       : 1
vendor_id       : GenuineIntel
cpu family      : 15
model           : 2
model name      : Intel(R) Xeon(TM) CPU 2.40GHz
stepping        : 7
cpu MHz         : 2392.065
cache size      : 512 KB
physical id     : 0
siblings        : 2
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips        : 4771.02

root@setup:~ {505} $ ntpdate ntp.xss.co.at; sleep 500; ntpdate ntp.xss.co.at
 3 Jun 11:58:16 ntpdate[1118]: step time server 194.152.162.17 offset -177.268071 sec
 3 Jun 12:01:36 ntpdate[1120]: step time server 194.152.162.17 offset -300.106769 sec

(Sleeping 500 "system seconds" takes 200 "wall clock seconds")

> You pin this to a particular kernel version.  Do other kernel versions
> do a better job?
>
So far I tried with:

2.4.21-rc2-ac2 (ACPI compiled as module)
2.4.21-rc4 (ACPI compiled as module)
2.4.21-rc6-ac1 (ACPI compiled as module)
2.4.21-rc6-ac1 (no ACPI comiled at all)

Time acceleration is the same for all kernels.

I'll try it with some older kernels, too.

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3HKxxJmyeGcXPhERAkZ/AJ9tjgI6K2HtM/tL15nKDFIKzdcvQgCfYOGY
i96/o6Nyxlem5yOp1A2Q//s=
=plFh
-----END PGP SIGNATURE-----

