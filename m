Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266157AbUGOJRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266157AbUGOJRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 05:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266161AbUGOJRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 05:17:16 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:24458 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S266157AbUGOJRA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 05:17:00 -0400
Date: Thu, 15 Jul 2004 10:16:56 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: lvm2, snapshot, lvremove, BUG at drivers/md/kcopyd.c
Message-ID: <Pine.LNX.4.60.0407151005390.2622@fogarty.jakma.org>
X-NSA: arafat al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

AMD K6-II running 2.6.7-1.448.root (recompiled version of Arjan van 
de Veen's 2.6.7-1.448 RPM kernel for Fedora, (siimage compiled as 
module rather than built in)). A snapshot had been created (call it 
snapshot 1) several days previously of the lv hosting /home. The 
snapshot was approx 50% full. A new snapshot was made of /home 
(snapshot #2). The old snapshot, #1, was removed. The following was 
logged:

kernel BUG at drivers/md/kcopyd.c:148!
invalid operand: 0000 [#1]
Modules linked in: dm_snapshot sch_ingress cls_u32 sch_sfq sch_htb w83781d i2c_sensor i2c_isa i2c_core ppp_deflate zlib_deflate nfsd exportfs lockd parport_pc lp parport sunrpc n_hdlc ppp_synctty ppp_async ppp_generic slhc 3c59x ip_conntrack_ftp ip_nat_irc ip_conntrack_irc ipt_REJECT ipt_LOG ipt_limit ipt_state iptable_filter ipt_TOS iptable_mangle ipt_REDIRECT ipt_MASQUERADE iptable_nat ip_conntrack ip_tables ip6t_LOG ip6t_limit ip6table_filter ip6table_mangle ip6_tables ipv6 floppy sg usblp uhci_hcd ext3 jbd raid5 xor raid1 dm_mod ide_disk via82cxxx ide_core DAC960 sata_sil libata sd_mod scsi_mod
CPU:    0
EIP:    0060:[<d087937a>]    Not tainted
EFLAGS: 00010283   (2.6.7-1.448.root) 
EIP is at client_free_pages+0xb/0x32 [dm_mod]
eax: 00000100   ebx: c450b328   ecx: 00000000   edx: 0000006a
esi: d0b91080   edi: 00000000   ebp: 00000000   esp: ccd4df38
ds: 007b   es: 007b   ss: 0068
Process lvremove (pid: 28873, threadinfo=ccd4d000 task=cfcd9910)
Stack: c450b328 d0879c76 c9da04d8 d0b36743 d0b91080 cb4aca38 d0875612 c6fa61a8
        d0b1b000 09304758 ccd4d000 d0876fe5 d087dda0 d08776c9 00000004 00000000
        d08785bc d0b1b000 d0877656 d0b1b000 d087de40 09304758 c134fd04 c9c87ec0 
Call Trace:
  [<d0879c76>] kcopyd_client_destroy+0x12/0x26 [dm_mod]
  [<d0b36743>] snapshot_dtr+0x4c/0x55 [dm_snapshot]
  [<d0875612>] table_destroy+0x39/0x83 [dm_mod]
  [<d0876fe5>] __hash_remove+0x3e/0x52 [dm_mod]
  [<d08776c9>] dev_remove+0x73/0x8f [dm_mod]
  [<d08785bc>] ctl_ioctl+0xd2/0x13d [dm_mod]
  [<d0877656>] dev_remove+0x0/0x8f [dm_mod]
  [<c015095e>] sys_ioctl+0x207/0x23d
  [<c0266587>] syscall_call+0x7/0xb
Code: 0f 0b 94 00 4d a8 87 d0 8b 43 08 e8 8a ff ff ff c7 43 10 00

lvremove hung for ever, as did all IO after that to the /home lv.

On reboot, the system boot hung while enabling LVM (vgchange -ay 
probably). The lvm.conf had to be edited, snapshots deleted and this 
modified configuration lvm vgcfgrestore'd in order to fix this.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
 	warning: do not ever send email to spam@dishone.st
Fortune:
New York... when civilization falls apart, remember, we were way ahead of you.
- David Letterman
