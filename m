Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131353AbRC0PQx>; Tue, 27 Mar 2001 10:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131361AbRC0PQo>; Tue, 27 Mar 2001 10:16:44 -0500
Received: from enhanced.ppp.eticomm.net ([206.228.183.5]:63992 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S131353AbRC0PQc>; Tue, 27 Mar 2001 10:16:32 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: linux-kernel@vger.kernel.org, nfs-devel@linux.kernel.org,
        autofs@linux.kernel.org, hpa@zytor.com, gam3@acm.org
Subject: Re: PROBLEM: 2.2.18 oops leaves umount hung in disk sleep
In-Reply-To: <E14g8eP-0006k5-00@intech19.enhanced.com> <shs1yrpabky.fsf@charged.uio.no> <54hf0l8ug1.fsf@intech19.enhanced.com> <shspuf98nhy.fsf@charged.uio.no> <541yrpgsze.fsf@intech19.enhanced.com> <shs7l1gae5a.fsf@charged.uio.no>
From: Camm Maguire <camm@enhanced.com>
Date: 27 Mar 2001 10:15:11 -0500
In-Reply-To: Trond Myklebust's message of "23 Mar 2001 13:00:33 +0100"
Message-ID: <54puf35jls.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again!  We're in luck!  The oops happened again, and this time,
the full oops dump appeared on the screen, which I have copied below:

=============================================================================
Unable to handle kernel paging request at virtual address 6e617274
current->tss.c3 = 03d06000, %cr3 = 03d06000
*pde = 00000000
Oops = 0
CPU = 0
EIP = 0010:[<c012facf>]
EFLAGS = 00010a87
eax = 00000000  ebx = 6e617274  ecx = 6e617274  edx = 00000006
esi = 00000006  edi = c3bda800  ebp = 00000006  esp = c2381f5c
ds = 0018  es = 0018  ss = 0018
Process umount (pid:6942, process nr:58,stackpage = c2381000)
Stack: fffffffe c01281a2 c3bda800 00000006 c25db80c 00000006 fffffffa c01282e8
       00000006 00000000 00000000 00000000 08050006 c0b176e0 08054208 00000000
       c01283e3 00000006 00000000 c2380000 08054209 0804fa20 c01283fc 08054208
Call Trace: [<c01281a2>][<c01282e8>][<c01283e3>][<c01283fc>][<c01094fc>]
code: 8b 1b 39 79 34 75 ef 8b 41 04 8b 11 89 42 04 89 10 a1 e4 4d
=============================================================================
and through ksymoops:
=============================================================================
intech9# ksymoops</home/camm/oops
ksymoops</home/camm/oops
ksymoops 2.3.4 on i586 2.2.18-i586tsc.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18-i586tsc/ (default)
     -m /boot/System.map-2.2.18-i586tsc (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 6e617274
current->tss.c3 = 03d06000, %cr3 = 03d06000
*pde = 00000000
Stack: fffffffe c01281a2 c3bda800 00000006 c25db80c 00000006 fffffffa c01282e8
       00000006 00000000 00000000 00000000 08050006 c0b176e0 08054208 00000000
       c01283e3 00000006 00000000 c2380000 08054209 0804fa20 c01283fc 08054208
Call Trace: [<c01281a2>][<c01282e8>][<c01283e3>][<c01283fc>][<c01094fc>]
code: 8b 1b 39 79 34 75 ef 8b 41 04 8b 11 89 42 04 89 10 a1 e4 4d
Using defaults from ksymoops -t elf32-i386 -a i386

Trace; c01281a2 <do_umount+5a/144>
Trace; c01282e8 <umount_dev+5c/ac>
Trace; c01283e3 <sys_umount+ab/b8>
Trace; c01283fc <sys_oldumount+c/10>
Trace; c01094fc <system_call+34/38>
Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 1b                     mov    (%ebx),%ebx
Code;  00000002 Before first symbol
   2:   39 79 34                  cmp    %edi,0x34(%ecx)
Code;  00000005 Before first symbol
   5:   75 ef                     jne    fffffff6 <_EIP+0xfffffff6> fffffff6 <END_OF_CODE+3b764797/????>
Code;  00000007 Before first symbol
   7:   8b 41 04                  mov    0x4(%ecx),%eax
Code;  0000000a Before first symbol
   a:   8b 11                     mov    (%ecx),%edx
Code;  0000000c Before first symbol
   c:   89 42 04                  mov    %eax,0x4(%edx)
Code;  0000000f Before first symbol
   f:   89 10                     mov    %edx,(%eax)
Code;  00000011 Before first symbol
  11:   a1 e4 4d 00 00            mov    0x4de4,%eax


2 warnings issued.  Results may not be reliable.
=============================================================================

As before, the oops was truncated in the log.

I received two eth0 (ne2k-pci,using 8390) errors before this oops:
eth0: next frame inconsistency, 0xf2
eth0: next frame inconsistency, 0xb8

And then one eth0 error after the oops before the machine died:
eth0: bogus packet: status=0x80 nxpg=0x7b size=1518

I will be trying to recompile with gcc272 to see if anything changes.
In the meantime, I'd greatly appreciate any insights!

Take care,

Trond Myklebust <trond.myklebust@fys.uio.no> writes:

> >>>>> " " == Camm Maguire <camm@enhanced.com> writes:
> 
>      > Greetings!  Here are the contiguous lines from kern.log: Mar 21
>      > 01:14:47 intech9 kernel: eth0: bogus packet: status=0x80
>      > nxpg=0x57 size=1270 Mar 21 01:14:49 intech9 kernel: Unable to
>      > handle kernel NULL pointer dereference at virtual address
>      > 00000000 Mar 21 01:14:49 intech9 kernel: current->tss.cr3 =
>      > 02872000, %%cr3 = 02872000 Mar 21 01:14:49 intech9 kernel: *pde
>      > = 00000000 Mar 21 01:14:49 intech9 kernel: Oops: 0000 Mar 21
>      > 01:14:49 intech9 kernel: CPU: 0 Mar 22 12:30:08 intech9 kernel:
>      > klogd 1.3-3#33.1, log source = /proc/kmsg started.
> 
>      > Why would this have not been included, would you happen to
>      > know?  In any case, I understand that its pretty much
> 
> I've no idea why it wasn't logged. Did you possibly reboot without
> syncing the disk?
> 
>      > impossible to debug now, right?  dmesg wrapped around by the
>      > time I got to it (I seem to be having a lot of ethernet bogus
>      > packet messages, as shown above.  I've chalked this up to the
>      > heavy traffic during the amanda backup, but maybe something is
>      > wrong here too/instead?)
> 
> Have you tried to use an older version of gcc? AFAIK gcc-2.95.2 has a
> lot of bugs that are known to cause problems with the kernel. If you
> are having additional problems such as the bogus ethernet packets,
> then it might be worth your while to experiment a bit to see whether
> this might be some corruption problem.
> 
> Cheers,
>    Trond
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
