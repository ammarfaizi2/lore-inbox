Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317445AbSFRPWo>; Tue, 18 Jun 2002 11:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317446AbSFRPWn>; Tue, 18 Jun 2002 11:22:43 -0400
Received: from ns2.arlut.utexas.edu ([129.116.174.1]:5389 "EHLO
	ns2.arlut.utexas.edu") by vger.kernel.org with ESMTP
	id <S317445AbSFRPWn>; Tue, 18 Jun 2002 11:22:43 -0400
Date: Tue, 18 Jun 2002 10:22:42 -0500
From: Jonathan Abbey <jonabbey@arlut.utexas.edu>
To: linux-kernel@vger.kernel.org
Cc: linux-bugs@nvidia.com
Subject: Re: oops in 2.4.18-3 kswapd?
Message-ID: <20020618102242.A23753@arlut.utexas.edu>
References: <20020618100046.A23353@arlut.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20020618100046.A23353@arlut.utexas.edu>; from jonabbey@arlut.utexas.edu on Tue, Jun 18, 2002 at 10:00:46AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies to the list.  I see in the recent archives that a
page_alloc.c bug trace report with Nvidia driver installed was sent to
/dev/null on account of possibly erroneous code in the Nvidia module.

I'll cc: this over to linux-bugs@nvidia.com, but I don't see how they
could diagnose anything here, other than to be informed that there are
allegations of memory stomping in their binary kernel driver?

I did see the following, from Andreas Dilger:
|
| Please reproduce the error without the nvidia driver loaded, or report
| the problem to the nvidia developers.  Unfortunately it is impossible
| to say what the source of the problem is, as it is possible the nvidia
| driver is overwriting memory elsewhere in the kernel and there is no
| way for anyone to check that.

So, um, poop.

On Tue, Jun 18, 2002 at 10:00:46AM -0500, Jonathan Abbey wrote:
> Got the following on a RedHat 7.3 system with, yes, the NVidia driver
> added.
> 
> Jun 18 04:03:38 greatland kernel: ------------[ cut here ]------------
> Jun 18 04:03:38 greatland kernel: kernel BUG at page_alloc.c:117!
> Jun 18 04:03:38 greatland kernel: invalid operand: 0000
> Jun 18 04:03:38 greatland kernel: sr_mod es1371 ac97_codec gameport soundcore agpgart NVdriver binfmt_misc autof
> Jun 18 04:03:38 greatland kernel: CPU:    0
> Jun 18 04:03:38 greatland kernel: EIP:    0010:[<c0132dc7>]    Tainted: P 
> Jun 18 04:03:38 greatland kernel: EFLAGS: 00010282
> Jun 18 04:03:38 greatland kernel: 
> Jun 18 04:03:38 greatland kernel: EIP is at __free_pages_ok [kernel] 0x57 (2.4.18-3)
> Jun 18 04:03:38 greatland kernel: eax: 00000020   ebx: c1128170   ecx: 00000001   edx: 0001f4fb
> Jun 18 04:03:38 greatland kernel: esi: 00000000   edi: c02ccf5c   ebp: 00000000   esp: c1715f58
> Jun 18 04:03:38 greatland kernel: ds: 0018   es: 0018   ss: 0018
> Jun 18 04:03:38 greatland kernel: Process kswapd (pid: 5, stackpage=c1715000)
> Jun 18 04:03:38 greatland kernel: Stack: c0229d95 00000075 d03a01c0 c1128170 c013e783 dfe90200 c130a3e0 00000030 
> Jun 18 04:03:38 greatland kernel:        c013c8da c1128170 c112818c c02ccf5c d03a01c0 c0130844 c1128170 00000030 
> Jun 18 04:03:38 greatland kernel:        c1128170 c112818c c02ccf5c 000002b8 c0131e06 ffffe762 c1714000 c02ccf84 
> Jun 18 04:03:38 greatland kernel: Call Trace: [<c013e783>] try_to_free_buffers [kernel] 0xb3 
> Jun 18 04:03:38 greatland kernel: [<c013c8da>] try_to_release_page [kernel] 0x3a 
> Jun 18 04:03:38 greatland kernel: [<c0130844>] drop_page [kernel] 0x34 
> Jun 18 04:03:38 greatland kernel: [<c0131e06>] refill_inactive_zone [kernel] 0x206 
> Jun 18 04:03:38 greatland kernel: [<c0132770>] kswapd [kernel] 0x280 
> Jun 18 04:03:38 greatland kernel: [<c0105000>] stext [kernel] 0x0 
> Jun 18 04:03:38 greatland kernel: [<c0107136>] kernel_thread [kernel] 0x26 
> Jun 18 04:03:38 greatland kernel: [<c01324f0>] kswapd [kernel] 0x0 
> Jun 18 04:03:38 greatland kernel: 
> Jun 18 04:03:38 greatland kernel: 
> Jun 18 04:03:38 greatland kernel: Code: 0f 0b 5d 58 8b 3d d0 17 34 c0 89 d8 29 f8 69 c0 b7 6d db b6 

-- 
-------------------------------------------------------------------------------
Jonathan Abbey 				              jonabbey@arlut.utexas.edu
Applied Research Laboratories                 The University of Texas at Austin
Ganymede, a GPL'ed metadirectory for UNIX     http://www.arlut.utexas.edu/gash2
