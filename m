Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281595AbRKUF2h>; Wed, 21 Nov 2001 00:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRKUF21>; Wed, 21 Nov 2001 00:28:27 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:28034 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281595AbRKUF2R>; Wed, 21 Nov 2001 00:28:17 -0500
Date: Tue, 20 Nov 2001 23:30:57 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: [VMBUG] 2.4.15-pre7 Severe VM Bugs in 2.4.15-pre7
Message-ID: <20011120233057.B3705@vger.timpanogas.org>
In-Reply-To: <20011120231449.A3637@vger.timpanogas.org> <3562.1006319907@kao2.melbourne.sgi.com> <20011120232745.A3705@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011120232745.A3705@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Nov 20, 2001 at 11:27:45PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



More Info.  The 3Ware driver appears to be corrupting memory.  I 
did more checks.  This driver will bark if the memory passed
is not 4K aligned.  I do not know if this is specific to this 
driver, or if it is related to the recent VM issues.

When I pass 4K aligned memory, the problem disappears.  The IDE and
standard SCSI drivers do not exhibit this behavior.  2.4.15-pre6 
does not seem to exhibit this behavior. 

Please advise,

Jeff


On Tue, Nov 20, 2001 at 11:27:45PM -0700, Jeff V. Merkey wrote:
> On Wed, Nov 21, 2001 at 04:18:27PM +1100, Keith Owens wrote:
> > On Tue, 20 Nov 2001 23:14:49 -0700, 
> > "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
> > >ksymoops 2.4.0 on i686 2.4.15-pre7.  Options used
> > >     -m /boot/System.map-2.4.15-pre7 (default)
> > >Error (regular_file): read_system_map stat /boot/System.map-2.4.15-pre7 failed
> > 
> > Without a valid System.map, the decode is going to be very vague.  When
> > you see offset 5207 in code sized 32410 you know you don't have enough
> > detail.  Try the decode again with a valid System.map.
> 
> Got it.  I need to check my build scripts and figure out why it did 
> not copy the System.Map to /boot/.  I updated the file, and you 
> were correct.  The oops looks more readable.  Getting a crash in 
> the VM when a kfree() is attempted.  We are getting a page fault, it
> appears.
> 
> Jeff
> 
> 
> 

