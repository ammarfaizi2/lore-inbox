Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316768AbSGLSew>; Fri, 12 Jul 2002 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSGLSev>; Fri, 12 Jul 2002 14:34:51 -0400
Received: from ns.suse.de ([213.95.15.193]:45064 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316768AbSGLSes>;
	Fri, 12 Jul 2002 14:34:48 -0400
Date: Fri, 12 Jul 2002 20:37:37 +0200
From: Dave Jones <davej@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] 56 potential lock/unlock bugs in 2.5.8
Message-ID: <20020712203737.C18503@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roman Zippel <zippel@linux-m68k.org>,
	Thunder from the hill <thunder@ngforever.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20020712200507.G16956@suse.de> <Pine.LNX.4.44.0207122030040.8911-100000@serv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207122030040.8911-100000@serv>; from zippel@linux-m68k.org on Fri, Jul 12, 2002 at 08:32:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 08:32:20PM +0200, Roman Zippel wrote:
 > Which last few kernels? Was it a ffs or an ofs image? For ofs images you
 > have to call fsx with "-W -R" to disable mmap operations.

OFS afaik. Has this always been the case ? I'm sure I ran fsx without
disabling mmap before on this image, and it used to pass.

Second bad news, with the -W -R options, it goes splat in an
even more dramatic way.

    Dave.


Unable to handle kernel NULL pointer dereference at virtual address 00000008
c01f91a7
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01f91a7>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010296
eax: c01f9198   ebx: 000006a0   ecx: cff6bea8   edx: 00000000
esi: c133acc0   edi: cd352524   ebp: cefb6c00   esp: cd0efe9c
ds: 0018   es: 0018   ss: 0018
Process fsx (pid: 908, stackpage=cd0ef000)
Stack: 000006a0 c133acc0 cd352524 cefb6c00 cd352524 c01f9a26 00000000 c133acc0        000006a0 000006a0 000186a0 00000000 cd352474 00000000 00000000 cd352474        00000000 000000cc c0123f01 00000002 c0123f60 cd352474 00000048 cd0eff74 Call Trace: [<c01f9a26>] [<c0123f01>] [<c0123f60>] [<c0144eab>] [<c01f7bdf>] 
   [<c0144fe0>] [<c0131669>] [<c0131907>] [<c0106b73>] 
Code: 8b 42 08 31 d2 8b 48 08 8b 74 24 1c 8b 46 18 a9 08 00 00 00 


>>EIP; c01f91a7 <affs_prepare_write_ofs+f/fc>   <=====

>>eax; c01f9198 <affs_prepare_write_ofs+0/fc>
>>ebx; 000006a0 Before first symbol
>>ecx; cff6bea8 <END_OF_CODE+fabb96c/????>
>>esi; c133acc0 <END_OF_CODE+e8a784/????>
>>edi; cd352524 <END_OF_CODE+cea1fe8/????>
>>ebp; cefb6c00 <END_OF_CODE+eb066c4/????>
>>esp; cd0efe9c <END_OF_CODE+cc3f960/????>

Trace; c01f9a26 <affs_truncate+a6/375>
Trace; c0123f01 <vmtruncate+9d/124>
Trace; c0123f60 <vmtruncate+fc/124>
Trace; c0144eab <inode_setattr+23/b0>
Trace; c01f7bdf <affs_notify_change+77/94>
Trace; c0144fe0 <notify_change+5c/dc>
Trace; c0131669 <do_truncate+4d/64>
Trace; c0131907 <sys_ftruncate+107/11c>
Trace; c0106b73 <system_call+33/40>

Code;  c01f91a7 <affs_prepare_write_ofs+f/fc>
00000000 <_EIP>:
Code;  c01f91a7 <affs_prepare_write_ofs+f/fc>   <=====
   0:   8b 42 08                  mov    0x8(%edx),%eax   <=====
Code;  c01f91aa <affs_prepare_write_ofs+12/fc>
   3:   31 d2                     xor    %edx,%edx
Code;  c01f91ac <affs_prepare_write_ofs+14/fc>
   5:   8b 48 08                  mov    0x8(%eax),%ecx
Code;  c01f91af <affs_prepare_write_ofs+17/fc>
   8:   8b 74 24 1c               mov    0x1c(%esp,1),%esi
Code;  c01f91b3 <affs_prepare_write_ofs+1b/fc>
   c:   8b 46 18                  mov    0x18(%esi),%eax
Code;  c01f91b6 <affs_prepare_write_ofs+1e/fc>
   f:   a9 08 00 00 00            test   $0x8,%eax



-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
