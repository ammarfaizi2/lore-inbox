Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbTFGPdi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 11:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTFGPdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 11:33:37 -0400
Received: from camus.xss.co.at ([194.152.162.19]:11280 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S263202AbTFGPdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 11:33:31 -0400
Message-ID: <3EE208F1.4000008@xss.co.at>
Date: Sat, 07 Jun 2003 17:46:57 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Haumer <andreas@xss.co.at>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
References: <Pine.LNX.4.55L.0306031353580.3892@freak.distro.conectiva> <3EDF3310.7040501@xss.co.at>
In-Reply-To: <3EDF3310.7040501@xss.co.at>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!

Andreas Haumer wrote:
> Hi!
>
> Marcelo Tosatti wrote:
>
>>Hallo,
>>
>>Now I really hope its the last one, all this rc's are making me mad.
>>
>
> ;-)
>
> So, here's a report on the more positive side...
>
I think, I have to take that back... :-((

> As I mentioned in some e-mails in the last few days,
> I'm currently testing an Asus AP1700-S5 server with
> a single Xeon 2.4GHz CPU (FSB533), 512MB RAM and
> 4x36GB U320SCSI drives (3 of them are assembled as RAID5),
> connected via GBit Ethernet to our internal network
>
I had this system running under heavy load for about 24 hours
without problems. I then stopped the stress testing, and had
several system freezes since then.

With system freeze I mean:

*) machine doesn't answer to ping, no reaction to console
   keyboard, no message on the console screen, no message
   in logfile, no oops, no noticeable system activity

I changed several BIOS settings (disabled hyperthreading,
disabled USB, disabled power management) and tried to run
the kernel with "acpi=off" and "noapic".
I also changed root disk, because I found a SCSI error
message in the logs once.

Nothing seems to help. The system just freezes under light
load at some time between 1 and 8 hours uptime.
It's really strange that it survived heavy load for
more than 24 hours in the first place.

I found some problem reports from several people,
which sound quite similar to the freeze I see here.
These people all had motherboards with serverworks
chipset, GBit ethernet and noticed similar lockups
or system freeze symptoms. From the reports I'm not
sure if the problems still persist or if they should
be solved now. Can someone please comment on that?

Here are some infos from the system again:

root@server:~ {505} $ cat /proc/interrupts
           CPU0
  0:     118748    IO-APIC-edge  timer
  1:        274    IO-APIC-edge  keyboard
  2:          0          XT-PIC  cascade
  4:       7011    IO-APIC-edge  serial
  9:    1181037   IO-APIC-level  ioc0, ioc1
 14:       1685   IO-APIC-level  eth0
 15:          2    IO-APIC-edge  ide1
NMI:          0
LOC:     118700
ERR:          0
MIS:          0

root@server:~ {506} $ cat /proc/cmdline
auto BOOT_IMAGE=lx2421rc7 ro root=100 acpi=off

root@server:~ {507} $ uname -a
Linux server 2.4.21-rc7 #1 SMP Wed Jun 4 18:31:15 CEST 2003 i686 unknown

root@server:~ {508} $ lsmod
Module                  Size  Used by    Not tainted
af_packet              13256   1  (autoclean)
e1000                  50028   1  (autoclean)
ext3                   60832   2  (autoclean)
jbd                    40056   2  (autoclean) [ext3]
raid5                  17704   1  (autoclean)
md                     57472   2  (autoclean) [raid5]
xor                     8868   0  (autoclean) [raid5]
unix                   15664  38  (autoclean)
ext2                   33440   4  (autoclean)
sd_mod                 10652  18  (autoclean)
isense                 32404   0  (autoclean) (unused)
mptctl                 19116   0  (autoclean) (unused)
mptscsih               29696   9  (autoclean)
mptbase                32640   5  (autoclean) [isense mptctl mptscsih]
scsi_mod               95748   2  (autoclean) [sd_mod mptscsih]

root@server:~ {511} $ lspci -vvvv
00:00.0 Host bridge: ServerWorks CNB20-HE Host Bridge (rev 31)
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.1 Host bridge: ServerWorks CNB20-HE Host Bridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:00.2 Host bridge: ServerWorks CNB20-HE Host Bridge
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-

00:02.0 Ethernet controller: Intel Corp. 82540EM Gigabit Ethernet Controller (rev 02)
        Subsystem: Intel Corp. 82540EM Gigabit Ethernet Controller
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 14
        Region 0: Memory at fd800000 (32-bit, non-prefetchable) [size=128K]
        Region 2: I/O ports at d800 [size=64]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27) (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc: Unknown device 8008
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
        Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2000ns min), cache line size 08
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at fc000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: I/O ports at d400 [size=256]
        Region 2: Memory at fb800000 (32-bit, non-prefetchable) [size=4K]
        Expansion ROM at febe0000 [disabled] [size=128K]
        Capabilities: [5c] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0f.0 ISA bridge: ServerWorks CSB5 South Bridge (rev 93)
        Subsystem: ServerWorks CSB5 South Bridge
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Latency: 32

