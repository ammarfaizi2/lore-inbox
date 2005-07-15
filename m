Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263355AbVGOSJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbVGOSJF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 14:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbVGOSFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 14:05:25 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:55314 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263362AbVGOSDS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 14:03:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HfASx5C7iIpaWsgN4+1sFvtyLfaa7bc/GFJ1iEdWoQ6P1RhwN/ciqNQ38BU5EoFbIRWzGaUIDD6jNwngh2Crz/uAjtBkUOaQ909K09DMWFI4wBLN3GmFJWB2XqEMwgtoYQebL491R0OnXNzLBI6WA0qEYAgDo9KYEwvVzR0EpPs=
Message-ID: <f0655b9a05071511036f1733b0@mail.gmail.com>
Date: Fri, 15 Jul 2005 13:03:17 -0500
From: Sizhao Yang <zaoyang@gmail.com>
Reply-To: Sizhao Yang <zaoyang@gmail.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: ASPLOV miss ratio porting to planet labs kernel
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050708042843.GB5793@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f0655b9a0507071028209af86e@mail.gmail.com>
	 <20050708042843.GB5793@dmt.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

Thank you for the quick response.  I actually didn't anticipate that
quick of a response.

> > I was wondering if someone could help me with this.  I'm porting an
> > ASPLOV paper miss ratio curve from 2.4.20 2.6.11.6 and eventually to
> > Planet Labs kernel.  It's a novel idea for memory management.  In
> > porting I at run time I'm consistently hitting kernel bugs at four
> > different places bad_page, bad_range, in rmap.c
> > BUG(page_mapcount(page)< 0), and failing at apm_do_idle.  All of these
> > functions except apm_do_idle seem to be new functions from 2.4.20 to
> > 2.6.11.6.  I'm pretty sure I'm forgetting to account for certain
> > things when modifying the pages, but I'm not sure where.
> 
> Having the information which bad_page etc. dump out would definately help.
> 
> I can't figure out what is going on with the data you provide, probably
> someone else can.

Here are some data dumps that I have:   for bad_page, bad_range, and rmap.c 
error 1: When this function has an error it traces back to bad_range
and bad_page.
------------[ cut here ]------------
kernel BUG at mm/page_alloc.c:647!
invalid operand: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c0137af8>]    Not tainted VLI
EFLAGS: 00000202   (2.6.11-kgdb)
EIP is at buffered_rmqueue+0x178/0x1d0
eax: 00000001   ebx: c033c164   ecx: fff99e0b   edx: 00001000
esi: c033c164   edi: 00000246   ebp: c033c180   esp: c7db5df0
ds: 007b   es: 007b   ss: 0068
Process nbench (pid: 301, threadinfo=c7db4000 task=c1273020)
Stack: c033c190 c7e3b000 c033c178 000080d2 00000000 c033c164 00000000 00000000
       000080d2 c013800d 00000001 00000000 00000000 c11657e0 00000001 00000000
       c1273020 00000010 c033c3cc 00000000 c03e0aa0 003ba025 c7dbffd0 c12f385c
Call Trace:
 [<c013800d>] __alloc_pages+0x3fd/0x460
 [<c0142e19>] do_anonymous_page+0x59/0x120
 [<c0142f3e>] do_no_page+0x5e/0x280
 [<c014338c>] handle_mm_fault+0x12c/0x1b0
 [<c0113a76>] do_page_fault+0x176/0x5db
 [<c014479d>] vma_merge+0xbd/0x180
 [<c0107cd1>] old_mmap+0xc1/0x100
 [<c0113900>] do_page_fault+0x0/0x5db
 [<c0102f8b>] error_code+0x2b/0x30
Code: 00 00 00 8b 44 24 08 83 c4 14 5b 5e 5f 5d c3 8b 54 24 10 8b 44
24 08 e8 c7 f6 ff ff eb e5 0f 0b 5e 02 ed f4 2f c0 e9 7c ff ff ff <0f>
0b 87 02 ed f4 2f c0 e9 09 ff ff ff 9c 5f fa 8b 54 24 10 89
 <1>Unable to handle kernel paging request at virtual address 00100104
 printing eip:
