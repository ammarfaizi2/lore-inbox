Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVBDIUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVBDIUs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 03:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVBDIUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 03:20:40 -0500
Received: from mail09.syd.optusnet.com.au ([211.29.132.190]:50855 "EHLO
	mail09.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S263139AbVBDIT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 03:19:59 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.12331.580356.346528@wombat.chubb.wattle.id.au>
Date: Fri, 4 Feb 2005 19:19:55 +1100
To: linux-kernel@vger.kernel.org
Subject: OOPS when using UDF fs
X-Mailer: VM 7.17 under 21.4 (patch 15) "Security Through Obscurity" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I try to write to a UDF fs on a USB-connected Ricoh dvd-burner,
(specificly, create a directory)
I get:

usb-storage: Attempting to get CSW...
usb-storage: usb_stor_bulk_transfer_buf: xfer 13 bytes
usb-storage: Status code 0; transferred 13/13
usb-storage: -- transfer complete
usb-storage: Bulk status result = 0
usb-storage: Bulk Status S 0x53425355 T 0x800000b f R 0 Stat 0x0
usb-storage: -- Result from auto-sense is 0
usb-storage: -- code: 0x70, key: 0x5, ASC: 0x2c, ASCQ: 0x0
usb-storage: (Unknown Key): (unknown ASC/ASCQ)
usb-storage: scsi cmd done, result=0x2
usb-storage: *** thread sleeping.
end_request: I/O error, dev sr0, sector 1096
Unable to handle kernel paging request at virtual address 00002101
 printing eip: 
e1a3562e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT 
Modules linked in: loop udf usb_storage sr_mod orinoco_cs orinoco hermes pcmcia ehci_hcd uhci_hcd yenta_socket
rsrc_nonstatic pcmcia_core snd_intel8x0 snd_ac97_codec snd_pcm_oss
snd_mixer_oss snd_pcm snd_timer
 snd snd_page_alloc i2c_i801
CPU:    0
EIP:    0060:[pg0+558581294/1067963392]   Not tainted VLI
EFLAGS: 00010293   (2.6.11-rc3) 
EIP is at udf_get_filelongad+0x1e/0x50 [udf]
eax: 000021c1   ebx: 00002101   ecx: ce301e30   edx: 000d2d2a
esi: 00002101   edi: 00002101   ebp: ce301e30   esp: ce301d84
ds: 007b   es: 007b   ss: 0068
Process cp (pid: 4869, threadinfo=ce300000 task=cdefda00)
Stack: 00000112 d03e5c6c e1a2dadc 00000001 00000000 00000000 01301d9c ce301d9c 
    c81b4740 ca82714c 00000000 db5f8400 00000000 c0155f3f 00000002 ce301e28 
       d03e5ca4 ce301e40 ce301e30 e1a2d9a6 ce301e34 ce301e3c ce301e40 00000001 
Call Trace:
 [pg0+558549724/1067963392] udf_current_aext+0xcc/0x1b0 [udf]
 [__wait_on_buffer+47/64] __wait_on_buffer+0x2f/0x40
 [pg0+558549414/1067963392] udf_next_aext+0x46/0xb0 [udf]
 [pg0+558577131/1067963392] udf_discard_prealloc+0xcb/0x2b0 [udf]
 [d_rehash+116/144] d_rehash+0x74/0x90
 [pg0+558533743/1067963392] udf_clear_inode+0x2f/0x40 [udf]
 [clear_inode+180/208] clear_inode+0xb4/0xd0
 [pg0+558529176/1067963392] udf_new_block+0xc8/0xda [udf]
 [generic_forget_inode+270/320] generic_forget_inode+0x10e/0x140
 [iput+83/112] iput+0x53/0x70 
 [pg0+558533527/1067963392] udf_new_inode+0x337/0x34a [udf]
 [do_no_page+413/832] do_no_page+0x19d/0x340
 [pg0+558557856/1067963392] udf_mkdir+0x0/0x220 [udf]
 [generic_forget_inode+270/320] generic_forget_inode+0x10e/0x140
 [iput+83/112] iput+0x53/0x70
 [pg0+558533527/1067963392] udf_new_inode+0x337/0x34a [udf]
 [do_no_page+413/832] do_no_page+0x19d/0x340
 [pg0+558557856/1067963392] udf_mkdir+0x0/0x220 [udf]
 [pg0+558557925/1067963392] udf_mkdir+0x45/0x220 [udf]
 [__d_lookup+161/384] __d_lookup+0xa1/0x180
 [dput+30/576] dput+0x1e/0x240 
 [cached_lookup+29/128] cached_lookup+0x1d/0x80
 [pg0+558557856/1067963392] udf_mkdir+0x0/0x220 [udf]
 [vfs_mkdir+95/160] vfs_mkdir+0x5f/0xa0 
 [sys_mkdir+145/224] sys_mkdir+0x91/0xe0
 [syscall_call+7/11] syscall_call+0x7/0xb
Code: e0 74 a3 e1 e8 f4 63 6e de eb ea 89 f6 83 ec 08 85 c0 89 5c 24 04 89 c3 74 33 85 c9 74 2f 8b 01 85 c0 78 21 83 c0
10 39 d0 77 1a <8b> 13 85 d2 74 14 8b 54 24 0c 85 d2 74 02 89 01 89 d8 8b 5c 24

