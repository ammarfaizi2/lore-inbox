Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVA2Pw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVA2Pw0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 10:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVA2Pw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 10:52:26 -0500
Received: from chello081018222206.chello.pl ([81.18.222.206]:51979 "EHLO
	plus.ds14.agh.edu.pl") by vger.kernel.org with ESMTP
	id S261309AbVA2PwR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 10:52:17 -0500
From: =?utf-8?q?Pawe=C5=82_Sikora?= <pluto@pld-linux.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: radeonfb - oops
Date: Sat, 29 Jan 2005 16:52:15 +0100
User-Agent: KMail/1.7.91
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501291652.15762.pluto@pld-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get on serial console only this:

# dmesg

radeonfb_pci_register BEGIN
radeonfb: ref_clk=2700, ref_div=60, xclk=15500 from BIOS
radeonfb: probed SDR SGRAM 65536k videoram
radeon_get_moninfo: bios 4 scratch = 2000002
Unable to handle kernel paging request at virtual address 083d5020
 printing eip:
c0215abc
*pgd = 000000000296a001
*pmd = 0000000000000000
Oops: 0000 [#1]
Modules linked in: radeonfb snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_util_mem snd_hwdep radeon button nfs 8139too mii md5 ipv6 
ext2 mbcache nfsd exportfs lockd sunrpc via_agp agpgart loop ide_cd cdrom 
psmouse snd_pcm_oss snd_pcm snd_timer snd_page_alloc snd_mixer_oss snd 
soundcore ide_disk xfs via82cxxx ide_core
CPU:    0
EIP:    0060:[<c0215abc>]    Not tainted VLI
EFLAGS: 00010206   (2.6.10-0.105) 
EIP is at fb_find_mode+0x12c/0x3f0
eax: 083d5036   ebx: 00000000   ecx: 00000006   edx: c012a840
esi: d0a17381   edi: 083d5020   ebp: c3593dd0   esp: c3593d7c
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4594, threadinfo=c3592000 task=c8d8d040)
Stack: 00000082 083d5020 d0a17380 00000000 0000003c ffffffff 00000001 0000003c 
       00000008 000001e0 00000280 00000001 00000001 00000001 00000007 d0a17380 
       c3677000 c3593dfc c3593dfc c3593dfc c3593e9c c3593df4 d0a1506d c012a840 
Call Trace:
 [<c013a20a>] show_stack+0x7a/0x90
 [<c013a38d>] show_registers+0x14d/0x1b0
 [<c013a552>] die+0xc2/0x140
 [<c014afef>] do_page_fault+0x2ff/0x75d
 [<c0139e5b>] error_code+0x2b/0x30
 [<d0a1506d>] radeon_init_disp_var+0x7d/0x80 [radeonfb]
 [<d0a14f84>] radeon_init_disp+0x34/0xa0 [radeonfb]
 [<d0a16a30>] radeon_set_fbinfo+0xd0/0xe0 [radeonfb]
 [<d0a16d1f>] radeonfb_pci_register+0x2df/0x5f0 [radeonfb]
 [<c01ec607>] pci_device_probe_static+0x47/0x60
 [<c01ec651>] __pci_device_probe+0x31/0x50
 [<c01ec696>] pci_device_probe+0x26/0x40
 [<c024438c>] driver_probe_device+0x2c/0x70
 [<c02444b5>] driver_attach+0x55/0x90
 [<c024494b>] bus_add_driver+0x8b/0xb0
 [<c0244eeb>] driver_register+0x2b/0x30
 [<c01ec8af>] pci_register_driver+0x5f/0x80
 [<c0165131>] sys_init_module+0x101/0x180
 [<c0138d19>] sysenter_past_esp+0x52/0x79
Code: 0c 89 7d bc 73 7c c7 45 b8 00 00 00 00 89 f6 8b 45 b8 8b 55 08 8b 04 02 
85 c0 89 45 b0 74 35 8b 75 e8 89 c7 8b 4d e4 49 78 08 ac <ae> 75 08 84 c0 75 
f5 31 c0 eb 04 19 c0 0c 01 85 c0 75 16 b9 ff 

# lspci -v

01:00.0 VGA compatible controller: ATI Technologies Inc Radeon RV100 QY
        [Radeon 7000/VE] (prog-if 00 [VGA])
        Subsystem: Giga-byte Technology RV100 QY
                   [RADEON 7000 PRO MAYA AV Series]
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, IRQ 145
        Memory at d0000000 (32-bit, prefetchable) [size=128M]
        I/O ports at a800 [size=256]
        Memory at dfef0000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at dfec0000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

# sources

linux-2.6.10 + minor radeon fixes from BK:

linux-2.6-radeonfb-fix-rom-enable-disable.patch
linux-2.6-radeonfb-fix-section-usage.patch

Help will be appreciated.

Regards,
Paweł.

-- 
/* Copyright (C) 2003, SCO, Inc. This is valuable Intellectual Property. */

                           #define say(x) lie(x)