c0137927
*pde = 00000000
Oops: 0002 [#2]
Modules linked in:
CPU:    0
EIP:    0060:[<c0137927>]    Not tainted VLI
EFLAGS: 00000097   (2.6.11-kgdb)


error 2: main error: For rmap.c:

------------[ cut here ]------------
kernel BUG at mm/rmap.c:487!
invalid operand: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c0147b5d>]    Not tainted VLI
EFLAGS: 00000292   (2.6.11-kgdb)
EIP is at page_remove_rmap+0x3d/0x70
eax: ffffffe0   ebx: c10fc6a0   ecx: 00000000   edx: c7d9de74
esi: c7d78124   edi: 00010000   ebp: c10fc6a0   esp: c7d9de70
ds: 007b   es: 007b   ss: 0068
Process ls (pid: 302, threadinfo=c7d9c000 task=c1273020)
Stack: c02ffb8f 00001000 c0141442 c0300460 c7ddcfa4 00000000 c12f116c 07e35025
       00000000 08048000 c03bda38 08448000 c7dde084 08058000 c03bda38 c01415ab
       00010000 00000000 c7ddeb7c b83e9000 08048000 c7dde084 08058000 c03bda38
Call Trace:
 [<c0141442>] zap_pte_range+0x162/0x280
 [<c01415ab>] zap_pmd_range+0x4b/0x70
 [<c014160d>] zap_pud_range+0x3d/0x60
 [<c0141694>] unmap_page_range+0x64/0x80
 [<c01417b9>] unmap_vmas+0x109/0x220
 [<c0145e87>] exit_mmap+0x67/0x130
 [<c0116fde>] mmput+0x1e/0x70
 [<c011ab99>] do_exit+0x99/0x360
 [<c011d2d3>] tasklet_action+0x43/0x70
 [<c011d099>] __do_softirq+0x79/0x90
 [<c011aecf>] do_group_exit+0x2f/0x70
 [<c0102de3>] syscall_call+0x7/0xb
Code: 08 ff 0f 98 c0 84 c0 74 3a 8b 43 08 40 78 26 8b 43 08 40 78 16
8b 5c 24 04 ba ff  ff ff ff b8 10 00 00 00 83 c4 08 e9 43 08 ff ff
<0f> 0b e7 01 7c fb 2f c0 eb e0 c7 04  24 8f fb 2f c0 e8 6d 14 fd
 <6>note: ls[302] exited with preempt_count 1

 ------------[ cut here ]------------
