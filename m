Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261647AbUJaPBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261647AbUJaPBd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261638AbUJaPBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:01:33 -0500
Received: from av3-2-sn1.fre.skanova.net ([81.228.11.110]:28083 "EHLO
	av3-2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261653AbUJaO7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:59:55 -0500
To: kraxel@bytesex.org
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.6.10-rc1 bttv oops in btcx_riscmem_free
References: <41839BFC.1070302@eyal.emu.id.au> <m3wtx86s07.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 31 Oct 2004 15:59:38 +0100
In-Reply-To: <m3wtx86s07.fsf@telia.com>
Message-ID: <m3vfcrszl1.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Eyal Lebedinsky <eyal@eyal.emu.id.au> writes:
> 
> > Watching on Mythtv, I stopped watching on the client. at this point
> > the picture froze. Looking in dmesg I see this oops. The machine
> > quicly becomes unusable ('ps aux' hangs).
> > 
> > I then applied the v4l patches off the list. Still the same problem.
> > 
> > Unable to handle kernel paging request at virtual address 85525fe9
> 
> I have similar problems using 2.6.10-rc1-bk8. Often when I exit
> tvtime, I get "unable to handle kernel paging request" or "unable to
> handle kernel NULL pointer", see below.
> 
> The previous kernel I used on this machine was 2.6.9-rc3-bk9, which
> does not have this problem.

I've found that I can't trigger the oops if I revert these two patches:

http://linus.bkbits.net:8080/linux-2.5/cset@417681b1ZY5TxMjPnGdT0mbmUVn_Aw?nav=index.html|ChangeSet@-2w
http://linus.bkbits.net:8080/linux-2.5/cset@41768196E6i6bbiUnhTg9OFubLPWHA?nav=index.html|ChangeSet@-2w


> Oct 30 14:12:55 p4 kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000011
> Oct 30 14:12:55 p4 kernel:  printing eip:
> Oct 30 14:12:55 p4 kernel: c010a237
> Oct 30 14:12:55 p4 kernel: *pde = 00000000
> Oct 30 14:12:55 p4 kernel: Oops: 0000 [#1]
> Oct 30 14:12:55 p4 kernel: PREEMPT 
> Oct 30 14:12:55 p4 kernel: Modules linked in: snd_pcm_oss tuner tda9887 msp3400 bttv video_buf firmware_class v4l2_common btcx_risc videodev snd_mixer_oss snd_emu10k1 snd_rawmidi snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore radeon nfsd exportfs lockd parport_pc lp parport autofs4 sunrpc ipt_MASQUERADE iptable_nat ipt_LOG ipt_limit ipt_state ipt_REJECT iptable_filter ip_tables sd_mod dm_mod usb_storage uhci_hcd ehci_hcd rtc
> Oct 30 14:12:55 p4 kernel: CPU:    0
> Oct 30 14:12:55 p4 kernel: EIP:    0060:[<c010a237>]    Not tainted VLI
> Oct 30 14:12:55 p4 kernel: EFLAGS: 00210206   (2.6.10-rc1-bk8) 
> Oct 30 14:12:55 p4 kernel: EIP is at dma_free_coherent+0x30/0x67
> Oct 30 14:12:55 p4 kernel: eax: 00000000   ebx: e429d000   ecx: e429d000   edx: 00000000
> Oct 30 14:12:55 p4 kernel: esi: 00000011   edi: e3a14f34   ebp: eac6a800   esp: de55bee4
> Oct 30 14:12:55 p4 kernel: ds: 007b   es: 007b   ss: 0068
> Oct 30 14:12:55 p4 kernel: Process tvtime (pid: 5018, threadinfo=de55a000 task=e19ac580)
> Oct 30 14:12:55 p4 kernel: Stack: e7b3d680 e3a14e80 f8a3203d e7b3d6c4 00000c38 e429d000 2429d000 e3a14ea4 
> Oct 30 14:12:55 p4 kernel:        e7b3d880 f8d2fb35 e7b3d680 e3a14f34 00000000 00000000 e79e7720 ee3744bc 
> Oct 30 14:12:55 p4 kernel:        f8afbc55 e7b3d880 e3a14e80 00035000 eac6a800 de55a000 de55a000 e7861c80 
> Oct 30 14:12:55 p4 kernel: Call Trace:
> Oct 30 14:12:55 p4 kernel:  [<f8a3203d>] btcx_riscmem_free+0x3d/0x84 [btcx_risc]
> Oct 30 14:12:55 p4 kernel:  [<f8d2fb35>] bttv_dma_free+0x74/0x9f [bttv]
> Oct 30 14:12:55 p4 kernel:  [<f8afbc55>] videobuf_vm_close+0x97/0xc9 [video_buf]
> Oct 30 14:12:55 p4 kernel:  [<c014348b>] remove_vm_struct+0x8e/0x97
> Oct 30 14:12:55 p4 kernel:  [<c0144c85>] unmap_vma_list+0x1c/0x28
> Oct 30 14:12:55 p4 kernel:  [<c0145008>] do_munmap+0x142/0x17f
> Oct 30 14:12:55 p4 kernel:  [<c0145089>] sys_munmap+0x44/0x64
> Oct 30 14:12:55 p4 kernel:  [<c0103fbd>] sysenter_past_esp+0x52/0x71
> Oct 30 14:12:55 p4 kernel: Code: 44 24 0c 8b 54 24 10 8b 5c 24 14 85 c0 74 06 8b b0 b8 00 00 00 8d 42 ff ba ff ff ff ff c1 e8 0b 83 c2 01 d1 e8 75 f9 85 f6 74 13 <8b> 0e 39 cb 72 0d 8b 46 08 c1 e0 0c 8d 04 08 39 c3 72 09 89 d8 

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
