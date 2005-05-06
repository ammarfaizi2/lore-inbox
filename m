Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVEFFlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVEFFlW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 01:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbVEFFlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 01:41:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:21257 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261152AbVEFFlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 01:41:12 -0400
Date: Fri, 6 May 2005 07:28:03 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
Cc: openafs-info@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Message-ID: <20050506052803.GE777@alpha.home.local>
References: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505060209040.31479@tassadar.physics.auth.gr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 06, 2005 at 02:55:40AM +0300, Dimitris Zilaskos wrote:
> 
> 	Hello ,
> 
> [1.] One line summary of the problem:
> 
> Oopses on an openafs client system using openafs 1.3.78 and kernel 2.4.29.
> Oopses also occur afer moving to kernel 2.4.30 and openafs 1.3.82

The problem you encounter on 2.4.30 is not the same as on 2.4.29. The problem
in 2.4.29 is related to link_path_walk, which has been fixed in 2.4.30.

You might want to try 1.3.78 (or other) with 2.4.29-hf7 to check if your
2.4.30 problem was brought by kernel 2.4.30 or openafs 1.3.82, as the
link_path_walk bug is also fixed in hf7. The patch is available on :

     http://linux.exosec.net/kernel/2.4-hf/

Regards,
Willy

 
> Linux version 2.4.29 (root@system) (gcc version 3.3.4) #1 SMP Sun Mar 1
> 10:29:35 EEST 2005

(...) 

> >>EIP; c014d88b <link_path_walk+55b/9e0>   <=====
> 
> >>edx; efd41760 <_end+2f8df1b4/30431ab4>
> >>esi; cb519009 <_end+b0b6a5d/30431ab4>
> >>ebp; c5083f98 <_end+4c219ec/30431ab4>
> >>esp; c5083f24 <_end+4c21978/30431ab4>
> 
> Trace; c014df19 <path_lookup+39/40>
> Trace; c014e279 <__user_walk+49/60>
> Trace; c0153020 <filldir64+0/130>
> Trace; c014a1ff <sys_lstat64+1f/90>
> Trace; c0108ebb <system_call+33/38>
> 
> Code;  c014d88b <link_path_walk+55b/9e0>
> 00000000 <_EIP>:
> Code;  c014d88b <link_path_walk+55b/9e0>   <=====
>    0:   8b 43 38                  mov    0x38(%ebx),%eax   <=====
> Code;  c014d88e <link_path_walk+55e/9e0>
>    3:   85 c0                     test   %eax,%eax
> Code;  c014d890 <link_path_walk+560/9e0>
>    5:   0f 84 83 00 00 00         je     8e <_EIP+0x8e>
> Code;  c014d896 <link_path_walk+566/9e0>
>    b:   f0 fe 0d e0 99 41 c0      lock decb 0xc04199e0
> Code;  c014d89d <link_path_walk+56d/9e0>
>   12:   0f 88 00 00 00 00         js     18 <_EIP+0x18>
> 

(...) 

> Linux version 2.4.30 (root@system) (gcc version 3.3.4) #1 SMP Wed May 4 
> 15:10:58 EEST 2005

(...) 

> >>EIP; c015a980 <iput+310/320>   <=====
> 
> >>ebx; c671db40 <_end+62b5700/3042bc20>
> >>ecx; c671db50 <_end+62b5710/3042bc20>
> >>edx; c671db50 <_end+62b5710/3042bc20>
> >>esi; eed14800 <_end+2e8ac3c0/3042bc20>
> >>esp; effddf40 <_end+2fb75b00/3042bc20>
> 
> Trace; c0157571 <dput+31/190>
> Trace; c01579ce <prune_dcache+fe/190>
> Trace; c0157da4 <shrink_dcache_memory+24/40>
> Trace; c013937e <try_to_free_pages_zone+7e/100>
> Trace; c0139526 <kswapd_balance_pgdat+66/b0>
> Trace; c0139598 <kswapd_balance+28/40>
> Trace; c01396d8 <kswapd+98/b9>
> Trace; c0105000 <_stext+0/0>
> Trace; c010740e <arch_kernel_thread+2e/40>
> Trace; c0139640 <kswapd+0/b9>
> 
> Code;  c015a980 <iput+310/320>
> 00000000 <_EIP>:
> Code;  c015a980 <iput+310/320>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c015a982 <iput+312/320>
>    2:   b4 04                     mov    $0x4,%ah
> Code;  c015a984 <iput+314/320>
>    4:   72 bd                     jb     ffffffc3 <_EIP+0xffffffc3>
> Code;  c015a986 <iput+316/320>
>    6:   34 c0                     xor    $0xc0,%al
> Code;  c015a988 <iput+318/320>
>    8:   e9 0a fd ff ff            jmp    fffffd17 <_EIP+0xfffffd17>
> Code;  c015a98d <iput+31d/320>
>    d:   8d 76 00                  lea    0x0(%esi),%esi
> Code;  c015a990 <force_delete+0/20>
>   10:   8b 54 24 04               mov    0x4(%esp),%edx
