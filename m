Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266797AbRHKG1F>; Sat, 11 Aug 2001 02:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270727AbRHKG0z>; Sat, 11 Aug 2001 02:26:55 -0400
Received: from demai05.mw.mediaone.net ([24.131.1.56]:61408 "EHLO
	demai05.mw.mediaone.net") by vger.kernel.org with ESMTP
	id <S266797AbRHKG0l>; Sat, 11 Aug 2001 02:26:41 -0400
Message-Id: <200108110626.f7B6Qqh20362@demai05.mw.mediaone.net>
Content-Type: text/plain; charset=US-ASCII
From: Brian <hiryuu@envisiongames.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Oops/Panic in 2.4.7
Date: Sat, 11 Aug 2001 02:27:10 -0400
X-Mailer: KMail [version 1.3]
In-Reply-To: <200108080604.f7864wa22844@demai05.mw.mediaone.net>
In-Reply-To: <200108080604.f7864wa22844@demai05.mw.mediaone.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(here I go talking to myself now)

I did a little hunting and discovered that the two oops messages are 
actually only 2 lines apart: they're both in the no_context portion of 
do_page_fault.  Unfortunately, I'm not sure where/how/when do_page_fault 
gets called.

	-- Brian

On Wednesday 08 August 2001 02:05 am, Brian wrote:
> Affter about a week, our main web server coughed up at least four
> 	Unable to handle kernel NULL pointer dereference at virtual address...
> (klogd or syslogd died during the 4th) followed by a
> 	Unable to handle kernel paging request at virtual address ef2a571c
> It finally died with
> 	Kernel panic: Attempted to kill init!
>
> This kernel was compiled as UP w/modules disabled on
> 	gcc version 2.95.4 20010721 (Debian prerelease)
> We have also crashed 2.4.4 and 2.4.6 (both made with 2.95.2) within
> the past month, but I didn't drive out to get an oops from those.
>
> The server is a basic P3/750 with 512MB RAM and no swap (it was
> pretty much just getty and portmap in there, anyway).
>
> This is the last complete oops in syslog:
> ksymoops 2.4.1 on i686 2.4.7.  Options used
>      -v /tmp/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -O (specified)
>      -m /System.map (specified)
>
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000008 c0136a40
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[do_pollfd+20/136]
> EFLAGS: 00010297
> eax: 00000008   ebx: 00000000   ecx: 00000001   edx: c2fa88c0
> esi: 00000000   edi: 00000008   ebp: 00000000   esp: d94adf20
> ds: 0018   es: 0018   ss: 0018
> Process httpd (pid: 18289, stackpage=d94ad000)
> Stack: 00000000 00000000 bfff3dd8 000001f4 c0136b39 00000001 00000008
> d94adf58 d94adf5c 00000001 00000000 bfff3dd8 d94adfbc d94ac000 00000000
> 00000000 c0136d8d 00000001 00000000 00000001 c2fa88c0 d94adfb4 000001f5
> d94ac000 Call Trace: [do_poll+133/220] [sys_poll+509/784]
> [sys_socketcall+281/512] [system_call+51/56] Code: 8b 07 31 f6 85 c0 7c
> 56 e8 5b 2e ff ff 89 c3 be 20 00 00 00 Using defaults from ksymoops -t
> elf32-i386 -a i386
>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   8b 07                     mov    (%edi),%eax
> Code;  00000002 Before first symbol
>    2:   31 f6                     xor    %esi,%esi
> Code;  00000004 Before first symbol
>    4:   85 c0                     test   %eax,%eax
> Code;  00000006 Before first symbol
>    6:   7c 56                     jl     5e <_EIP+0x5e> 0000005e Before
> first symbol Code;  00000008 Before first symbol
>    8:   e8 5b 2e ff ff            call   ffff2e68 <_EIP+0xffff2e68>
> ffff2e68 <END_OF_CODE+3fdc3410/????> Code;  0000000d Before first symbol
>    d:   89 c3                     mov    %eax,%ebx
> Code;  0000000f Before first symbol
>    f:   be 20 00 00 00            mov    $0x20,%esi
>
> This is the oops immediately before the panic:
> ksymoops 2.4.1 on i686 2.4.7.  Options used
>      -v /tmp/vmlinux (specified)
>      -K (specified)
>      -L (specified)
>      -O (specified)
>      -m /System.map (specified)
>
> Unable to handle kernel paging request at virtual address ef2a571c
> c01210bc
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c01210bc>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010082
> eax: 081d70c1   ebx: c1881d40   ecx: df298c80   edx: ceb49400
> esi: 00000292   edi: 000000f0   ebp: bffff80c   esp: c188bf54
> ds: 0018   es: 0018   ss: 0018
> Process init (pid: 1, stackpage=c188b000)
> Stack: 0804dee7 fffffff4 c188bfa4 c013211c c1881d40 000000f0 c188bfa4
> bffff84c c188bfa4 c013301d 0804dee7 c188bfa4 bffff84c 0804dee7 c012ff16
> 0804dee7 00000009 c188bfa4 c188a000 bffff84c 00000000 c81fdee0 c81fdee4
> c81fdee8 Call Trace: [<c013211c>] [<c013301d>] [<c012ff16>] [<c0106afb>]
> Code: 8b 44 82 18 89 42 14 83 f8 ff 75 08 8b 02 89 43 08 8d 76 00
>
> >>EIP; c01210bc <kmem_cache_alloc+24/54>   <=====
>
> Trace; c013211c <getname+1c/9c>
> Trace; c013301d <__user_walk+11/58>
> Trace; c012ff16 <sys_newstat+16/70>
> Trace; c0106afb <system_call+33/38>
> Code;  c01210bc <kmem_cache_alloc+24/54>
> 00000000 <_EIP>:
> Code;  c01210bc <kmem_cache_alloc+24/54>   <=====
>    0:   8b 44 82 18               mov    0x18(%edx,%eax,4),%eax   <=====
> Code;  c01210c0 <kmem_cache_alloc+28/54>
>    4:   89 42 14                  mov    %eax,0x14(%edx)
> Code;  c01210c3 <kmem_cache_alloc+2b/54>
>    7:   83 f8 ff                  cmp    $0xffffffff,%eax
> Code;  c01210c6 <kmem_cache_alloc+2e/54>
>    a:   75 08                     jne    14 <_EIP+0x14> c01210d0
> <kmem_cache_alloc+38/54> Code;  c01210c8 <kmem_cache_alloc+30/54>
>    c:   8b 02                     mov    (%edx),%eax
> Code;  c01210ca <kmem_cache_alloc+32/54>
>    e:   89 43 08                  mov    %eax,0x8(%ebx)
> Code;  c01210cd <kmem_cache_alloc+35/54>
>   11:   8d 76 00                  lea    0x0(%esi),%esi
>
> Thanks,
> 	-- Brian
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
