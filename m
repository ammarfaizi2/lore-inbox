Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262614AbRE3Fe2>; Wed, 30 May 2001 01:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262615AbRE3FeS>; Wed, 30 May 2001 01:34:18 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:8576 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S262614AbRE3FeM>;
	Wed, 30 May 2001 01:34:12 -0400
Date: Wed, 30 May 2001 07:33:40 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Stephen Thomas <stephen.thomas@insignia.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reproducible oops when loading ns558.o in 2.4.5-ac4
Message-ID: <20010530073340.B375@suse.cz>
In-Reply-To: <3B141DCD.C2CE9BCD@insignia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B141DCD.C2CE9BCD@insignia.com>; from stephen.thomas@insignia.com on Tue, May 29, 2001 at 11:08:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 11:08:13PM +0100, Stephen Thomas wrote:

Just one question: How to reproduce it? Just by loading the module?

> ksymoops 2.3.7 on i686 2.4.5-ac4.  Options used
>      -v linux-2.4.5-ac4/vmlinux (specified)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.5-ac4/ (default)
>      -m linux-2.4.5-ac4/System.map (specified)
> 
> May 29 22:40:52 wycliffe kernel: Unable to handle kernel paging request at virtual address 3d83537a 
> May 29 22:40:52 wycliffe kernel: c01a8d27 
> May 29 22:40:52 wycliffe kernel: *pde = 00000000 
> May 29 22:40:52 wycliffe kernel: Oops: 0000 
> May 29 22:40:52 wycliffe kernel: CPU:    0 
> May 29 22:40:52 wycliffe kernel: EIP:    0010:[isapnp_find_dev+59/256] 
> May 29 22:40:52 wycliffe kernel: EFLAGS: 00010213 
> May 29 22:40:52 wycliffe kernel: eax: 3d835356   ebx: cc8a36e4   ecx: 00000000   edx: cc8a348c 
> May 29 22:40:52 wycliffe kernel: esi: 00000002   edi: 00000002   ebp: 00000100   esp: cb12dedc 
> May 29 22:40:52 wycliffe kernel: ds: 0018   es: 0018   ss: 0018 
> May 29 22:40:52 wycliffe kernel: Process modprobe (pid: 662, stackpage=cb12d000) 
> May 29 22:40:52 wycliffe kernel: Stack: cc8a36e4 cc8a348c 00000001 cc8a382c cc8a3000 cc8a3824 000000ff 0002382c  
> May 29 22:40:52 wycliffe kernel:        cc8a34f5 00000000 00000002 00000100 cc8a348c cc8a3000 cc8a348c c0114b28  
> May 29 22:40:52 wycliffe kernel:        cb12c000 0804b52b 08061d70 bfffc45c 00000001 cc8a1000 cc8a1000 cc8a3818  
> May 29 22:40:52 wycliffe kernel: Call Trace: [<cc8a36e4>] [<cc8a348c>] [<cc8a382c>] [<cc8a3000>] [<cc8a3824>]  
> May 29 22:40:52 wycliffe kernel:    [<cc8a34f5>] [<cc8a348c>] [<cc8a3000>] [<cc8a348c>] [sys_init_module+1424/1588] [<cc8a1000>]  
> May 29 22:40:52 wycliffe kernel:    [<cc8a1000>] [<cc8a3818>] [<cc8a1000>] [<cc8a3060>] [system_call+51/56]  
> May 29 22:40:52 wycliffe kernel: Code: 66 39 78 24 75 0a 66 39 68 26 0f 84 ab 00 00 00 31 c9 8d 70  
> Using defaults from ksymoops -t elf32-i386 -a i386
> 
> Trace; cc8a36e4 <[ns558]pnp_devids+4/48>
> Trace; cc8a348c <[ns558]init_module+0/0>
> Trace; cc8a382c <[ns558].bss.end+15/1d>
> Trace; cc8a3000 <[gameport]__kstrtab_gameport_cooked_read+1a47/1aa7>
> Trace; cc8a3824 <[ns558].bss.end+d/1d>
> Trace; cc8a34f5 <[ns558]ns558_init+69/90>
> Trace; cc8a348c <[ns558]init_module+0/0>
> Trace; cc8a3000 <[gameport]__kstrtab_gameport_cooked_read+1a47/1aa7>
> Trace; cc8a348c <[ns558]init_module+0/0>
> Trace; cc8a1000 <[joydev]__module_device+185d/18bd>
> Trace; cc8a3818 <[ns558].bss.end+1/1d>
> Trace; cc8a1000 <[joydev]__module_device+185d/18bd>
> Trace; cc8a3060 <[ns558]ns558_isa_probe+0/2b8>
> Code;  00000000 Before first symbol
> 00000000 <_EIP>:
> Code;  00000000 Before first symbol
>    0:   66 39 78 24               cmp    %di,0x24(%eax)
> Code;  00000004 Before first symbol
>    4:   75 0a                     jne    10 <_EIP+0x10> 00000010 Before first symbol
> Code;  00000006 Before first symbol
>    6:   66 39 68 26               cmp    %bp,0x26(%eax)
> Code;  0000000a Before first symbol
>    a:   0f 84 ab 00 00 00         je     bb <_EIP+0xbb> 000000bb Before first symbol
> Code;  00000010 Before first symbol
>   10:   31 c9                     xor    %ecx,%ecx
> Code;  00000012 Before first symbol
>   12:   8d 70 00                  lea    0x0(%eax),%esi
> 
> The module loaded OK in 2.4.5-ac3.  input, joydev, ns558, gameport and analog
> are all configured as modules.
> 
> Stephen Thomas

-- 
Vojtech Pavlik
SuSE Labs
