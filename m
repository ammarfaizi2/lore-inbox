Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUFDCOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUFDCOo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 22:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265543AbUFDCOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 22:14:44 -0400
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:2261 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S265531AbUFDCOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 22:14:41 -0400
Message-ID: <40BFDB13.7000901@cornell.edu>
Date: Thu, 03 Jun 2004 20:14:43 -0600
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040519)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: xfs corruption or not
X-Enigmail-Version: 0.84.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.5.0.90627, Antispam-Core: 4.0.4.92622, Antispam-Data: 2004.6.3.102573
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel: FC2 2.6.6-1.406

Hi,

I had defective SDRAM which was causing in-memory corruption on xfs and 
freezing my machine (input/output errors)... so I replaced it with 128MB 
of ancient memory that seems to work - passes memtest and no more i/o 
errors. I also did an xfs_repair on the system, which corrected problems..

However, thunderbird still generates the following oops, and then it 
becomes unkillable. Do you think this is most likely due to:
- memory is still defective
- there's corruption on-disk which isn't fixed
or
- this is an actual bug in xfs

Note that there's no input/output errors after the oops, and only 
thunderbird causes this (so far).

Unable to handle kernel paging request at virtual address 00012f00
printing eip:
0a8cc8cb
*pde = 00000000
Oops: 0002 [#1]
Modules linked in: snd_mixer_oss binfmt_misc snd_seq_midi 
snd_seq_midi_event snd_seq snd_via82xx snd_ac97_codec snd_pcm snd_timer 
snd_page_alloc gameport snd_mpu401_uart snd_rawmidi snd_seq_device snd 
soundcore ipv6 parport_pc lp parport iptable_filter ip_tables via_rhine 
mii floppy sg scsi_mod nls_utf8 nls_cp437 vfat fat ext3 jbd dm_mod usblp 
uhci_hcd button battery asus_acpi ac xfs
CPU:    0
EIP:    0060:[<0a8cc8cb>]    Not tainted
EFLAGS: 00010206   (2.6.6-1.406)
EIP is at xfs_bmbt_set_all+0x2f/0x5c [xfs]

eax: 00012f00   ebx: 00000000   ecx: 02daedff   edx: 04b32a6c
esi: 000001ff   edi: 00000000   ebp: 00000000   esp: 04b32888
ds: 007b   es: 007b   ss: 0068
Process thunderbird-bin (pid: 3799, threadinfo=04b32000 task=041aadf0)
Stack: 000012f1 00012f10 00012f0f 0a8c48f7 00000001 000012f0 00000000 
02c86cb0
	00000000 00000010 0a8c1cc7 04b32a6c 00000000 0237730c 0218fcd9 00000000
	00000000 00000000 00000000 03472f00 000012f0 02c86cb0 021f9ec8 000001f6
Call Trace:
[<0a8c48f7>] xfs_bmap_insert_exlist+0x97/0xae [xfs]
[<0a8c1cc7>] xfs_bmap_add_extent_hole_delay+0x42f/0x485 [xfs]
[<0218fcd9>] __delay+0x9/0xa
[<021f9ec8>] dma_timer_expiry+0x0/0x63
[<0a8bf6e8>] xfs_bmap_add_extent+0x13b/0x38e [xfs]
[<0a8c66d9>] xfs_bmapi+0x946/0x104d [xfs]
[<0a8f997b>] xfs_trans_read_buf+0x44/0x2d9 [xfs]
[<0a8cbe79>] xfs_bmbt_get_state+0xa/0x18 [xfs]
[<0a8c4ef4>] xfs_bmap_search_extents+0x3d/0x43 [xfs]
[<0a8c60a7>] xfs_bmapi+0x314/0x104d [xfs]
[<0a8ea9fe>] xfs_iomap_write_delay+0x54a/0x5b6 [xfs]
[<0212c0a1>] mempool_alloc+0x5d/0xf6
[<0a8e9f4c>] xfs_iomap+0x23b/0x3eb [xfs]
[<0a8e9ff4>] xfs_iomap+0x2e3/0x3eb [xfs]
[<0a90910c>] xfs_bmap+0x1a/0x1e [xfs]
[<0a9036f3>] linvfs_get_block_core+0x83/0x234 [xfs]
[<021e25f6>] cfq_next_request+0x21/0x37
[<02140f8b>] __wait_on_buffer+0x7d/0x85
[<0a9038b7>] linvfs_get_block+0x13/0x17 [xfs]
[<021425a7>] __block_prepare_write+0x146/0x3a5
[<02142e47>] block_prepare_write+0x16/0x22
[<0a9038a4>] linvfs_get_block+0x0/0x17 [xfs]
[<0212b79d>] generic_file_aio_write_nolock+0x57e/0x84e
[<0a9038a4>] linvfs_get_block+0x0/0x17 [xfs]
[<0a8e91d1>] xfs_ichgtime+0xee/0xf6 [xfs]
[<0a908e2a>] xfs_write+0x3e5/0x675 [xfs]
[<0a9058cf>] linvfs_write+0xa6/0xbc [xfs]
[<021400cb>] do_sync_write+0x68/0x9d
[<02146f77>] sys_stat64+0x1e/0x23
[<021401b8>] vfs_write+0xb8/0xe4
[<02140252>] sys_write+0x2c/0x42

Code: 89 08 09 fb 31 c9 89 58 04 8b 5a 08 8b 72 0c 8b 52 10 0f a4

