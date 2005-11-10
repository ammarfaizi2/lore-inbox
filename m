Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVKJWSm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVKJWSm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVKJWSm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:18:42 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:13846 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932204AbVKJWSl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:18:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YRoE4J5iAFsgusSP1mS+qsq+/oxA2nc+fx4W66jtyI4IpCxyGv3VBMuzgJ6n1MRjX6pswZmKdnTjr6+sMhc2sQn+0BDGWNFDZ5hD1S6hUxWqhU0I/rLPhW/BlX79i3+LEM71/M5QxEIBk14MMsvpbgYXMaGbSPVTKDOORtwZhbA=
Message-ID: <195c7a900511101418r25aa43e6gc5cdeeac17aa0c7c@mail.gmail.com>
Date: Thu, 10 Nov 2005 22:18:36 +0000
From: roucaries bastien <roucaries.bastien@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Ali snd soft lookup on 2.6.14 (regression)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recently I upgrade from 2.6.10 to 2.6.14 and I my sound card doesn't
work anymore.
dmesg shows:
BUG: soft lockup detected on CPU#0!

Pid: 3798, comm:             modprobe
EIP: 0060:[<dcb09031>] CPU: 0
EIP is at snd_ali_codec_ready+0x31/0x90 [snd_ali5451]
 EFLAGS: 00000212    Not tainted  (2.6.14-1-686)
EAX: 5374807e EBX: 5374807e ECX: 00008800 EDX: 00008840
ESI: fffbeeb4 EDI: dada6000 EBP: 00000040 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f18000 CR3: 1acf4000 CR4: 000006d0
 [<dcb092a8>] snd_ali_codec_peek+0xb8/0xf0 [snd_ali5451]
 [<dcb09353>] snd_ali_codec_read+0x23/0x30 [snd_ali5451]
 [<dcad9235>] snd_ac97_read+0x35/0x50 [snd_ac97_codec]
 [<dcae0c91>] patch_ad1881_chained1+0x71/0x100 [snd_ac97_codec]
 [<dcae0e85>] patch_ad1881_chained+0x165/0x1a0 [snd_ac97_codec]
 [<dcae1057>] patch_ad1881+0x197/0x1e0 [snd_ac97_codec]
 [<dcae13b0>] patch_ad1981b+0x10/0x50 [snd_ac97_codec]
 [<dcadc74e>] snd_ac97_mixer+0x2ee/0xc90 [snd_ac97_codec]
 [<dca069d4>] snd_info_register+0x34/0xa0 [snd]
 [<c01492cf>] kzalloc+0x1f/0x50
 [<dca0968d>] snd_device_new+0x1d/0x70 [snd]
 [<dcadc338>] snd_ac97_bus+0x78/0xb0 [snd_ac97_codec]
 [<dcb0b0cd>] snd_ali_mixer+0xed/0x120 [snd_ali5451]
 [<dcb0afc0>] snd_ali_mixer_free_ac97+0x0/0x20 [snd_ali5451]
 [<dcb0bbdf>] snd_ali_probe+0xcf/0x170 [snd_ali5451]
 [<c01da326>] pci_match_device+0x26/0xc0
 [<c01da436>] __pci_device_probe+0x56/0x70
 [<c01da47f>] pci_device_probe+0x2f/0x50
 [<c0231fa3>] driver_probe_device+0x43/0xd0
 [<c02320b0>] __driver_attach+0x0/0x50
 [<c02320f1>] __driver_attach+0x41/0x50
 [<c02314dd>] bus_for_each_dev+0x5d/0x80
 [<c0232125>] driver_attach+0x25/0x30
 [<c02320b0>] __driver_attach+0x0/0x50
 [<c0231a39>] bus_add_driver+0x89/0xf0
 [<c01da6f2>] pci_register_driver+0x62/0x90
 [<dca8f00f>] alsa_card_ali_init+0xf/0x11 [snd_ali5451]
 [<c01371d1>] sys_init_module+0xc1/0x1a0
 [<c01030b5>] syscall_call+0x7/0xb
lspci -v
0000:00:04.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 02)
        Subsystem: Sony Corporation: Unknown device 8158
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium
>TAbort- <TAbort-<MAbort- >SERR+ <PERR+
        Latency: 64 (500ns min, 6000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 8800 [size=256]
        Region 1: Memory at e0401000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

Regards
Bastien
