Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261641AbUJYAe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261641AbUJYAe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUJYAe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:34:59 -0400
Received: from mail.timesys.com ([65.117.135.102]:32670 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261641AbUJYAeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:34:31 -0400
Message-ID: <417C49C6.1090300@timesys.com>
Date: Sun, 24 Oct 2004 20:33:10 -0400
From: john cooper <john.cooper@timesys.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Lee Revell <rlrevell@joe-job.com>, gene.heskett@verizon.net,
       linux-kernel@vger.kernel.org, Rui Nuno Capela <rncbc@rncbc.org>,
       Mark_H_Johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>,
       john cooper <john.cooper@timesys.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
References: <20041014234202.GA26207@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <200410221749.35306.gene.heskett@verizon.net> <1098482764.20495.2.camel@krustophenia.net> <20041023103620.GG30270@elte.hu>
In-Reply-To: <20041023103620.GG30270@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------030007050500000404040408"
X-OriginalArrivalTime: 25 Oct 2004 00:29:16.0609 (UTC) FILETIME=[A910C310:01C4BA29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030007050500000404040408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:

>* Lee Revell <rlrevell@joe-job.com> wrote:
>
>
>>On Fri, 2004-10-22 at 17:49 -0400, Gene Heskett wrote:
>>
>>>Mmm, I get a 404 page not found. when I click on  on thsi link.
>>>
>>Same here.  The current version is 10.3:
>>
>>http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-mm1-U10.3
>>
I'm seeing an odd build error in the -U10.3 patch to 2.6.9-mm1:

    <snip>

  AS      arch/i386/boot/compressed/head.o
  CC      arch/i386/boot/compressed/misc.o
  OBJCOPY arch/i386/boot/compressed/vmlinux.bin
BFD: Warning: Writing section `.bss' to huge (ie negative) file offset 
0xc03ac000.
objcopy: arch/i386/boot/compressed/vmlinux.bin: File truncated
make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Error 1
make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
make: *** [bzImage] Error 2

[root@otaku linux-2.6.9]# objdump -f vmlinux

vmlinux:     file format elf32-i386
architecture: i386, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x00100000

This appears a result of changes in:

   arch/i386/kernel/vmlinux.lds.S

apparently for support of CONFIG_KERN_PHYS_OFFSET.
This causes the kernel LMA start address to
change from 0xc0100000 to 0x100000 and objcopy to
gag.  I rolled back to a 2.6.9-mm1 version of the
above linker map file and did get the kernel to
build and boot.

Anyone else seeing this?  .config attached.

BTW, the -U10.2 patch seems to have disappeared
from:

    http://people.redhat.com/mingo/realtime-preempt/older/

-- 
john.cooper@timesys.com


--------------030007050500000404040408
Content-Type: application/x-bzip;
 name="config.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="config.bz2"

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
Dutg
--------------030007050500000404040408--
