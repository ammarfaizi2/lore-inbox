Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTDOGGW (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 02:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264329AbTDOGGW (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 02:06:22 -0400
Received: from smtp1.clarityconnect.com ([206.64.143.9]:36878 "EHLO
	smtp.clarityconnect.com") by vger.kernel.org with ESMTP
	id S264325AbTDOGGU (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 02:06:20 -0400
Date: Tue, 15 Apr 2003 02:20:48 -0400
To: linux-kernel@vger.kernel.org
Subject: oops in buffer.c (kernel 2.5.67)
Message-ID: <20030415062048.GA708@clarityconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: John Vogel <jvogel@clarityconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know if all this is needed, or if I missed the more important
info:

running Debian Unstable on x86
Intel Pentium 200 mmx
Tyan TomcatIIIs motherboard (430hx chipset)
Award 4.51pg bios (patched to handle up to 64mB ide)
128mB edo ram
Trident Blade3D pci video board
USR Sportster 28.8 isa modem 
USR 56k Performance Pro pci modem
hda: Maxtor 6E040L0, 40gB ATA
hdb: GCR-8521B, 52x Atapi cdrom
hdc: Maxtor 72004, 2gB ATA
hdd: WDC AC31600H, 1.6gB ATA
CMD Technology USB pci card
Creative SB AWE32 isa sound card


**** here's the dump from dmesg:

Linux version 2.5.67 (john@overbyte) (gcc version 2.95.4 20011002 (Debian prerelease)) #1 Mon Apr 14 02:56:40 EDT 2003
.....
(I can supply the rest of the dmesg dump if needed)
.....
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.16, 02 Dec 2001 on ide0(3,3), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
buffer layer error at fs/buffer.c:127
Pass this trace through ksymoops for reporting
Call Trace: [<c013a903>]  [<c013aa12>]  [<c0111d74>]  [<c0111d74>]  [<c013c2d2>]  [<c019021f>]  [<c013cbad>]  [<c01776e4>]  [<c0177a31>]  [<c01776e4>]  [<c01263df>]  [<c0110e2b>]  [<c0111d8a>]  [<c012683f>]  [<c0126f6c>]  [<c013db64>]  [<c013dd37>]  [<c013d579>]  [<c013e569>]  [<c01c0e0f>]  [<c01c03cd>]  [<c01269f5>]  [<c0139ffb>]  [<c01268d8>]  [<c0109e61>]  [<c013a127>]  [<c013a192>]  [<c0108a67>]

**** here's the dump from ksymoops:

ksymoops 2.4.8 on i586 2.5.67.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.5.67/ (default)
     -m /boot/System.map-2.5.67 (default)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Call Trace: [<c013a903>]  [<c013aa12>]  [<c0111d74>]  [<c0111d74>]  [<c013c2d2>]  [<c019021f>]  [<c013cbad>]  [<c01776e4>]  [<c0177a31>]  [<c01776e4>]  [<c01263df>]  [<c0110e2b>]  [<c0111d8a>]  [<c012683f>]  [<c0126f6c>]  [<c013db64>]  [<c013dd37>]  [<c013d579>]  [<c013e569>]  [<c01c0e0f>]  [<c01c03cd>]  [<c01269f5>]  [<c0139ffb>]  [<c01268d8>]  [<c0109e61>]  [<c013a127>]  [<c013a192>]  [<c0108a67>] 
Warning (Oops_read): Code line not seen, dumping what data is available


Trace; c013a903 <__buffer_error+33/38>
Trace; c013aa12 <__wait_on_buffer+6a/ac>
Trace; c0111d74 <autoremove_wake_function+0/38>
Trace; c0111d74 <autoremove_wake_function+0/38>
Trace; c013c2d2 <__block_prepare_write+306/430>
Trace; c019021f <radix_tree_insert+57/ac>
Trace; c013cbad <block_prepare_write+21/38>
Trace; c01776e4 <ext2_get_block+0/2e8>
Trace; c0177a31 <ext2_prepare_write+19/20>
Trace; c01776e4 <ext2_get_block+0/2e8>
Trace; c01263df <generic_file_aio_write_nolock+5f7/9e8>
Trace; c0110e2b <default_wake_function+17/1c>
Trace; c0111d8a <autoremove_wake_function+16/38>
Trace; c012683f <generic_file_write_nolock+6f/8c>
Trace; c0126f6c <mempool_free+50/58>
Trace; c013db64 <bio_destructor+44/4c>
Trace; c013dd37 <bio_put+2b/30>
Trace; c013d579 <end_bio_bh_io_sync+21/30>
Trace; c013e569 <bio_endio+45/4c>
Trace; c01c0e0f <__end_that_request_first+10f/1e4>
Trace; c01c03cd <__blk_put_request+b5/e4>
Trace; c01269f5 <generic_file_writev+31/44>
Trace; c0139ffb <do_readv_writev+197/230>
Trace; c01268d8 <generic_file_write+0/60>
Trace; c0109e61 <handle_IRQ_event+29/4c>
Trace; c013a127 <vfs_writev+4b/50>
Trace; c013a192 <sys_writev+2a/3c>
Trace; c0108a67 <syscall_call+7/b>


1 warning issued.  Results may not be reliable.

********************

I hope I'm not just being a nuisance.

Regards,
John Vogel <jvogel@clarityconnect.com>
