Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVEGX4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVEGX4F (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 19:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbVEGX4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 19:56:05 -0400
Received: from smtpout3.uol.com.br ([200.221.4.194]:9696 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S262764AbVEGXzT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 19:55:19 -0400
Date: Sat, 7 May 2005 20:54:54 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org, debian-powerpc@lists.debian.org
Cc: Roman Zippel <zippel@linux-m68k.org>, Brad Boyer <flar@allandria.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, rtbrito@ig.com.br
Subject: Oops and BUG's with hfsplus module
Message-ID: <20050507235454.GA16058@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	debian-powerpc@lists.debian.org,
	Roman Zippel <zippel@linux-m68k.org>,
	Brad Boyer <flar@allandria.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Roman, Brad, Ben and other developers,

I've been having problems when I try to use an hfsplus filesystem with my
system.

The drive is an IDE HD in a firewire enclosure and it seems to work well
for the first few operations. Then, the kernel generates loads of messages,
when I try to do some simple things.

Yesterday, I got a quite scary ooops and, today, after trying a newer
kernel, I got many messages in my dmesg logs.

The Oops that I got yesterday was:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Linux version 2.6.12-rc3-2 (root@dumont) (gcc version 3.3.5 (Debian 1:3.3.5-8)) #1 Fri Apr 22 05:27:45 BRT 2005
(...)
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
scsi2 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: ST316002  Model: 1A                Rev: 3.06
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: [mac] sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi2, channel 0, id 0, lun 0
cdrom: open failed.
cdrom: open failed.
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
scsi2 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda, logical block 40420
Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c012d8cb
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: nls_utf8 hfsplus sd_mod sbp2 scsi_mod ip_nat_ftp ip_conntrack_ftp ipt_MASQUERADE iptable_nat ip_conntrack ip_tables nls_iso8859_1 nls_cp437 vfat fat nls_base deflate zlib_deflate zlib_inflate twofish serpent aes_i586 blowfish des sha256 sha1 md5 crypto_null af_key eth1394 ohci1394 ieee1394 usbhid usblp uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c012d8cb>]    Not tainted VLI
EFLAGS: 00010203   (2.6.12-rc3-2) 
EIP is at mark_page_accessed+0x3/0x2e
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: c6598c00
esi: 00000001   edi: d36ad000   ebp: 00000099   esp: c3f0db4c
ds: 007b   es: 007b   ss: 0068
Process bash (pid: 22564, threadinfo=c3f0c000 task=cfbfb590)
Stack: c6598be0 d933199c c6598be0 00000099 d36ad000 d9331835 c6598be0 00000000 
       d7c2c8fc c588bd9c 00000003 00175a99 c01bf31b d7c3fdc0 c38fa8d0 00000003 
       c588bd9c d7c2c8fc 00000008 c01c20fd d7c2c8fc c9ac753c c013e457 00001000 
Call Trace:
 [<d933199c>] hfsplus_bnode_put+0x31/0x5d [hfsplus]
 [<d9331835>] hfsplus_bnode_find+0x23f/0x250 [hfsplus]
 [<c01bf31b>] __elv_add_request+0x48/0x8c
 [<c01c20fd>] __make_request+0x3a5/0x3e6
 [<c013e457>] __find_get_block+0x8d/0x94
 [<d9332774>] hfsplus_brec_find+0x5a/0xfb [hfsplus]
 [<d932f9e7>] hfsplus_readdir+0x6c/0x33e [hfsplus]
 [<c0129388>] mempool_alloc_slab+0xd/0x10
 [<c0129288>] mempool_alloc+0x63/0x100
 [<c01d6e4a>] ide_map_sg+0x34/0x80
 [<c01dce69>] ide_build_sglist+0x2c/0x7c
 [<c0116bee>] __mod_timer+0x58/0x69
 [<c0185528>] __delay+0xc/0xe
 [<c01d6e4a>] ide_map_sg+0x34/0x80
 [<c01dce69>] ide_build_sglist+0x2c/0x7c
 [<c0116bee>] __mod_timer+0x58/0x69
 [<c010dac6>] recalc_task_prio+0xf9/0x105
 [<c010db1f>] activate_task+0x4d/0x5c
 [<c010db90>] try_to_wake_up+0x41/0x77
 [<c010e353>] __wake_up_common+0x2b/0x4e
 [<c010e38a>] __wake_up+0x14/0x1e
 [<c0192fa8>] n_tty_receive_buf+0x9ed/0xa20
 [<c011b502>] in_group_p+0x33/0x5c
 [<c011b502>] in_group_p+0x33/0x5c
 [<c014676f>] follow_mount+0x4e/0x74
 [<c0147126>] __link_path_walk+0x8bd/0x978
 [<c0185a0c>] copy_to_user+0x32/0x3c
 [<c01438da>] cp_new_stat64+0xeb/0xff
 [<c014a091>] vfs_readdir+0x45/0x6b
 [<c014a2ea>] filldir64+0x0/0xd9
 [<c014a432>] sys_getdents64+0x6f/0xc4
 [<c014a2ea>] filldir64+0x0/0xd9
 [<c010225f>] sysenter_past_esp+0x54/0x75
Code: d0 00 00 00 89 48 04 89 43 18 89 51 04 ff 86 e8 00 00 00 89 8e d0 00 00 00 6a 01 6a 38 e8 18 ce ff ff 58 5a fb 5b 5e c3 53 89 c3 <8b> 00 a8 40 75 19 8b 03 a8 04 74 13 8b 03 a8 20 74 0d 89 d8 e8 
 <3>scsi2 (0:0): rejecting I/O to dead device
Buffer I/O error on device sda, logical block 40420
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

After that, I unplugged the drive from my x86 desktop, connected it to an
iBook that I have here and run the repair tool that comes with MacOS X, but
it told me that the drive was OK and had no problems with its data
structures (i.e., it was clean).

Today, I tried to use it a bit more on my x86 desktop with the kernel being
2.6.12-rc3-mm2-1, but got the following when I tried to use it today:

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
Linux version 2.6.12-rc3-mm2-1 (root@dumont) (gcc version 3.3.5 (Debian 1:3.3.5-12)) #1 Tue May 3 00:55:21 BRT 2005
(...)
ieee1394: Node added: ID:BUS[0-01:1023]  GUID[0050c501e00010e8]
ieee1394: The root node is not cycle master capable; selecting a new root node and resetting...
ieee1394: Node changed: 0-01:1023 -> 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
SCSI subsystem initialized
sbp2: $Rev: 1219 $ Ben Collins <bcollins@debian.org>
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S400] - Max payload [2048]
  Vendor: ST316002  Model: 1A                Rev: 3.06
  Type:   Direct-Access                      ANSI SCSI revision: 06
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
sda: asking for cache data failed
sda: assuming drive cache: write through
 sda: [mac] sda1 sda2 sda3 sda4
Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
BUG: atomic counter underflow at:
 [<d8ae8409>] hfsplus_file_release+0x43/0x90 [hfsplus]
 [<c014005f>] __fput+0x71/0x119
 [<c013ed73>] filp_close+0x59/0x62
 [<c013edc1>] sys_close+0x45/0x50
 [<c0102433>] sysenter_past_esp+0x54/0x75
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

I was getting those messages when I used easytag to change some tags of
some MP3 files that I have on the drive, but only the fact that I stopped
it as soon as I could to avoid getting things worse.

I just recompiled a new 2.6.12-rc4 kernel for my x86 Desktop and I am
willing to test some patches, if desired.


Thanks in advance for any help, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