kernel BUG at mm/rmap.c:487!
invalid operand: 0000 [#1]
Modules linked in:
CPU:    0
EIP:    0060:[<c0147b3d>]    Not tainted VLI
EFLAGS: 00000296   (2.6.11-kgdb)
EIP is at page_remove_rmap+0x3d/0x70
eax: ffffffa0   ebx: c10fb680   ecx: 00000000   edx: c7dc9e88
esi: c7d37fd0   edi: 00021000   ebp: c10fb680   esp: c7dc9e84
ds: 007b   es: 007b   ss: 0068
Process nbench (pid: 301, threadinfo=c7dc8000 task=c1273020)
Stack: c02ffb6f 00016000 c0141436 00000246 00000100 00000000 c7dc9ef8 07db4067
       00000000 b7fde000 c03bda38 b83de000 c7dcfb80 b7fff000 c03bda38 c014159b
       00021000 00000000 c01205f0 00000100 b7fde000 c7dcfb80 b7fff000 c03bda38
Call Trace:
 [<c0141436>] zap_pte_range+0x156/0x270
 [<c014159b>] zap_pmd_range+0x4b/0x70
 [<c01205f0>] cascade+0x30/0x50
 [<c01415fd>] zap_pud_range+0x3d/0x60
 [<c0106bb9>] timer_interrupt+0x49/0xe0
 [<c0141684>] unmap_page_range+0x64/0x80
 [<c01417a9>] unmap_vmas+0x109/0x220
 [<c01457da>] unmap_region+0x6a/0xd0
 [<c0145a91>] do_munmap+0xf1/0x130
 [<c0145b10>] sys_munmap+0x40/0x70
 [<c0102de3>] syscall_call+0x7/0xb
Code: 08 ff 0f 98 c0 84 c0 74 3a 8b 43 08 40 78 26 8b 43 08 40 78 16
8b 5c 24 04 ba ff ff ff ff b8 10 00 00 00 83 c4 08 e9 63 08 ff ff <0f>
0b e7 01 5c fb 2f c0 eb e0 c7 04 24 6f fb 2f c0 e8 8d 14 fd
 <6>note: nbench[301] exited with preempt_count 1
scheduling while atomic: nbench/0x00000001/301
 [<c02e9038>] __switch_to_end+0x20c/0x214
 [<c01046eb>] do_IRQ+0x3b/0x70
 [<c0102f52>] common_interrupt+0x1a/0x20
 [<c02e9acd>] rwsem_down_read_failed+0x8d/0x170
 [<c011bff0>] .text.lock.exit+0x27/0x87
 [<c011ab99>] do_exit+0x99/0x360
 [<c0103678>] die+0x138/0x140
 [<c01039d0>] do_invalid_op+0x0/0xc0
 [<c0103a6f>] do_invalid_op+0x9f/0xc0
 [<c0120ad6>] update_process_times+0x166/0x210
 [<c0147b3d>] page_remove_rmap+0x3d/0x70
 [<c0132a79>] handle_IRQ_event+0x29/0x60
 [<c011d099>] __do_softirq+0x79/0x90
 [<c01046eb>] do_IRQ+0x3b/0x70
 [<c0102f52>] common_interrupt+0x1a/0x20
 [<c0102f8b>] error_code+0x2b/0x30
 [<c0147b3d>] page_remove_rmap+0x3d/0x70
 [<c0141436>] zap_pte_range+0x156/0x270
 [<c014159b>] zap_pmd_range+0x4b/0x70
 [<c01205f0>] cascade+0x30/0x50
 [<c01415fd>] zap_pud_range+0x3d/0x60
 [<c0106bb9>] timer_interrupt+0x49/0xe0
 [<c0141684>] unmap_page_range+0x64/0x80
 [<c01417a9>] unmap_vmas+0x109/0x220
 [<c01457da>] unmap_region+0x6a/0xd0
 [<c0145a91>] do_munmap+0xf1/0x130
 [<c0145b10>] sys_munmap+0x40/0x70
 [<c0102de3>] syscall_call+0x7/0xb


> Why dont you post the code (in case its GPL)...

The patch is here.  

https://wiki.planet-lab.org/twiki/pub/Planetlab/UIUCProject/mrc2.6.11.6patch.diff.txt.txt

It's for the 2.6.11.6 kernel.  To replicate the error fully before
compiling: please comment the mrc_reset_pgtables(p); in mm/mrc.c on
line 433.  If one comments out mrc_scan as well then there's no run
time crashes at all.  So all of the errors comes from mrc_scan and
mrc_reset_pgtables, it's just I can't figure out how it's corrupting
the pages, and how I should account for that in the code.

Also, in make xconfig a menu should come up. Go to "Kernel hacking"
then uncheck "Sleep-inside-spinlock checking"   I usually use the
virtual emulator qemu when debugging.  Finally when running mrc.  You
want to start a program and get the process id then do the following:

echo "<process id> 1 1 100 100" > /proc/sys/vm/mrc_info   This will
turn mrc on for the given process.

All MRC code is surrounded by //MRC or something like it for easy
recognition.  I usually use qemu if you use qemu you may want to
download this:

http://fabrice.bellard.free.fr/qemu/linux-test-0.5.1.tar.gz
http://fabrice.bellard.free.fr/qemu/qemu-0.7.0.tar.gz

and when running qemu.sh in linux-test change the script to
"qemu -nographic -hda linux.img -kernel
/boot/vmlinuz-2.6.11-kgdb -append "console=ttyS0 root=/dev/hda
sb=0x220,5,1,5 ide2=noprobe ide3=noprobe ide4=noprobe
ide5=noprobe"

I'd appreciate any direction you can provide.  Thanks for your help in
advance.  I look forward to hearing from you.

Zao
