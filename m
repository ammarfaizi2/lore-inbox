Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261824AbTC0J35>; Thu, 27 Mar 2003 04:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbTC0J35>; Thu, 27 Mar 2003 04:29:57 -0500
Received: from [218.244.176.102] ([218.244.176.102]:32268 "EHLO
	wideinfo.com.cn") by vger.kernel.org with ESMTP id <S261824AbTC0J3u>;
	Thu, 27 Mar 2003 04:29:50 -0500
From: "Zhenghui Zhou" <zhouzhenghui@cn99.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Ooops in 2.4.18 through 2.4.20, now kswapd is defunct
Date: Thu, 27 Mar 2003 17:40:12 +0800
Message-ID: <005d01c2f444$dd414170$a9b0f4da@wideinfo.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Authenticated-Sender: zzh@wideinfo.com.cn
X-MDRemoteIP: 192.168.0.14
X-Return-Path: zhouzhenghui@cn99.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have a variety of systems running kernels ranging from
> 2.4.18 through 2.4.20 and am seeing fairly frequent
> kernel oopsen.  After the oops, kswapd is defunct, however
> the systems are still running (they are dual CPU systems).
> Has anyone seen this before, and is there a patch to fix
> it yet ?  Thanks.
> 
> Kelvin Edwards
> System Admin
> Jefferson Lab
> 
> Here's some Ooops run through ksymoops:
> 
> Mar 21 15:20:00 MachX kernel: Unable to handle kernel NULL pointer
dereference
> at virtual address 00000004
> Mar 21 15:20:00 MachX kernel: c0152b51
> Mar 21 15:20:00 MachX kernel: *pde = 00000000
> Mar 21 15:20:00 MachX kernel: Oops: 0000
> Mar 21 15:20:00 MachX kernel: CPU:    4
> Mar 21 15:20:00 MachX kernel: EIP:    0010:[destroy_inode+33/80]
Not
> tainted
> Mar 21 15:20:00 MachX kernel: EIP:    0010:[<c0152b51>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> Mar 21 15:20:00 MachX kernel: EFLAGS: 00010246
> Mar 21 15:20:00 MachX kernel: eax: 00000000   ebx: e3c999c0   ecx:
00000000
> edx: e3c999c0
> Mar 21 15:20:00 MachX kernel: esi: e3c999c0   edi: 00000001   ebp:
00000a55
> esp: f7a8fefc
> Mar 21 15:20:00 MachX kernel: ds: 0018   es: 0018   ss: 0018
> Mar 21 15:20:00 MachX kernel: Process kswapd (pid: 11,
stackpage=f7a8f000)
> Mar 21 15:20:00 MachX kernel: Stack: e3c999c0 c0154335 e3c999c0
d940e7a0
> c034c700 00150c00 f8a09e9a ca60c738
> Mar 21 15:20:00 MachX kernel:        ca60c720 e3c999c0 c0151a31
e3c999c0
> e3c999c0 c0135e63 d7f4e400 f7a8e000
> Mar 21 15:20:00 MachX kernel:        ffffffff 000001d0 c02e6308
f7a8e000
> 00000003 0000001f 000001d0 00000006
> Mar 21 15:20:00 MachX kernel: Call Trace:    [iput+629/640]
> [appletalk:__insmod_appletalk_S.bss_L268+425722/117747542]
> [prune_dcache+225/368] [shrink_cache+819/976]
[shrink_dcache_memory+32/48]
> Mar 21 15:20:00 MachX kernel: Call Trace:    [<c0154335>] [<f8a09e9a>]
> [<c0151a31>] [<c0135e63>] [<c0151de0>]
> Mar 21 15:20:00 MachX kernel:   [<c0136087>] [<c01360ec>] [<c01361ff>]
> [<c0136276>] [<c01363b1>] [<c0136310>]
> Mar 21 15:20:00 MachX kernel:   [<c0105000>] [<c0107296>] [<c0136310>]
> Mar 21 15:20:00 MachX kernel: Code: 8b 40 04 85 c0 74 08 53 ff d0 59
eb 11 89
> f6 53 8b 15 b4 ae
> 
> >>EIP; c0152b51 <destroy_inode+21/50>   <=====
> Trace; c0154335 <iput+275/280>
> Trace; f8a09e9a <[nfs]nfs_dentry_iput+5a/80>
> Trace; c0151a31 <prune_dcache+e1/170>
> Trace; c0135e63 <shrink_cache+333/3d0>
> Trace; c0151de0 <shrink_dcache_memory+20/30>
> Trace; c0136087 <shrink_caches+67/90>
> Trace; c01360ec <try_to_free_pages_zone+3c/60>
> Trace; c01361ff <kswapd_balance_pgdat+4f/a0>
> Trace; c0136276 <kswapd_balance+26/40>
> Trace; c01363b1 <kswapd+a1/ba>
> Trace; c0136310 <kswapd+0/ba>
> Trace; c0105000 <_stext+0/0>
> Trace; c0107296 <kernel_thread+26/30>
> Trace; c0136310 <kswapd+0/ba>
> Code;  c0152b51 <destroy_inode+21/50>
> 00000000 <_EIP>:
> Code;  c0152b51 <destroy_inode+21/50>   <=====
>    0:   8b 40 04                  mov    0x4(%eax),%eax   <=====
> Code;  c0152b54 <destroy_inode+24/50>
>    3:   85 c0                     test   %eax,%eax
> Code;  c0152b56 <destroy_inode+26/50>
>    5:   74 08                     je     f <_EIP+0xf> c0152b60
> <destroy_inode+30/50>
> Code;  c0152b58 <destroy_inode+28/50>
>    7:   53                        push   %ebx
> Code;  c0152b59 <destroy_inode+29/50>
>    8:   ff d0                     call   *%eax
> Code;  c0152b5b <destroy_inode+2b/50>
>    a:   59                        pop    %ecx
> Code;  c0152b5c <destroy_inode+2c/50>
>    b:   eb 11                     jmp    1e <_EIP+0x1e> c0152b6f
> <destroy_inode+3f/50>
> Code;  c0152b5e <destroy_inode+2e/50>
>    d:   89 f6                     mov    %esi,%esi
> Code;  c0152b60 <destroy_inode+30/50>
>    f:   53                        push   %ebx
> Code;  c0152b61 <destroy_inode+31/50>
>   10:   8b 15 b4 ae 00 00         mov    0xaeb4,%edx
> 

I meet the similar situation, I run the server on internet with heavy
stress and cannot trace it clearly, I also tested from 2.4.18 to 2.4.20,
and got the same wrong thing, I have to limit the number of processes
running on the server to cut down the errors.

The error fired while load and run a program from disk, if it is do by
hand, it shows as "Segmentation Fault". The dmesg shows:

<1>Unable to handle kernel NULL pointer dereference at virtual address
00000004
	 printing eip:
	dfd91718
	*pde = 00000000
	Oops: 0000
	CPU:    0
	EIP:    0010:[<dfd91718>]    Not tainted
	EFLAGS: 00010286
	eax: bffffae4   ebx: cff46000   ecx: 00000000   edx: cff46000
	esi: c0106c33   edi: 0000000b   ebp: cff47fb8   esp: cff47f84
	ds: 0018   es: 0018   ss: 0018
	Process more (pid: 20846, stackpage=cff47000)
	Stack: cff46000 c0106c33 0000000b 00000000 d3ef2000 0000000b
cff47fbc c0105987
     	  bffffae4 c01059a7 00000000 00000a3a 00000020 bffffa5c dfd918e8
00000000
	       00000000 00000000 00000000 00000000 00000000 00000000
00000000 0000002b
	Call Trace:    [<c0106c33>] [<c0105987>] [<c01059a7>]
	
	Code: 8b 51 04 83 fa ff 0f 84 56 01 00 00 83 fa fc 77 07 c7 41
04

I run ksymoops with correct specified vmlinux and System.map, the result
shows:

	Warning (compare_maps): ksyms_base symbol
default_idle_R__ver_default_idle not f
	ound in vmlinux.  Ignoring ksyms_base entry
	Warning (compare_maps): ksyms_base symbol
machine_real_restart_R__ver_machine_re
	al_restart not found in vmlinux.  Ignoring ksyms_base entry
	Reading Oops report from the terminal
	Using defaults from ksymoops -t elf32-i386 -a i386
	
	 <1>Unable to handle kernel NULL pointer dereference at virtual
address 00000004
	dfd91718
	*pde = 00000000
	Oops: 0000
	CPU:    0
	EIP:    0010:[<dfd91718>]    Not tainted
	EFLAGS: 00010286
	eax: bffffae4   ebx: cff46000   ecx: 00000000   edx: cff46000
	esi: c0106c33   edi: 0000000b   ebp: cff47fb8   esp: cff47f84
	ds: 0018   es: 0018   ss: 0018
	Process more (pid: 20846, stackpage=cff47000)
	Stack: cff46000 c0106c33 0000000b 00000000 d3ef2000 0000000b
cff47fbc c0105987
	       bffffae4 c01059a7 00000000 00000a3a 00000020 bffffa5c
dfd918e8 00000000
	       00000000 00000000 00000000 00000000 00000000 00000000
00000000 0000002b
	Call Trace:    [<c0106c33>] [<c0105987>] [<c01059a7>]
	Code: 8b 51 04 83 fa ff 0f 84 56 01 00 00 83 fa fc 77 07 c7 41
04
	>>EIP; dfd91718 <_end+1fb00020/205fa908>   <=====
	
	>>eax; bffffae4 Before first symbol
	>>ebx; cff46000 <_end+fcb4908/205fa908>
	>>edx; cff46000 <_end+fcb4908/205fa908>
	>>esi; c0106c33 <system_call+2f/34>
	>>ebp; cff47fb8 <_end+fcb68c0/205fa908>
	>>esp; cff47f84 <_end+fcb688c/205fa908>
	
	Trace; c0106c33 <system_call+2f/34>
	Trace; c0105987 <sys_execve+2f/60>
	Trace; c01059a7 <sys_execve+4f/60>
	
	Code;  dfd91718 <_end+1fb00020/205fa908>
	00000000 <_EIP>:
	Code;  dfd91718 <_end+1fb00020/205fa908>   <=====
	   0:   8b 51 04                  mov    0x4(%ecx),%edx   <=====
	Code;  dfd9171b <_end+1fb00023/205fa908>
	   3:   83 fa ff                  cmp    $0xffffffff,%edx
	Code;  dfd9171e <_end+1fb00026/205fa908>
	   6:   0f 84 56 01 00 00         je     162 <_EIP+0x162>
dfd9187a <_end+1fb0018
	2/205fa908>
	Code;  dfd91724 <_end+1fb0002c/205fa908>
	   c:   83 fa fc                  cmp    $0xfffffffc,%edx
	Code;  dfd91727 <_end+1fb0002f/205fa908>
	   f:   77 07                     ja     18 <_EIP+0x18> dfd91730
<_end+1fb00038/
	205fa908>
	Code;  dfd91729 <_end+1fb00031/205fa908>
	  11:   c7 41 04 00 00 00 00      movl   $0x0,0x4(%ecx)

Linux jsgx 2.4.20 #2 Tue Mar 25 22:47:46 CST 2003 i686 unknown

Gnu C                  2.96
Gnu make               3.78.1
binutils               2.11.90.0.8
util-linux             2.10f
mount                  2.10r
modutils               2.4.13
e2fsprogs              1.32
pcmcia-cs              3.1.20
PPP                    2.4.1
isdn4k-utils           3.1beta7
Linux C Library        so.8.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.6
Net-tools              1.60
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded

I tested several situations, cann't get rid of it.

