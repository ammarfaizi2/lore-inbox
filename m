Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWCVF1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWCVF1z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 00:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWCVF1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 00:27:55 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:6119 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750773AbWCVF1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 00:27:54 -0500
Message-ID: <4420DE54.1020004@t-online.de>
Date: Wed, 22 Mar 2006 06:19:16 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] wrong bogomips  values with kernel 2.6.16
References: <441FFB28.5050609@t-online.de> <Pine.LNX.4.64.0603211004250.3622@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603211004250.3622@g5.osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: Xdfi34ZlweIz3Ctfpx1LPRbJjdq4VpfTIlLuWm3muIMp7a9L3mr0g-@t-dialin.net
X-TOI-MSGID: 62f6d9d0-f58b-4942-8d02-9d0cc57c3ae6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds schrieb:

>That sounds correct. On x86, BogoMips these days is just a measure of how 
>fast the timestamp counter goes (multiplied by two for totally bogus 
>reasons), and a Pentium-M should have a fixed-frequency TSC that ticks at 
>the highest possible frequency of the CPU, regardless of what the real 
>frequency is.
>
>  
>
Pentium 4 and Xeon model 3 and above increment the time stamp counter
at a constant rate independent of the current cpu frequency.

All Pentium M, Xeon up to model 2 and the P6 family increment with every
internal processor cycle.

This behaviour is documented in chapter 18.8 of IA-32 Intel® Architecture
Software Developer’s Manual, Volume 3B: System Programming Guide,
Part 2, Order Number: 253669-018, January 2006.

Because of your false assumption of a fixed-frequency TSC, your
conclusions are false too. Scaling of the bogomips values should
really happen, but the start value is wrong. For 800 MHz there
should be a bogomips value of about 1598, for 1867 MHz a value
of about 3730.

You asked for a full /proc/cpuinfo, here it is ...


processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 13
model name : Intel(R) Pentium(R) M processor 1.86GHz
stepping : 8
cpu MHz : 800.000
cache size : 2048 KB
fdiv_bug : no
hlt_bug : no
f00f_bug : no
coma_bug : no
fpu : yes
fpu_exception : yes
cpuid level : 2
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat clflush dts acpi mmx fxsr sse sse2 ss tmpbe nx est tm2
bogomips : 3730.27

cu,
Knut