00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93) (prog-if 88 [Master SecP])
        Subsystem: ServerWorks CSB5 IDE Controller
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32, cache line size 08
        Region 0: I/O ports at <ignored>
        Region 1: I/O ports at <ignored>
        Region 2: I/O ports at <ignored>
        Region 3: I/O ports at <ignored>
        Region 4: I/O ports at a800 [size=16]

00:0f.3 Host bridge: ServerWorks GCLE Host Bridge
        Subsystem: ServerWorks: Unknown device 0230
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

00:10.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr+ DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:10.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:11.0 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr+ DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
00:11.2 Host bridge: ServerWorks: Unknown device 0101 (rev 03)
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr+ DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
        Capabilities: [60]
02:04.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 4500ns max), cache line size 08
        Interrupt: pin A routed to IRQ 9
        Region 0: I/O ports at a000 [size=256]
        Region 1: Memory at fa000000 (64-bit, non-prefetchable) [size=64K]
        Region 3: Memory at f9800000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe900000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68]
02:04.1 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 (rev 07)
        Subsystem: LSI Logic / Symbios Logic: Unknown device 1000
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 72 (4250ns min, 4500ns max), cache line size 08
        Interrupt: pin B routed to IRQ 9
        Region 0: I/O ports at 9800 [size=256]
        Region 1: Memory at f9000000 (64-bit, non-prefetchable) [size=64K]
        Region 3: Memory at f8800000 (64-bit, non-prefetchable) [size=64K]
        Expansion ROM at fe800000 [disabled] [size=1M]
        Capabilities: [50] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000
        Capabilities: [68]
03:02.0 Ethernet controller: Intel Corp. 82544GC Gigabit Ethernet Controller (LOM) (rev 02)
        Subsystem: Intel Corp.: Unknown device 110d
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV+ VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (63750ns min), cache line size 08
        Interrupt: pin A routed to IRQ 5
        Region 0: Memory at f8000000 (64-bit, non-prefetchable) [size=128K]
        Region 2: Memory at f7800000 (64-bit, non-prefetchable) [size=128K]
        Region 4: I/O ports at 9400 [size=32]
        Expansion ROM at fe7e0000 [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [e4] PCI-X non-bridge device.
                Command: DPERE- ERO+ RBC=0 OST=0
                Status: Bus=0 Dev=0 Func=0 64bit- 133MHz- SCD- USC-, DC=simple, DMMRBC=0, DMOST=0, DMCRS=0, RSCEM-      Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-
                Address: 0000000000000000  Data: 0000

Any idea how I should proceed now?
I really could use some help here, I'm running out
of ideas... :-((

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+4gjsxJmyeGcXPhERAsT4AJ9sylkxso5kXO51+6c5bfskVV2meACgrF33
t8xXYpu6FGPsiQ9VBmnk6ek=
=Yov+
-----END PGP SIGNATURE-----

