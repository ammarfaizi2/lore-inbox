Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314035AbSDQDON>; Tue, 16 Apr 2002 23:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314037AbSDQDOM>; Tue, 16 Apr 2002 23:14:12 -0400
Received: from 216-55-134-41.dsl.san-diego.abac.net ([216.55.134.41]:11743
	"EHLO mail") by vger.kernel.org with ESMTP id <S314035AbSDQDOM>;
	Tue, 16 Apr 2002 23:14:12 -0400
Message-ID: <3CBCE87A.2080905@navpoint.com>
Date: Tue, 16 Apr 2002 23:14:02 -0400
From: Emilio Recio <polywog@navpoint.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Eriksson <nitrax@giron.wox.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon + VIA Crashing On Disk I/O
In-Reply-To: <Pine.LNX.4.33.0204160921060.472-100000@polywog.navpoint.com> <00dc01c1e58b$668dd2f0$0201a8c0@homer>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Eriksson wrote:

>First check out what kind of chipset you really have;
>lspci -xs 0:0
>should do the thing. Post the results.
>
>In the meantime, you can try to compile for
>"Pentium-Pro/Celeron/Pentium-II", and check your BIOS settings one more time
>(set stuff to "safe" values). Also, do you have a really recent kernel, such
>as 2.4.18? There were some changes in the Athlon/VIA "quirks" department a
>while ago, but after 2.4.15 (i think).
>

I think I tried the pentium stuff, but that would freeze up the computer 
too (the HD light comes on, and nothing else works, not even ping(!)) 
But I think that was for a <=2.4.14. I should try it again.

Here's the output of lspci:

polywog:~ # lspci -xs 0:0
00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133] 
(rev 03)
00: 06 11 05 03 06 00 10 22 03 00 00 06 00 08 00 00
10: 08 00 00 d0 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 a0 00 00 00 00 00 00 00 00 00 00 00

polywog:~ # lspci -xs 0:7.1
00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
00: 06 11 71 05 07 00 90 02 06 8a 01 01 00 20 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 c0 00 00 00 00 00 00 00 00 00 00 06 11 71 05
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 00 00 00

New news, I got up this morning and the computer was frozen again. This 
time, I compiled in the kernel (not as modules) SCSI, SCSI CD, SCSI 
Disk, PPA, completely removed ide-scsi stuff, compiled in ide-cdrom. So 
I took ide-scsi out of the loop altogether.

polywog:~ # cat /proc/cpuinfo
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 4
model name      : AMD Athlon(tm) Processor
stepping        : 2
cpu MHz         : 1199.714
cache size      : 256 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov
pat pse36 mmx fxsr syscall mmxext 3dnowext 3dnow
bogomips        : 2392.06

