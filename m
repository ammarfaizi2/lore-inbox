Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262182AbSJNU0H>; Mon, 14 Oct 2002 16:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbSJNU0H>; Mon, 14 Oct 2002 16:26:07 -0400
Received: from inet-mail3.oracle.com ([148.87.2.203]:61061 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S262182AbSJNU0F>; Mon, 14 Oct 2002 16:26:05 -0400
Message-ID: <8312592.1034627297477.JavaMail.nobody@web55.us.oracle.com>
Date: Mon, 14 Oct 2002 13:28:17 -0700 (PDT)
From: Bert Barbe <BERT.BARBE@oracle.com>
To: caligula@cam029208.student.utwente.nl, linux-kernel@vger.kernel.org
Subject: Re: 2.5.42:  Debug: sleeping function called from illegal context at mm/slab.c:1374
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ave,

I get a similar trace when using ifenslave to enslave eth0 or eth1 to bond0.
I use the bonding module with mode=1 for active backup mode.

kernel: bond0: enslaving eth1 as an active interface with an up link
kernel: Debug: sleeping function called from illegal context at mm/slab.c:1374
kernel: Call Trace:
kernel:  [<c01157b6>] __might_sleep+0x56/0x60
kernel:  [<c0130321>] kmalloc+0x61/0x200
kernel:  [<c02e4dcb>] kfree_skbmem+0xb/0x60
kernel:  [<c0270d50>] mii_ioctl+0x0/0x80
kernel:  [<d8847862>] bond_enslave+0xc2/0x300 [bonding]
kernel:  [<d8848ccd>] bond_ioctl+0x2bd/0x330 [bonding]
kernel:  [<c02e914a>] dev_change_flags+0xfa/0x110
kernel:  [<c02e94b7>] dev_ifsioc+0x357/0x380
kernel:  [<c02e96ff>] dev_ioctl+0x21f/0x2e0
kernel:  [<c031965d>] inet_ioctl+0xdd/0xf0
kernel:  [<c02e1df9>] sock_ioctl+0xd9/0x110
kernel:  [<c014d517>] sys_ioctl+0x247/0x290
kernel:  [<c0108d2f>] syscall_call+0x7/0xb
kernel:
kernel: bond0: enslaving eth0 as a backup interface with an up link.

Bert


> Ave people
> When using xmms with oss output I found this message in my dmesg.
> Kernel has alsa sound with oss emulation.
> Full dmesg/kernelconfig/lspci can be found at
> cam029208.student.utwente.nl/~caligula/kernel/
> ALSA device list:
>   #0: VIA 82C686A/B at 0xdc00, irq 10
> Debug: sleeping function called from illegal context at mm/slab.c:1374
> Call Trace:
>  [<c0115042>] __might_sleep+0x52/0x60
>  [<c012f8b1>] kmalloc+0x61/0x200
>  [<c01f72b6>] snd_pci_hack_alloc_consistent+0x56/0xc0
>  [<c01f3264>] __snd_kmalloc+0x14/0x80
>  [<c01f32e0>] snd_hidden_kmalloc+0x10/0x20
>  [<c022584d>] build_via_table+0x9d/0x1c0
>  [<c022584d>] build_via_table+0x9d/0x1c0
>  [<c0225dac>] snd_via82xx_setup_periods+0x2c/0x120
>  [<c0226191>] snd_via82xx_playback_prepare+0xb1/0xc0
>  [<c02093f7>] snd_pcm_prepare+0x127/0x230
>  [<c020b97f>] snd_pcm_playback_ioctl1+0x3af/0x3c0
>  [<c012ae5e>] find_get_page+0x1e/0x40
>  [<c012bb83>] filemap_nopage+0x103/0x280
>  [<c01327b9>] __alloc_pages+0x79/0x250
>  [<c020be07>] snd_pcm_kernel_playback_ioctl+0x27/0x30
>  [<c01fdab6>] snd_pcm_oss_prepare+0x16/0x60
>  [<c01fdb38>] snd_pcm_oss_make_ready+0x38/0x50
>  [<c01fdefa>] snd_pcm_oss_write1+0x3a/0x160
>  [<c020005b>] snd_pcm_oss_write+0x6b/0xa0
>  [<c013d8aa>] vfs_write+0xba/0x150
>  [<c013d9a8>] sys_write+0x28/0x40
>  [<c010716f>] syscall_call+0x7/0xb
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
