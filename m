Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbULFV2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbULFV2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 16:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbULFV2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 16:28:35 -0500
Received: from hellmouth6.gatech.edu ([130.207.165.168]:61346 "EHLO
	deliverator6.gatech.edu") by vger.kernel.org with ESMTP
	id S261659AbULFV2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 16:28:17 -0500
To: linux-kernel@vger.kernel.org
Subject: kernel oops output
From: Timmy Douglas <timmy+linux@cc.gatech.edu>
Date: Mon, 06 Dec 2004 16:27:18 -0500
Message-ID: <871xe35d8p.fsf@mail.gatech.edu>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I woke up this morning one of my computers had oops'd so I tried
to gather all the info so I could report it. i'm not on the list so
please cc things to me if you need a reply. the dmesg and lsmod are a
few hours after the reboot.

dmesg:

DMA write timed out
parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio
DMA write timed out
parport0: FIFO is stuck
parport0: BUSY timeout (1) in compat_write_block_pio
DMA write timed out
...




maxold:~# lsmod
Module                  Size  Used by
nfsd                  230656  8 
exportfs                6144  1 nfsd
lockd                  69704  2 nfsd
sunrpc                154948  2 nfsd,lockd
lp                     11080  2 
ipv6                  264096  12 
ext2                   70632  1 
dm_mod                 60284  0 
capability              4392  0 
commoncap               7008  1 capability
xfs                   616216  2 
ymfpci                 51072  0 
ac97_codec             18764  1 ymfpci
soundcore              10176  1 ymfpci
tdfx                   68804  0 
tulip                  47040  0 
crc32                   4192  1 tulip
parport_pc             37188  1 
parport                41704  2 lp,parport_pc
nls_utf8                1920  0 
nls_euc_jp              5348  0 
nls_cp936             126304  0 
nls_cp932              81184  1 
nls_cp950             103840  0 
usbkbd                  7296  0 
usbcore               119396  2 usbkbd
rtc                    12664  0 
ext3                  126184  2 
jbd                    64056  1 ext3
mbcache                 9220  2 ext2,ext3
ide_generic             1280  0 
piix                   13216  1 
hpt366                 22628  1 
ide_disk               20480  10 hpt366
ide_core              143024  4 ide_generic,piix,hpt366,ide_disk
sd_mod                 17904  0 
ata_piix                8996  0 
libata                 45604  1 ata_piix
scsi_mod              125676  2 sd_mod,libata
unix                   28564  20 
fbcon                  40416  0 
font                    8128  1 fbcon
vesafb                  6656  0 
cfbcopyarea             3936  1 vesafb
cfbimgblt               2880  1 vesafb
cfbfillrect             3584  1 vesafb


(debian kernel image)
Linux maxold 2.6.9-1-686 #1 Thu Nov 25 03:48:29 EST 2004 i686 GNU/Linux


(this is all typed manually because the box seemed frozen)

kernel panic - not syncing: Fatal exception in interrupt

call trace:
tcp_retransmit_skb+0x2dc/0x350
tcp_enter_loss+0x67/0x230
tcp_retransmit_timer+0xe7/0x3e0
scheduler_tick+0x1f/0x470
tcp_write_timer+0x0/0x100
tcp_write_timer+0xbd/0x100
run_timer_softirq+0xcb/0x1c0
smp_local_timer_interrupt+0x17/0x70
__do_softirq
do_softirq
do_IRQ
common_interrupt
default_idle+0x0/0x10
default_idle+0x23/0x40
cpu_idle
start_kernel
unknown_bootoption+0x0/0x180

as for the .config file, well it is a stock debian
kernel-image-2.6.9-1-686, so i'm not sure. hope this helps, this is
probably all the useful information i can provide.
