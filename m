Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261558AbSJHJHb>; Tue, 8 Oct 2002 05:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261565AbSJHJHa>; Tue, 8 Oct 2002 05:07:30 -0400
Received: from tallinn.cv.ee ([194.126.117.36]:52871 "EHLO woman.cv.ee")
	by vger.kernel.org with ESMTP id <S261558AbSJHJHZ>;
	Tue, 8 Oct 2002 05:07:25 -0400
Date: Tue, 8 Oct 2002 10:50:32 +0300 (EEST)
From: Janek <janek@tartu.cv.ee>
X-X-Sender: janek@woman.cv.ee
To: linux-kernel@vger.kernel.org
Subject: 2.5.41 sleeping function called from illegal context at mm/slab.c:1374
Message-ID: <Pine.LNX.4.44.0210081041530.8049-100000@woman.cv.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get three of these messages with 2.5.41 on ASUS K7M motherboard:

VP_IDE: VIA vt82c686a (rev 1b) IDE UDMA66 controller on pci00:04.1
    ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:pio, hdd:DMA
hda: IBM-DPTA-372050, ATA DISK drive
hda: DMA disabled
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c01148f2>] __might_sleep+0x52/0x60
 [<c012ef56>] kmem_cache_alloc+0x26/0x1a0
 [<c0206b50>] blk_init_free_list+0x60/0xf0
 [<c0206bec>] blk_init_queue+0xc/0xe0
 [<c021b078>] ide_init_queue+0x28/0x70
 [<c0221470>] do_ide_request+0x0/0x20
 [<c021b330>] init_irq+0x270/0x320
 [<c021b6b6>] hwif_init+0x106/0x240
 [<c021af9c>] probe_hwif_init+0x1c/0x70
 [<c022b429>] ide_setup_pci_device+0x39/0x60
 [<c021a003>] via_init_one+0x33/0x40
 [<c0105098>] init+0x38/0x1a0
 [<c0105060>] init+0x0/0x1a0
 [<c01054d9>] kernel_thread_helper+0x5/0xc

ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdd: NEC CD-ROM DRIVE:282, ATAPI CD/DVD-ROM drive
hdd: DMA disabled
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c01148f2>] __might_sleep+0x52/0x60
 [<c012ef56>] kmem_cache_alloc+0x26/0x1a0
 [<c0206b50>] blk_init_free_list+0x60/0xf0
 [<c0206bec>] blk_init_queue+0xc/0xe0
 [<c021b078>] ide_init_queue+0x28/0x70
 [<c0221470>] do_ide_request+0x0/0x20
 [<c021b330>] init_irq+0x270/0x320
 [<c021b6b6>] hwif_init+0x106/0x240
 [<c021af9c>] probe_hwif_init+0x1c/0x70
 [<c022b447>] ide_setup_pci_device+0x57/0x60
 [<c021a003>] via_init_one+0x33/0x40
 [<c0105098>] init+0x38/0x1a0
 [<c0105060>] init+0x0/0x1a0
 [<c01054d9>] kernel_thread_helper+0x5/0xc

and then I inserted the snd-via82xx module :
Debug: sleeping function called from illegal context at mm/slab.c:1374
Call Trace:
 [<c01148f2>] __might_sleep+0x52/0x60
 [<c012f131>] kmalloc+0x61/0x200
 [<db0d5f82>] snd_malloc_pci_pages_R33d26ac2+0x42/0xa0 [snd]
 [<db10f0c0>] build_via_table+0x60/0x180 [snd-via82xx]
 [<db10f57c>] snd_via82xx_setup_periods+0x2c/0x120 [snd-via82xx]
 [<db10f876>] snd_via82xx_playback_prepare+0x76/0x80 [snd-via82xx]
 [<db0fd307>] snd_pcm_prepare+0x127/0x210 [snd-pcm]
 [<db0ff40f>] snd_pcm_playback_ioctl1+0x33f/0x350 [snd-pcm]
 [<c012a75e>] find_get_page+0x1e/0x40
 [<c012b453>] filemap_nopage+0x103/0x280
 [<c0132009>] __alloc_pages+0x79/0x250
 [<c011f85d>] ignored_signal+0x2d/0x40
 [<c011fb81>] specific_send_sig_info+0x101/0x180
 [<db0ff7c7>] snd_pcm_kernel_playback_ioctl_Rb299b4fc+0x27/0x30 [snd-pcm]
 [<db118cc5>] snd_pcm_oss_prepare+0x15/0x40 [snd-pcm-oss]
 [<db118d28>] snd_pcm_oss_make_ready+0x38/0x50 [snd-pcm-oss]
 [<db1190ea>] snd_pcm_oss_write1+0x3a/0x160 [snd-pcm-oss]
 [<db11afc5>] snd_pcm_oss_write+0x35/0x70 [snd-pcm-oss]
 [<c013cec4>] vfs_write+0xb4/0x140
 [<c013cfb8>] sys_write+0x28/0x40
 [<c010716f>] syscall_call+0x7/0xb



Janek Hiis

