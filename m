Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271917AbRHVCtU>; Tue, 21 Aug 2001 22:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271918AbRHVCtK>; Tue, 21 Aug 2001 22:49:10 -0400
Received: from femail46.sdc1.sfba.home.com ([24.254.60.40]:49545 "EHLO
	femail46.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S271917AbRHVCsx>; Tue, 21 Aug 2001 22:48:53 -0400
Message-ID: <3B831CDF.4CC930A7@didntduck.org>
Date: Tue, 21 Aug 2001 22:45:51 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul <set@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] repeatable 2.4.8-ac7, 2.4.7-ac6 just run xdos
In-Reply-To: <20010819004703.A226@squish.home.loc>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul wrote:
> 
> * Kernel oops, and locks up when I run xdos (dosemu)
> 
> * Occuring in both 2.4.7-ac6 and 2.4.8-ac7. Run 'xdos' in X, and
>   machine locks hard, only output to console is oops. (no sysrq)
>   Tried once with strace, but no oops. (didnt wait long, though)
>   Some oops before window is placed, some a little while after.
>   (mouse movement?) Repeatable.
> 
> * Kernels are virgin linus patched with ac. AMD-K6(tm) 3D
>   processor
> 
> * If anyone wants any more info or for me to do anything, just
>   ask.
> 
> Paul
> set@pobox.com
> 
> (2.4.7-ac6 -- two captured, identitcal, first shown)
> 
> ksymoops 2.4.1 on i586 2.4.7-ac6.  Options used
>      -V (default)
>      -k /proc/ksyms (default)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.7-ac6/ (default)
>      -m /boot/System.map-2.4.7-ac6 (specified)
> 
> CPU:    0
> EIP:    0010:[<c0180a18>]
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010002
> eax: 00001000   ebx: c4562368   ecx: 00000000   edx: 00000001
> esi: c4562368   edi: c4a954d4   ebp: 00000001   esp: c6887d88
> ds: 008   es: 0000   ss: 0018
                ^^^^
Here is your problem.  %es is set to the null segment.  I had my
suspicions about the segment reload optimisation in the -ac kernels, and
this proves it.  Try backing out the changes to arch/i386/kernel/entry.S
and include/asm-i386/hw_irq.h and see if that fixes the problem.

-- 

						Brian Gerst
