Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVAGXZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVAGXZS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbVAGXYv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:24:51 -0500
Received: from pD9F86D75.dip0.t-ipconnect.de ([217.248.109.117]:45184 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S261703AbVAGXWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:22:23 -0500
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: Re: 2.4.x oops with X
Date: Sat, 08 Jan 2005 00:21:03 +0100
Organization: privat
Message-ID: <41DF195F.4010406@pD9F86D75.dip0.t-ipconnect.de>
References: <fa.kuv2u3i.hhma1k@ifi.uio.no> <fa.f87d0no.fk6a9u@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
Cc: davej@codemonkey.org.uk
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.4) Gecko/20041217
X-Accept-Language: de, en-us, en
In-Reply-To: <fa.f87d0no.fk6a9u@ifi.uio.no>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti schrieb:
> On Fri, Jan 07, 2005 at 07:13:50PM +0100, Andreas Hartmann wrote:
>> Hello Marcelo,
>> 
>> Marcelo Tosatti schrieb:
>> > On Fri, Jan 07, 2005 at 10:03:11AM +0100, Andreas Hartmann wrote:
>> >> Hello!

[...]

>> > We added a BUG() call in get_user_pages() to catch VM_IO flagged vma's 
>> > (virtual memory areas) with PageReserved pages.
>> > 
>> > Can you disable AGP and run X ? 
>> 
>> Well, what do you mean with "disable AGP"? I can't disable it in the BIOS.
>> I disabled DRI in the XF86Config-file. agpgart and r128 haven't been
>> loaded (they are built as modules). The behaviour of the X-starting
>> doesn't change and it's always the same: 
> 
> I meant not loading the agpgart/r128 modules, but it seems they are loaded 
> on demand and X actually can't work without them.

Sorry, they are really not loaded. Therefore, the patch of the
agpgart-module didn't change the behaviour.

I put the actual oops here:

Jan  7 22:45:14 athlon kernel: get_user_pages PG_reserved page
onvma:de206840 flags:800ff page:0
Jan  7 22:45:14 athlon kernel: kernel BUG at memory.c:535!
Jan  7 22:45:14 athlon kernel: invalid operand: 0000
Jan  7 22:45:14 athlon kernel: serial usb-storage scsi_mod uhci usbcore
parport_pc lp parport loop lvm-modunix
Jan  7 22:45:14 athlon kernel: CPU:    0
Jan  7 22:45:14 athlon kernel: EIP:    0010:[<c013b002>]    Not tainted
Jan  7 22:45:14 athlon kernel: EFLAGS: 00010286
Jan  7 22:45:14 athlon kernel: eax: 00000045   ebx: 00000000   ecx:
de16c000   edx: 00000001
Jan  7 22:45:14 athlon kernel: esi: de206840   edi: ffffffff   ebp:
00000001   esp: de16dc00
Jan  7 22:45:14 athlon kernel: ds: 0018   es: 0018   ss: 0018
Jan  7 22:45:14 athlon kernel: Process X (pid: 171, stackpage=de16d000)
Jan  7 22:45:14 athlon kernel: Stack: c0258ae0 de206840 000800ff 00000000
00002cb0 de16c000 de16c000 00000010
Jan  7 22:45:14 athlon kernel:        de206840 000a0000 000a0454 de16c000
c016f5dc de16c000 dfa8a980 000a0000
Jan  7 22:45:14 athlon kernel:        00000001 00000000 00000001 de16dc6c
de16dc70 00002cb0 00000003 01388000
Jan  7 22:45:14 athlon kernel: Call Trace: [<c016f5dc>]  [<c0199a9d>]
[<c0198de7>]  [<c014d5b2>]  [<c0159255>]  [<c012437b>]  [<c0124415>]
[<c0107037>]  [<c0124821>]  [<c0108110>]  [<c0124d3f>]  [<c0108110>]
[<c0107214>]
Jan  7 22:45:14 athlon kernel: Code: 0f 0b 17 02 1e 88 25 c0 bf f2 ff ff
ff eb 97 e8 9a c3 fd ff
Jan  7 22:45:14 athlon kernel:  <6>note: X[171] exited with preempt_count 1


ksymoops 2.4.9 on i686 2.4.29-pre3.  Options used
     -V (default)
     -k ksyms (specified)
     -l modules (specified)
     -o /lib/modules/2.4.29-pre3/ (specified)
     -m /usr/src/linux-2.4.29-pre3-swsusp/System.map (specified)

