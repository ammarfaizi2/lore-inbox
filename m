Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264675AbUD1Fuv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264675AbUD1Fuv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264678AbUD1Fuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:50:51 -0400
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:54212 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S264675AbUD1Fus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:50:48 -0400
Message-ID: <408F4632.2090705@inf.tu-dresden.de>
Date: Wed, 28 Apr 2004 07:50:42 +0200
From: Christoph Pohl <christoph.pohl@inf.tu-dresden.de>
Organization: TU Dresden, Dept. CS
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: de, en, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Jurriaan <thunder7@xs4all.nl>
Subject: Re: Low bogomips on IBM x445 (kernel 2.6.5)
References: <408E3D74.2090301@inf.tu-dresden.de> <20040427180117.GA2150@middle.of.nowhere>
In-Reply-To: <20040427180117.GA2150@middle.of.nowhere>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jurriaan wrote:
>>I'm currently configuring an IBM x445 box with 4 Xeon CPUs (3GHz) and 
>>hyperthreading enabled. Everything seems to work fine since kernel 2.6.5 
>>but I keep wondering about the *very low* Bogomips numbers. Here is what 
>>I see in /proc/cpuinfo:
>>
> 
> What does 
> 
> cat /proc/mtrr

reg00: base=0x00000000 (   0MB), size=2048MB: write-back, count=1
reg01: base=0x80000000 (2048MB), size=1024MB: write-back, count=1
reg02: base=0xc0000000 (3072MB), size= 512MB: write-back, count=1
reg03: base=0xe0000000 (3584MB), size= 256MB: write-back, count=1
reg04: base=0x100000000 (4096MB), size=4096MB: write-back, count=1
reg05: base=0x200000000 (8192MB), size=8192MB: write-back, count=1

> say and how much memory is in that thing?

8192MB (8GB), plus 2GB swap space.
Does memory size somehow affect bogomips calculation?

There are however some noteworthy lines in syslog during reboot:
(...)
Apr 26 14:25:40 x445 kernel: Using local APIC timer interrupts.
Apr 26 14:25:40 x445 kernel: calibrating APIC timer ...
Apr 26 14:25:40 x445 kernel: ..... CPU clock speed is 2993.0654 MHz.
Apr 26 14:25:40 x445 kernel: ..... host bus clock speed is 99.0788 MHz.
Apr 26 14:25:40 x445 kernel: checking TSC synchronization across 8 CPUs:
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#0 improperly initialized, has 
7358270 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#1 improperly initialized, has 
7358270 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#2 improperly initialized, has 
-7358271 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#3 improperly initialized, has 
-7358271 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#4 improperly initialized, has 
7358271 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#5 improperly initialized, has 
7358270 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#6 improperly initialized, has 
-7358269 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: BIOS BUG: CPU#7 improperly initialized, has 
-7358271 usecs TSC skew! FIXED.
Apr 26 14:25:40 x445 kernel: Brought up 8 CPUs
(...)

I don't know if that's any help.

Tell me if you need more details like .config, syslog etc.

Please CC me when replying!

Thanks,
Christoph
