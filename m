Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291074AbSBLOLz>; Tue, 12 Feb 2002 09:11:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291062AbSBLOLp>; Tue, 12 Feb 2002 09:11:45 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:3592
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S291072AbSBLOLe>; Tue, 12 Feb 2002 09:11:34 -0500
Subject: Re: 2.4.18-pre9-xfs-shawn4  -  kmem_cache_alloc oops
From: Shawn Starr <spstarr@sh0n.net>
To: Dag Bakke <dag@bakke.com>
Cc: Linux <linux-kernel@vger.kernel.org>, xfs <linux-xfs@oss.sgi.com>
In-Reply-To: <20020212141007.B223@dagb>
In-Reply-To: <20020212141007.B223@dagb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99 (Preview Release)
Date: 12 Feb 2002 09:13:49 -0500
Message-Id: <1013523257.262.3.camel@unaropia>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Interesting, I have CONFIG_PNPBIOS on.
What other filesystems do you have or is it just XFS only?

Shawn.


On Tue, 2002-02-12 at 08:10, Dag Bakke wrote:
> After ditching hpfs support, I got the kernel to boot. I do get one
> ooops during boot, though.
> I'll try ditching CONFIG_PNPBIOS and see if that makes a difference.
> 
> Thanks,
> 
> Dag B
> 
> 
> 
> root@dagb:/usr/src/kernelpatches# ksymoops < ~dagb/kerneloops2.txt 
> ksymoops 2.4.3 on i686 2.4.18-pre9-xfs-shawn4.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.18-pre9-xfs-shawn4/ (default)
>      -m /usr/src/linux/System.map (default)
> 
> Warning: You did not tell me where to find symbol information.  I will
> assume that the log matches the kernel and modules that are running
> right now and I'll use the default options above for symbol resolution.
> If the current kernel and/or modules do not match the log, you can get
> more accurate output by telling me the kernel version and where to find
> map, modules, ksyms etc.  ksymoops -h explains the options.
> 
> Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c02fb0c0, System.map says c0150450.  Ignoring ksyms_base entry
> Unable to handle kernel NULL pointer dereference at virtual address 0000002c
> c012a994
> *pde = 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<c012a994>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010046
> eax: 00000000   ebx: 00000008   ecx: c1374000   edx: 00000000
> esi: 00000000   edi: c0444880   ebp: 000001f0   esp: c1375f90
> ds: 0018   es: 0018   ss: 0018
> Process swapper (pid: 2, stackpage=c1375000)
> Stack: 00000000 00000000 c0444880 c1375fd4 c011d6f8 00000000 000001f0 c1374000 
>        00000000 00000000 c011f6c3 00000000 00010f00 cffe7fb8 c0114982 00000000 
>        00000000 0008e000 c02d67b1 00010f00 cffe7fb8 00000000 0008e000 c01054df 
> Call Trace: [<c011d6f8>] [<c011f6c3>] [<c0114982>] [<c02d67b1>] [<c01054df>] 
>    [<c01054e8>] 
> Code: f6 46 2c 01 74 02 0f 0b 9c 5f fa 8b 4e 08 39 d9 75 22 8b 4e 
> 
> >>EIP; c012a994 <kmem_cache_alloc+24/b0>   <=====
> Trace; c011d6f8 <alloc_uid+48/c0>
> Trace; c011f6c2 <set_user+12/60>
> Trace; c0114982 <reparent_to_init+122/130>
> Trace; c02d67b0 <pnp_dock_thread+10/f0>
> Trace; c01054de <kernel_thread+1e/40>
> Trace; c01054e8 <kernel_thread+28/40>
> Code;  c012a994 <kmem_cache_alloc+24/b0>
> 00000000 <_EIP>:
> Code;  c012a994 <kmem_cache_alloc+24/b0>   <=====
>    0:   f6 46 2c 01               testb  $0x1,0x2c(%esi)   <=====
> Code;  c012a998 <kmem_cache_alloc+28/b0>
>    4:   74 02                     je     8 <_EIP+0x8> c012a99c <kmem_cache_alloc+2c/b0>
> Code;  c012a99a <kmem_cache_alloc+2a/b0>
>    6:   0f 0b                     ud2a   
> Code;  c012a99c <kmem_cache_alloc+2c/b0>
>    8:   9c                        pushf  
> Code;  c012a99c <kmem_cache_alloc+2c/b0>
>    9:   5f                        pop    %edi
> Code;  c012a99e <kmem_cache_alloc+2e/b0>
>    a:   fa                        cli    
> Code;  c012a99e <kmem_cache_alloc+2e/b0>
>    b:   8b 4e 08                  mov    0x8(%esi),%ecx
> Code;  c012a9a2 <kmem_cache_alloc+32/b0>
>    e:   39 d9                     cmp    %ebx,%ecx
> Code;  c012a9a4 <kmem_cache_alloc+34/b0>
>   10:   75 22                     jne    34 <_EIP+0x34> c012a9c8 <kmem_cache_alloc+58/b0>
> Code;  c012a9a6 <kmem_cache_alloc+36/b0>
>   12:   8b 4e 00                  mov    0x0(%esi),%ecx
> 
> 
> 2 warnings issued.  Results may not be reliable.
> 


