Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274041AbRJBOCD>; Tue, 2 Oct 2001 10:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274079AbRJBOBy>; Tue, 2 Oct 2001 10:01:54 -0400
Received: from nick.dcs.qmul.ac.uk ([138.37.88.61]:19079 "EHLO
	nick.dcs.qmul.ac.uk") by vger.kernel.org with ESMTP
	id <S274041AbRJBOBk>; Tue, 2 Oct 2001 10:01:40 -0400
Date: Tue, 2 Oct 2001 15:02:08 +0100 (BST)
From: Matt Bernstein <matt@theBachChoir.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        "H. Peter Anvin" <hpa@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: NFSv3 and linux-2.4.10-ac3 => oops
In-Reply-To: <E15oPt7-0004gA-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0110021446240.31037-100000@nick.dcs.qmul.ac.uk>
X-URL: http://www.theBachChoir.org.uk/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 14:47 +0100 Alan Cox wrote:

>> I wonder if this is related to oopses I sent in in the last two days?
[snip]
>
>Are these oopses new as of the 2.4.10 based tree. If so do you see them
>with 2.4.10-ac3 ?

Mine were from 2.4.9-ac10 + ext3-0.9.9 + ext3 speedup patch (which is in
0.9.10) + "experimental VM patch" (see the ext3 for 2.4 page) + jfs-1.0.4
(compiled with gcc 2.96-85, romfs initrd, everything possible as modules)

I've booted two of our servers into 2.4.9-ac18 compiled with egcs-1.1.2
(so far without Trond's patches) and will report anything odd.

Incidentally a third server on my 2.4.9-ac10 things has oopsed (output
below). What these three servers have in common is that they're all using
ICP-Vortex gdth raid arrays, and no IDE. I have four or five other setups
with the exact same kernel (well, two of them compiled for UP Athlon
rather than SMP Coppermine) with IDE root and further SCSI partitions
(some aic7xxx, some gdth) which have all been very stable. We haven't
ruled out a cabling/termination problem, but it's a bit spooky.

Thanks for the responses :)

Matt


ksymoops 2.4.1 on i686 2.4.9-ac10-jfs.  Options used
     -V (default)
     -K (specified)
     -L (specified)
     -o /lib/modules/2.4.9-ac10-jfs/ (default)
     -m /boot/System.map-2.4.9-ac10-jfs (default)

No modules in ksyms, skipping objects
Unable to handle kernel paging request at virtual address 756f6a00
756f6a00
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<756f6a00>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 756f6a00   ebx: c7e219cc   ecx: d01fc594   edx: d01fc594
esi: c7e219b4   edi: d01fc584   ebp: ffff4909   esp: c1969f68
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 5, stackpage=c1969000)
Stack: c015a271 c7e219b4 d01fc584 c022c940 00000206 ffffffff 00003044
c11fa670
       c11fa670 00000000 00000001 000000c0 00000001 c0231d60 0008e000
c015a891
       00000000 c0139306 00000000 000000c0 000000c0 00000000 c1968000
ffffffff
Call Trace: [<c015a271>] [<c015a891>] [<c0139306>] [<c01393ae>]
[<c0105000>]
   [<c0105000>] [<c0105926>] [<c0139340>]
Code:  Bad EIP value.

>>EIP; 756f6a00 Before first symbol   <=====
Trace; c015a271 <prune_dcache+141/270>
Trace; c015a891 <shrink_dcache_memory+21/40>
Trace; c0139306 <do_try_to_free_pages+26/60>
Trace; c01393ae <kswapd+6e/f0>
Trace; c0105000 <_stext+0/0>
Trace; c0105000 <_stext+0/0>
Trace; c0105926 <kernel_thread+26/30>
Trace; c0139340 <kswapd+0/f0>

 <1>Unable to handle kernel paging request at virtual address 756f6a00
756f6a00
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<756f6a00>]
EFLAGS: 00010206
eax: 756f6a00   ebx: de844de0   ecx: c0819e54   edx: c0819e54
esi: de844dc8   edi: c0819e44   ebp: 00000000   esp: cc7c3e74
ds: 0018   es: 0018   ss: 0018
Process bonnie++ (pid: 17138, stackpage=cc7c3000)
Stack: c015a271 de844dc8 c0819e44 00000082 c01383ba c10143c0 00000082
c10143dc
       c1509d24 00000000 00000000 000000d2 00015ec2 00000000 000000d2
c015a891
       00000000 c0139306 00000000 000000d2 000000d2 00000001 cc7c2000
00000010
Call Trace: [<c015a271>] [<c01383ba>] [<c015a891>] [<c0139306>]
[<c0139488>]
   [<c013a13e>] [<c0131f0b>] [<c0109437>] [<e099ae42>] [<c0142656>]
[<c01128bc>]
   [<c010772b>]
Code:  Bad EIP value.

>>EIP; 756f6a00 Before first symbol   <=====
Trace; c015a271 <prune_dcache+141/270>
Trace; c01383ba <try_to_release_page+3a/60>
Trace; c015a891 <shrink_dcache_memory+21/40>
Trace; c0139306 <do_try_to_free_pages+26/60>
Trace; c0139488 <try_to_free_pages+28/40>
Trace; c013a13e <__alloc_pages+1be/250>
Trace; c0131f0b <generic_file_write+35b/610>
Trace; c0109437 <do_IRQ+1a7/1c0>
Trace; e099ae42 <END_OF_CODE+206ce85a/????>
Trace; c0142656 <sys_write+96/d0>
Trace; c01128bc <smp_apic_timer_interrupt+ec/110>
Trace; c010772b <system_call+33/38>