Jan  7 22:45:14 athlon kernel: kernel BUG at memory.c:535!
Jan  7 22:45:14 athlon kernel: invalid operand: 0000
Jan  7 22:45:14 athlon kernel: CPU:    0
Jan  7 22:45:14 athlon kernel: EIP:    0010:[<c013b002>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  7 22:45:14 athlon kernel: EFLAGS: 00010286
Jan  7 22:45:14 athlon kernel: eax: 00000045   ebx: 00000000   ecx:
de16c000   edx: 00000001
Jan  7 22:45:14 athlon kernel: esi: de206840   edi: ffffffff   ebp:
00000001   esp: de16dc00
Jan  7 22:45:14 athlon kernel: ds: 0018   es: 0018   ss: 0018
Jan  7 22:45:14 athlon kernel: Process X (pid: 171, stackpage=de16d000)
Jan  7 22:45:14 athlon kernel: Stack: c0258ae0 de206840 000800ff 00000000
00002cb0 de16c000 de16c000 00000010
Jan  7 22:45:14 athlon kernel:        de206840 000a0000 000a0454 de16c000
c016f5dc de16c000 dfa8a980 000a0000
Jan  7 22:45:14 athlon kernel:        00000001 00000000 00000001 de16dc6c
de16dc70 00002cb0 00000003 01388000
Jan  7 22:45:14 athlon kernel: Call Trace: [<c016f5dc>]  [<c0199a9d>]
[<c0198de7>]  [<c014d5b2>]  [<c0159255>]  [<c012437b>]  [<c0124415>]
[<c0107037>]  [<c0124821>]  [<c0108110>]  [<c0124d3f>]  [<c0108110>]
[<c0107214>]
Jan  7 22:45:14 athlon kernel: Code: 0f 0b 17 02 1e 88 25 c0 bf f2 ff ff
ff eb 97 e8 9a c3 fd ff


>>EIP; c013b002 <get_user_pages+1a2/260>   <=====

>>ecx; de16c000 <_end+1de63ee8/205aff68>
>>esi; de206840 <_end+1defe728/205aff68>
>>esp; de16dc00 <_end+1de65ae8/205aff68>

Trace; c016f5dc <elf_core_dump+7ec/975>
Trace; c0199a9d <do_journal_end+bd/b60>
Trace; c0198de7 <journal_end+27/30>
Trace; c014d5b2 <do_truncate+72/a0>
Trace; c0159255 <do_coredump+185/1a3>
Trace; c012437b <collect_signal+ab/e0>
Trace; c0124415 <dequeue_signal+65/d0>
Trace; c0107037 <do_signal+227/2d8>
Trace; c0124821 <deliver_signal+31/70>
Trace; c0108110 <do_general_protection+0/a0>
Trace; c0124d3f <force_sig+1f/30>
Trace; c0108110 <do_general_protection+0/a0>
Trace; c0107214 <signal_return+14/18>

Code;  c013b002 <get_user_pages+1a2/260>
00000000 <_EIP>:
Code;  c013b002 <get_user_pages+1a2/260>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c013b004 <get_user_pages+1a4/260>
   2:   17                        pop    %ss
Code;  c013b005 <get_user_pages+1a5/260>
   3:   02 1e                     add    (%esi),%bl
Code;  c013b007 <get_user_pages+1a7/260>
   5:   88 25 c0 bf f2 ff         mov    %ah,0xfff2bfc0
Code;  c013b00d <get_user_pages+1ad/260>
   b:   ff                        (bad)
Code;  c013b00e <get_user_pages+1ae/260>
   c:   ff eb                     ljmp   *<internal disassembler error>
Code;  c013b010 <get_user_pages+1b0/260>
   e:   97                        xchg   %eax,%edi
Code;  c013b011 <get_user_pages+1b1/260>
   f:   e8 9a c3 fd ff            call   fffdc3ae <_EIP+0xfffdc3ae>

> 
> Well the problem is the core dumping code (elf_core_dump function) is trying to write
> your ATI card memory to disk, which is wrong. 
> 
> agp's mmap() method does not mark the memory region it creates as VM_IO to 
> indicate its a device memory mapped region, and it should AFAICS.
> 
> The following corrects the situation and should stop the BUG() from happening, 
> however the SIGSEGV which X is receiving seems to be a different thing.


As far as I understand it now, this oops happens, because the core-file
creation wants to write memory areas to disk, which are device memory
mapped regions and which are not marked as VM_IO by X. The core-file wants
to be written, because X segfaulted right before.

The oops shouldn't come up, if I disable the corefile writing. I could
verify this.


But now, the question is:
Why does X crash running kernel 2.4.x with glibc 2.3.4 and not with kernel
2.6.10? Why does X run fine using kernel 2.4 and 2.6 with glibc 2.3.3?

----------------------------------------------
	|		glibc
	|	2.3.3		2.3.4
--------|-------------------------------------
kernel	|
2.4	|	X ok		X segfaults
2.6	|	X ok		X ok


X has been compiled using glibc 2.3.3 some months ago. But it crashes too,
if it's compiled against glibc 2.3.4 running kernel 2.4.
Seems to be, that kernel 2.4 doesn't like glibc 2.3.4 or vice versa.


Kind regards,
Andreas Hartmann
