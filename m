Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266900AbRGQSRQ>; Tue, 17 Jul 2001 14:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266902AbRGQSRH>; Tue, 17 Jul 2001 14:17:07 -0400
Received: from archive.osdlab.org ([65.201.151.11]:17293 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S266900AbRGQSQ4>;
	Tue, 17 Jul 2001 14:16:56 -0400
Message-ID: <3B5480C1.B39CF1A4@osdlab.org>
Date: Tue, 17 Jul 2001 11:15:29 -0700
From: "Randy.Dunlap" <rddunlap@osdlab.org>
Organization: OSDL
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Lessem <Jeff.Lessem@Colorado.EDU>
CC: linux-kernel@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.6-ac5 not booting on highmem machine
In-Reply-To: <200107171331.HAA246192@ibg.colorado.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

Looks like the bootflag code checksum loop is trying to
access across a page boundary.

Alan et al- is there a good trick to get around this?

Alan- should bootflag.o depend on CONFIG_PNPBIOS, and not
just the one line in it that sets the PNPOS flag?
I.e. why execute sbf_* if not CONFIG_PNPBIOS?
I'll generate a patch for this if you like.

Jeff, can you post (or send me) a good boot log (just the
E820 memory mapping part of it will do).

Do you have the ACPI "pmtools"?  Getting an ACPI tables dump
would be useful.
[http://developer.intel.com/technology/iapc/acpi/downloads.htm]

~Randy


Jeff Lessem wrote:
> 
> I have an 8 processor PIII Xeon machine with 8GB of ram.  The recent
> -ac5 patch does not boot, panicking immediately after
> Linux NET4.0 for Linux 2.4
> Based upon Swansea University Computer Society NET3.039
> is printed on the console.  The following ksymoops is printed.  If any
> more information would be useful in tracking down this error, please
> let me know.
> 
> ksymoops 2.4.1 on i686 2.4.6.  Options used
>      -v /home/lessem/linux/linux-ac/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -o /lib/modules/2.4.6-ac5/ (specified)
>      -m /boot/System.map-2.4.6-ac5 (specified)
> 
> No modules in ksyms, skipping objects
> Unable to handle kernel paging request at virtual address f8801000
> c024fab6
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c024fab6>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010203
> eax: f8800000   ebx: f88000e9   ecx: 03ff810c   edx: 000006f0
> esi: 00000f17   edi: c0203816   ebp: ecc3ff80   esp: c9cbbfbc
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 1, stackpage=c9cbb000)
> Stack: c027f70c c024bfc0 00000000 0008e000 44000000 03ff80e9 00000024 c024c884
>        c9cba000 c024c8c2 c0105075 00010f00 c024bfc0 c01054fc 00000000 00000078
>        00098700
> Call Trace: [<c0105075>] [<c01054fc>]
> Code: 8a 04 1e 00 44 24 13 46 39 ee 72 f4 80 7c 24 13 00 74 08 53
> 
> >>EIP; c024fab6 <sbf_init+ee/198>   <=====
> Trace; c0105075 <init+29/154>
> Trace; c01054fc <kernel_thread+28/38>
> Code;  c024fab6 <sbf_init+ee/198>
> 00000000 <_EIP>:
> Code;  c024fab6 <sbf_init+ee/198>   <=====
>    0:   8a 04 1e                  mov    (%esi,%ebx,1),%al   <=====
> Code;  c024fab9 <sbf_init+f1/198>
>    3:   00 44 24 13               add    %al,0x13(%esp,1)
> Code;  c024fabd <sbf_init+f5/198>
>    7:   46                        inc    %esi
> Code;  c024fabe <sbf_init+f6/198>
>    8:   39 ee                     cmp    %ebp,%esi
> Code;  c024fac0 <sbf_init+f8/198>
>    a:   72 f4                     jb     0 <_EIP>
> Code;  c024fac2 <sbf_init+fa/198>
>    c:   80 7c 24 13 00            cmpb   $0x0,0x13(%esp,1)
> Code;  c024fac7 <sbf_init+ff/198>
>   11:   74 08                     je     1b <_EIP+0x1b> c024fad1 <sbf_init+109/198>
> Code;  c024fac9 <sbf_init+101/198>
>   13:   53                        push   %ebx

> -
