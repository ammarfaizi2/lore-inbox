Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161374AbWI2SVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161374AbWI2SVo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161380AbWI2SVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:21:44 -0400
Received: from proof.pobox.com ([207.106.133.28]:36308 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S1161374AbWI2SVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:21:43 -0400
Date: Fri, 29 Sep 2006 13:24:43 -0500
From: Jon Mason <jdmason@kudzu.us>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Jon Mason <jdmason@kudzu.us>, Jeff Garzik <jeff@garzik.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Jim Paradis <jparadis@redhat.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86[-64] PCI domain support
Message-ID: <20060929182443.GB2308@kudzu.us>
References: <20060926191508.GA6350@havoc.gtf.org> <20060928093332.GG22787@rhun.haifa.ibm.com> <451B99C5.7080809@garzik.org> <20060928224550.GJ22787@rhun.haifa.ibm.com> <20060929134330.GA1687@kudzu.us> <20060929171119.GM22787@rhun.haifa.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060929171119.GM22787@rhun.haifa.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2006 at 08:11:19PM +0300, Muli Ben-Yehuda wrote:
> On Fri, Sep 29, 2006 at 08:43:31AM -0500, Jon Mason wrote:
> 
> > Nak!  The calgary code should not be affected by these patches.
> 
> It is. It triggers the BUG() I put there exactly in case someone tries
> to grab ->sysdata from uder us.
> 
> PCI-DMA: Using Calgary IOMMU
> Calgary: dev ffff8101979a7800 has sysdata ffff81019795f620
> ----------- [cut here ] --------- [please bite here ] ---------
> Kernel BUG at ...uli/w/iommu/calgary/linux/arch/x86_64/kernel/tce.c:143
> invalid opcode: 0000 [1] SMP
> CPU 1
> Modules linked in:
> Pid: 1, comm: swapper Not tainted 2.6.18mx #115
> RIP: 0010:[<ffffffff8021b38c>]  [<ffffffff8021b38c>] build_tce_table+0x2b/0x126
> RSP: 0000:ffff810197c7de70  EFLAGS: 00010282
> RAX: 000000000000003e RBX: 00000000ffffffc3 RCX: 0000000000000000
> RDX: ffffffff8022e3ee RSI: 0000000000000000 RDI: ffff810197c67040
> RBP: ffff810197c7de90 R08: 0000000000000002 R09: ffffffff8022df0a
> R10: 0000000000000000 R11: ffffffff80762280 R12: ffffc20000080000
> R13: ffff8101979a7800 R14: ffffc20000080000 R15: 00000000ffffffed
> FS:  0000000000000000(0000) GS:ffff810197c75cc0(0000) knlGS:0000000000000000
> CS:  0010 DS: 0018 ES: 0018 CR0: 000000ffff80c728db 0000000000000000 00000000000 00000
>  ffffffff80c9cf18 0000000000000000 0000000000000000 0000000000000000
> Call Trace:
>  [<ffffffff80c728db>] calgary_iommu_init+0x11e/0x569
>  [<ffffffff80c6b6fe>] pci_iommu_init+0x9/0x17
>  [<ffffffff8020718d>] init+0x145/0x300
>  [<ffffffff805d8e51>] trace_hardirqs_on_thunk+0x35/0x37
>  [<ffffffff80244a46>] trace_hardirqs_on+0xfe/0x129
>  [<ffffffff8020a6c8>] child_rip+0xa/0x12
>  [<ffffffff805d95ea>] _spin_unlock_irq+0x29/0x2f
>  [<ffffffff80209e4d>] restore_args+0x0/0x30
>  [<ffffffff80207048>] init+0x0/0x300
>  [<ffffffff8020a6be>] child_rip+0x0/0x12
> 
> > The PCI domain code uses the sysdata pointer from struct pci_bus,
> > where as calgary uses the sysdata pointer from struct pci_dev.  This
> > should not be an issue.  Can you confirm actual breakage?
> 
> See above. This is with mainline + Jeff's PCI domains patch.
> 
> In any case, even if it wasn't necessary, I'd like to take advantage
> of Jeff's sysdata changes and get rid of our hack, as having an
> extensible struct hanging of ->sysdata is the right way to go
> forward.

I'm not sure why the above is happening, but I'll buy the clean-up :-).
The patch you sent out looks fine to me too.

Thanks,
Jon

> 
> Cheers,
> Muli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