> ksymoops 2.4.0 on i686 2.4.15-pre7.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.15-pre7/ (default)
>      -m /boot/System.map-2.4.15-pre7 (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> No modules in ksyms, skipping objects
> Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
> Nov 20 09:58:50 scimitar kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000008
> Nov 20 09:58:50 scimitar kernel: c0172f1b
> Nov 20 09:58:50 scimitar kernel: *pde = 00000000
> Nov 20 09:58:50 scimitar kernel: Oops: 0000
> Nov 20 09:58:50 scimitar kernel: CPU:    1
> Nov 20 09:58:50 scimitar kernel: EIP:    0010:[<c0172f1b>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Nov 20 09:58:50 scimitar kernel: EFLAGS: 00010246
> Nov 20 09:58:50 scimitar kernel: eax: 00000000   ebx: cea30000   ecx: cea30018   edx: 000002b8
> Nov 20 09:58:50 scimitar kernel: esi: 00000000   edi: 00000000   ebp: 0000002f   esp: cead5ab8
> Nov 20 09:58:50 scimitar kernel: ds: 0018   es: 0018   ss: 0018
> Nov 20 09:58:50 scimitar kernel: Process mount (pid: 720, stackpage=cead5000)
> Nov 20 09:58:50 scimitar kernel: Stack: cea30018 c0173e29 cea30018 00000080 00000009 cea30018 00000003 00000004 
> Nov 20 09:58:50 scimitar kernel:        000000ae 09c23fff 00000000 c1556600 00000000 00000000 00000009 c019b9bb 
> Nov 20 09:58:50 scimitar kernel:        cead5b28 00001000 cead5b5c 00001000 c030f4fc 00000009 c0172e39 c0172e7f 
> Nov 20 09:58:50 scimitar kernel: Call Trace: [<c0173e29>] [<c019b9bb>] [<c0172e39>] [<c0172e7f>] [<c019a64a>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0124382>] [<c014463c>] [<c013c560>] [<c0295e70>] [<c01124ba>] [<c0176127>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0124d91>] [<c0124da2>] [<c0112320>] [<c010700c>] [<c0124804>] [<c0112320>] 
> Nov 20 09:58:50 scimitar kernel:    [<c010700c>] [<c02949fb>] [<c014bf8c>] [<c014cf8f>] [<c013c560>] [<c012d9e1>] 
> Nov 20 09:58:50 scimitar kernel:    [<c01241ba>] [<c0124214>] [<c0124382>] [<c012779c>] [<c01277c9>] [<c01124ba>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0128742>] [<c0183a39>] [<c01277c9>] [<c0154922>] [<c01125f0>] [<c0294922>] 
> Nov 20 09:58:50 scimitar kernel:    [<c0137fe1>] [<c0138460>] [<c013894f>] [<c0148f53>] [<c0112320>] [<c010700c>] 
> Nov 20 09:58:50 scimitar kernel:    [<c01491ec>] [<c014905c>] [<c01492b0>] [<c0106f1b>] 
> Nov 20 09:58:50 scimitar kernel: Code: 8b 50 08 2b 51 f0 89 50 08 8b 41 f4 ff 48 04 8b 41 f8 83 f8 
> 
> >>EIP; c0172f1b <NWFSFree+b/e0>   <=====
> Trace; c0173e29 <ScanDiskDevices+449/460>
> Trace; c019b9bb <nwvp_part_scan+1b/4d0>
> Trace; c0172e39 <NWFSIOAlloc+19/70>
> Trace; c0172e7f <NWFSIOAlloc+5f/70>
> Trace; c019a64a <nwvp_scan_routine+8a/600>
> Trace; c0124382 <handle_mm_fault+62/d0>
> Trace; c014463c <dput+1c/150>
> Trace; c013c560 <cached_lookup+10/50>
> Trace; c0295e70 <rb_insert_color+70/f0>
> Trace; c01124ba <do_page_fault+19a/4e0>
> Trace; c0176127 <NWFSVolumeScan+57/180>
> Trace; c0124d91 <do_mmap_pgoff+421/4f0>
> Trace; c0124da2 <do_mmap_pgoff+432/4f0>
> Trace; c0112320 <do_page_fault+0/4e0>
> Trace; c010700c <error_code+34/3c>
> Trace; c0124804 <__vma_link+64/c0>
> Trace; c0112320 <do_page_fault+0/4e0>
> Trace; c010700c <error_code+34/3c>
> Trace; c02949fb <clear_user+2b/40>
> Trace; c014bf8c <padzero+1c/20>
> Trace; c014cf8f <load_elf_binary+90f/a50>
> Trace; c013c560 <cached_lookup+10/50>
> Trace; c012d9e1 <__alloc_pages+41/180>
> Trace; c01241ba <do_anonymous_page+8a/b0>
> Trace; c0124214 <do_no_page+34/140>
> Trace; c0124382 <handle_mm_fault+62/d0>
> Trace; c012779c <filemap_nopage+bc/200>
> Trace; c01277c9 <filemap_nopage+e9/200>
> Trace; c01124ba <do_page_fault+19a/4e0>
> Trace; c0128742 <read_cache_page+42/120>
> Trace; c0183a39 <nwfs_read_super+79/1b0>
> Trace; c01277c9 <filemap_nopage+e9/200>
> Trace; c0154922 <ext2_get_page+22/80>
> Trace; c01125f0 <do_page_fault+2d0/4e0>
> Trace; c0294922 <__generic_copy_from_user+32/60>
> Trace; c0137fe1 <read_super+b1/140>
> Trace; c0138460 <get_sb_nodev+30/60>
> Trace; c013894f <do_kern_mount+df/150>
> Trace; c0148f53 <do_add_mount+23/e0>
> Trace; c0112320 <do_page_fault+0/4e0>
> Trace; c010700c <error_code+34/3c>
> Trace; c01491ec <do_mount+13c/160>
> Trace; c014905c <copy_mount_options+4c/a0>
> Trace; c01492b0 <sys_mount+a0/100>
> Trace; c0106f1b <system_call+33/38>
> Code;  c0172f1b <NWFSFree+b/e0>
> 00000000 <_EIP>:
> Code;  c0172f1b <NWFSFree+b/e0>   <=====
>    0:   8b 50 08                  mov    0x8(%eax),%edx   <=====
> Code;  c0172f1e <NWFSFree+e/e0>
>    3:   2b 51 f0                  sub    0xfffffff0(%ecx),%edx
> Code;  c0172f21 <NWFSFree+11/e0>
>    6:   89 50 08                  mov    %edx,0x8(%eax)
> Code;  c0172f24 <NWFSFree+14/e0>
>    9:   8b 41 f4                  mov    0xfffffff4(%ecx),%eax
> Code;  c0172f27 <NWFSFree+17/e0>
>    c:   ff 48 04                  decl   0x4(%eax)
> Code;  c0172f2a <NWFSFree+1a/e0>
>    f:   8b 41 f8                  mov    0xfffffff8(%ecx),%eax
> Code;  c0172f2d <NWFSFree+1d/e0>
>   12:   83 f8 00                  cmp    $0x0,%eax
> 
> 
> 2 warnings issued.  Results may not be reliable.

