Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267019AbSKSRB7>; Tue, 19 Nov 2002 12:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267010AbSKSRB7>; Tue, 19 Nov 2002 12:01:59 -0500
Received: from paiol.terra.com.br ([200.176.3.18]:46490 "EHLO
	paiol.terra.com.br") by vger.kernel.org with ESMTP
	id <S267019AbSKSRAb>; Tue, 19 Nov 2002 12:00:31 -0500
Date: Tue, 19 Nov 2002 15:07:30 -0200
From: Lucio Maciel <abslucio@terra.com.br>
To: LKML <linux-kernel@vger.kernel.org>
Cc: delphus@delphus.org
Subject: SCSI problem
Message-Id: <20021119150730.05380a0b.abslucio@terra.com.br>
Organization: absoluta
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello...

Here goes some SCSI problens report by a friend...

Please CC to delphus@delphus.org any reply

my drive: Sony SDT-9000(PB)
my tape: DDS3 sony 125P 12.0GB
my distro: slackware 8.1
my kernel: 2.4.19
my scsi0 device:<Adaptec 2940 Ultra SCSI adapter>
my mt-st version: 0.7
my GNU mt version: 2.4.2.91

add info. from lspci -vv
02:0a.0 SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC-7881U (rev 01)
        Subsystem: Adaptec AHA-2940UW SCSI Host Adapter
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min, 2000ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at d800 [disabled] [size=256]
        Region 1: Memory at f3800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [dc] Power Management version 1
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-


dmesg info.

scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.8
        <Adaptec 2940 Ultra SCSI adapter>
        aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

  Vendor: SONY      Model: SDT-9000          Rev: 0600
  Type:   Sequential-Access                  ANSI SCSI revision: 02
st: Version 20020205, bufsize 32768, wrt 30720, max init. bufs 4, s/g segs 16
Attached scsi tape st0 at scsi0, channel 0, id 0, lun 0
st: Allocated tape buffer 0 (32768 bytes, 1 segments, dma: 1, a: c0090000).
st: segment sizes: first 32768, last 32768 bytes.


my ps -lax
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY        TIME COMMAND
000     0   506   162   9   0  1276  268 st_do_ D    vc/2       0:00 mt -f /dev/st0 erase

debug information with #define DEBUG 1

st0: Block limits 1 - 16777215 bytes.
st0: Mode sense. Length 11, medium 0, WBS 10, BLL 8
st0: Density 25, tape length: 0, drv buffer: 1
st0: Block size: 0, buffer size: 32768 (1 blocks).
st0: Erasing tape.
st0: Device already in use.
st0: Error: 8000002, cmd: 19 1 0 0 0 0 Len: 0
Current st09:00: sense key Medium Error
Additional sense indicates Write error
st0: Rewinding tape.
st0: Block limits 1 - 16777215 bytes.
st0: Mode sense. Length 11, medium 0, WBS 10, BLL 8
st0: Density 25, tape length: 0, drv buffer: 1
st0: Block size: 0, buffer size: 32768 (1 blocks).
st0: Erasing tape.


Nov 19 23:38:18 magali kernel: st0: Mode sense. Length 11, medium 0, WBS 10, BLL 8
Nov 19 23:38:18 magali kernel: st0: Density 25, tape length: 0, drv buffer: 1
Nov 19 23:38:18 magali kernel: st0: Block size: 0, buffer size: 32768 (1 blocks).
Nov 19 23:38:18 magali kernel: st0: Erasing tape.
Nov 19 23:40:48 magali kernel: st0: Device already in use.
Nov 19 23:42:19 magali gnome-name-server[257]: starting
Nov 19 23:42:19 magali gnome-name-server[257]: name server starting
Nov 19 23:56:40 magali -- MARK --
Nov 19 23:57:28 magali gpm[106]: imps2: Auto-detected intellimouse PS/2
Nov 19 23:58:30 magali gpm[106]: imps2: Auto-detected intellimouse PS/2
Nov 20 00:10:41 magali gpm[106]: imps2: Auto-detected intellimouse PS/2
Nov 20 00:13:41 magali gpm[106]: imps2: Auto-detected intellimouse PS/2
Nov 20 01:16:22 magali -- MARK --
Nov 20 01:29:26 magali gpm[106]: imps2: Auto-detected intellimouse PS/2
Nov 20 01:31:43 magali kernel: st0: Error: 8000002, cmd: 19 1 0 0 0 0 Len: 0
Nov 20 01:31:43 magali kernel: st0: Rewinding tape.
Nov 20 01:34:41 magali kernel: st0: Mode sense. Length 11, medium 0, WBS 10, BLL 8
Nov 20 01:34:41 magali kernel: st0: Density 25, tape length: 0, drv buffer: 1
Nov 20 01:34:41 magali kernel: st0: Block size: 0, buffer size: 32768 (1 blocks).
Nov 20 01:34:41 magali kernel: st0: Erasing tape.
Nov 20 01:56:22 magali -- MARK --
Nov 20 02:09:05 magali gpm[106]: imps2: Auto-detected intellimouse PS/2
Nov 20 02:36:22 magali -- MARK --
Nov 20 02:56:22 magali -- MARK --
Nov 20 03:16:22 magali -- MARK --
Nov 20 03:36:22 magali -- MARK --
Nov 20 03:56:22 magali -- MARK --
Nov 20 04:16:22 magali -- MARK --
Nov 20 04:36:22 magali -- MARK --
Nov 20 04:56:22 magali -- MARK --
Nov 20 05:16:22 magali -- MARK --

... and still erasing tape...

(I didn't cut any line from my messages just for you to see that it was not modified)

 So what is going on, or wrong. Simple all mt commands works just fine, but erase. The 
command erase hangs the driver and mt command for all the long timeout setting, after
that right time, backs an error above. I don't know what to do anymore. But I cannot 
figure out why it worked just fine when my system was runnind a slackware 8.0 with 0.6
mt version and kernel 2.4.5. That system was working just pretty fine. I got to upgrade
to slackware 8.1 with some new versions. I've tried to back mt version to 0.6, no progress.
I've not tried to back to kernel 2.4.5, but if this will be my only chance to get this 
working fine again... Please help me, I'm stucked.


PS.: CC to delphus@delphus.org any reply, he is the "owner" of this problem..  heh 

best regards
-- 
::: Lucio F. Maciel
::: abslucio@terra.com.br
::: icq 93065464
::: Absoluta.net
