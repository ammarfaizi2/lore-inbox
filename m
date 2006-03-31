Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWCaWux@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWCaWux (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 17:50:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWCaWux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 17:50:53 -0500
Received: from rune.pobox.com ([208.210.124.79]:3984 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1750720AbWCaWux (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 17:50:53 -0500
Date: Fri, 31 Mar 2006 16:50:34 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Markus Rothe <markus@unixforces.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: Oops: mounting floppy disk on PPC64 (power3)
Message-ID: <20060331225034.GA25663@localdomain>
References: <200603312138.16032.markus@unixforces.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603312138.16032.markus@unixforces.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Markus Rothe wrote:
> 
> this is kernel 2.6.16.1 compiled with gcc 4.1.0 (gentoo patches). I never 
> tried to mount a floppy on this system before, so I don't know if it Oops'ed 
> in previous kernel versions, too.
> 
> power3 ~ # uname -a
> Linux power3 2.6.16.1 #1 Fri Mar 31 21:08:43 UTC 2006 ppc64 POWER3 (630+) CHRP 
> IBM,7044-170 GNU/Linux
> power3 ~ # modprobe floppy
> power3 ~ # mount /mnt/floppy/
> Oops: Kernel access of bad area, sig: 11 [#1]
> NUMA PSERIES
> Modules linked in: floppy
> NIP: C0000000000201E8 LR: D0000000000C43A4 CTR: C0000000000201D8
> REGS: c0000000003df470 TRAP: 0300   Not tainted  (2.6.16.1)
> MSR: A000000000001032 <ME,IR,DR>  CR: 48000082  XER: 00000000
> DAR: 0000000000000178, DSISR: 0000000040000000
> TASK = c0000000003fc9b0[0] 'swapper' THREAD: c0000000003dc000
> GPR00: C00000000042FC08 C0000000003DF6F0 C0000000004D3310 0000000000000000
> GPR04: C00000000161D000 0000000000000400 0000000000000002 0000000000000750
> GPR08: 0000000000000064 D0000000000D4AE0 D0000000000D5F20 C0000000000201D8
> GPR12: D0000000000CB280 C0000000003FCF80 0000000000000000 0000000000000000
> GPR16: 0000000000000000 0000000000000000 4000000001400000 C0000000003595E0
> GPR20: C0000000003D1F28 00000000017D1A80 C0000000003D1A80 0000000000000060
> GPR24: 00000000000003F0 A000000000009032 0000000000000044 00000000000000D9
> GPR28: 0000000000000400 0000000000000002 D0000000000DB880 C00000000161D000
> NIP [C0000000000201E8] .dma_map_single+0x10/0x70
> LR [D0000000000C43A4] .setup_rw_floppy+0x2c0/0xaa8 [floppy]
> Call Trace:
> [C0000000003DF6F0] [D0000000000C5790] .start_motor+0x108/0x158 [floppy] 
> (unreli)
> [C0000000003DF760] [D0000000000C43A4] .setup_rw_floppy+0x2c0/0xaa8 [floppy]
> [C0000000003DF810] [C000000000044714] .run_timer_softirq+0x174/0x20c
> [C0000000003DF8B0] [C00000000003FC68] .__do_softirq+0x80/0x128
> [C0000000003DF940] [C00000000003FD5C] .do_softirq+0x4c/0x68
> [C0000000003DF9C0] [C00000000001C9E8] .timer_interrupt+0x360/0x388
> [C0000000003DFA90] [C0000000000034B8] decrementer_common+0xb8/0x100
> --- Exception: 901 at .ppc64_runlatch_off+0x0/0x50
>     LR = .default_idle+0x48/0x70
> [C0000000003DFD80] [C000000000016764] .default_idle+0x68/0x70 (unreliable)
> [C0000000003DFE00] [C0000000000166E8] .cpu_idle+0x40/0x54
> [C0000000003DFE70] [C0000000000092B0] .rest_init+0x3c/0x54
> [C0000000003DFEF0] [C0000000003B16D4] .start_kernel+0x1f0/0x208
> [C0000000003DFF90] [C000000000008514] .start_here_common+0x88/0x174
> Instruction dump:
> 4e800421 e8410028 48000008 0fe00000 38210070 e8010010 7c0803a6 4e800020
> 7c0802a6 f8010010 f821ff91 e80298d0 <e9230178> 7fa90000 409e000c e92298d8
> 
> Am I doing something wrong?

Nope.

I believe this was fixed in Linus' tree as of a couple days ago:

diff-tree b239cbe957ae730caa8af2f169a4d35b8c1bb299 (from
69ed3324983bb937d78a857Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Tue Mar 28 14:40:58 2006 +1100

    [PATCH] powerpc: make ISA floppies work again

    We used to assume that a DMA mapping request with a NULL dev was
    for
    ISA DMA.  This assumption was broken at some point.  Now we
    explicitly
    pass the detected ISA PCI device in the floppy setup.

    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>


Maybe you could verify with latest -git, or 2.6.17-rc1 when it's
released?

