Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUA1TNx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 14:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266014AbUA1TNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 14:13:53 -0500
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:33442 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266013AbUA1TNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 14:13:31 -0500
Date: Wed, 28 Jan 2004 16:13:18 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: hmallat@cc.hut.fi, jsimmons@infradead.org, geert@linux-m68k.org
Subject: tdfxfb in linux-2.6 and 1GiB RAM
Message-Id: <20040128161318.5b20d741.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi people,

I can't use frame buffer (tdfxfb) in linux-2.6 with 1GiB of RAM, but yes with 512MiB.
(The linux-2.4 works ok, in both cases.)

HIGHMEM disabled.

The another problem is, when boot in low resolution default 640x480 and switch with
fbset to 1024x768 for example, it changes ok, but can't draw in all screen, only in a
small area of 640x480 located at upper left of screen, the same for all VTs.

If you need more info in logs/proc/sysfs please let me know.

the @dmesg (1GiB) appears:
fb: Can't remap 3Dfx Voodoo5 register area.
tdfxfb: probe of 0000:01:00.0 failed with error -6

and @dmesg (512MiB):
fb: 3Dfx Voodoo5 memory = 32768K

lspci -vv output:
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 4 / Voodoo 5 (rev 01) (prog-if 00 [VGA])
        Subsystem: 3Dfx Interactive, Inc.: Unknown device 0004
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Interrupt: pin A routed to IRQ 11
        Region 0: Memory at d0000000 (32-bit, non-prefetchable) [size=128M]
        Region 1: Memory at e0000000 (32-bit, prefetchable) [size=128M]
        Region 2: I/O ports at c000 [size=256]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [54] AGP version 2.0
                Status: RQ=16 Iso- ArqSz=0 Cal=0 SBA+ ITACoh- GART64- HTrans- 64bit+ FW- AGP3- Rate=x1,x2
                Command: RQ=1 ArqSz=0 Cal=0 SBA- AGP- GART64- 64bit- FW- Rate=<none>
        Capabilities: [60] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


/proc/iomem (1GiB)
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-00366df4 : Kernel code
  00366df5-0043613f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
e8000000-ebffffff : 0000:00:00.0
ec000000-ec0000ff : 0000:00:09.0
  ec000000-ec0000ff : 8139too
ec001000-ec0010ff : 0000:00:10.3
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved

/proc/iomem (512MiB)
00000000-0009ffff : System RAM
000a0000-000bffff : Video RAM area
000c0000-000c7fff : Video ROM
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-003504e0 : Kernel code
  003504e1-0041c13f : Kernel data
1fff0000-1fff2fff : ACPI Non-volatile Storage
1fff3000-1fffffff : ACPI Tables
d0000000-dfffffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
    d0000000-d7ffffff : tdfx regbase
e0000000-e7ffffff : PCI Bus #01
  e0000000-e7ffffff : 0000:01:00.0
    e0000000-e7ffffff : tdfx smem
e8000000-ebffffff : 0000:00:00.0
ec000000-ec0000ff : 0000:00:09.0
  ec000000-ec0000ff : 8139too
ec001000-ec0010ff : 0000:00:10.3
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffff0000-ffffffff : reserved


chau,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
