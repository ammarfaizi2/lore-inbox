Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317183AbSFBN6t>; Sun, 2 Jun 2002 09:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317184AbSFBN6t>; Sun, 2 Jun 2002 09:58:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:27567 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317183AbSFBN6p>;
	Sun, 2 Jun 2002 09:58:45 -0400
Subject: [BUG] 2.4.19-pre9 kernel panic during ppp disconnect/reconnect
	(tulip card, DSL, pppoe)?
From: Mark Halpaap <mark.halpaap@gmx.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Jun 2002 15:58:33 +0200
Message-Id: <1023026319.1602.81.camel@sam>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

beginning with 2.4.19-pre-x my system totally freezes whenever
my DSL provider decides that a disconnect would be a good thing
("LCP terminated by peer"). The pppd then gets the message and
shuts down the current connection, most likely to open a new 
connection soon after (dial on demand).

Around this time the system freezes, either during the final
staging of disconnect or during the early stages of reconnect,
can't tell from the /var/log/messages fragments (see below).

Both the scroll lock and caps lock button start blinking,
i.e. kernel panic, I suppose.

No trace of error messages anywhere (not on console, not in
/var/log/messages).


Any ideas anyone?

Mark.


-- snip -- snip -- snip -- snip -- snip -- snip -- snip --

Some further details:

Working kernels:
2.4.16-pre1
2.4.18-pre9-ac4

Non-working kernels:
2.4.19-pre9
2.4.19-pre7-ac2


#
# Networking options
#
CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETLINK_DEV=y
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=m
CONFIG_NET_IPGRE=m
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y


#
# Network device support
#
CONFIG_NETDEVICES=y


#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_HP100 is not set
# CONFIG_NET_ISA is not set
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
CONFIG_TULIP=y
# CONFIG_TC35815 is not set
# CONFIG_TULIP_MWI is not set
# CONFIG_TULIP_MMIO is not set
# CONFIG_DE4X5 is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_PLIP is not set
CONFIG_PPP=y
# CONFIG_PPP_MULTILINK is not set
# CONFIG_PPP_ASYNC is not set
# CONFIG_PPP_SYNC_TTY is not set
# CONFIG_PPP_DEFLATE is not set
# CONFIG_PPP_BSDCOMP is not set
CONFIG_PPPOE=m
# CONFIG_SLIP is not set




-------------------------------------------
Similar report:
-------------------------------------------
http://www.voy.com/41165/1401.html

-------------------------------------------
Excerpts from /var/log/messages:
-------------------------------------------

# 2.4.19-pre9 hangs:
May 31 18:16:39 localhost pppd[683]: LCP terminated by peer
May 31 18:16:39 localhost pppd[683]: Couldn't increase MTU to 1500.
May 31 18:16:39 localhost pppd[683]: Couldn't increase MRU to 1500
May 31 18:16:40 localhost modify_resolvconf: restored
/etc/resolv.conf.saved.by.pppd.ppp0 to /etc/resolv.conf
May 31 18:16:40 localhost ip-down: [gShield] flushing all rulsets --
firewall disabled
May 31 18:16:41 localhost pppd[683]: Connection terminated.
May 31 18:16:41 localhost pppd[683]: Connect time 1440.2 minutes.
May 31 18:16:41 localhost pppd[683]: Sent 407343 bytes, received 1965296
bytes.
May 31 18:16:41 localhost pppd[683]: Doing disconnect
May 31 22:08:50 localhost syslogd 1.4.1: restart.
May 31 22:08:55 localhost kernel: klogd 1.4.1, log source = /proc/kmsg
started.
May 31 22:08:55 localhost kernel: Inspecting /boot/System.map

# 2.4.19-pre9 hangs:
Jun  1 05:14:33 localhost pppd[738]: LCP terminated by peer
Jun  1 05:14:33 localhost pppd[738]: Couldn't increase MTU to 1500.
Jun  1 05:14:33 localhost pppd[738]: Couldn't increase MRU to 1500
Jun  1 05:14:33 localhost modify_resolvconf: restored
/etc/resolv.conf.saved.by.pppd.ppp0 to /etc/resolv.conf
Jun  1 05:14:33 localhost ip-down: [gShield] flushing all rulsets --
firewall disabled
Jun  1 05:14:35 localhost pppd[738]: Connection terminated.
Jun  1 05:14:35 localhost pppd[738]: Connect time 425.4 minutes.
Jun  1 05:14:35 localhost pppd[738]: Sent 22611 bytes, received 25915
bytes.
Jun  1 05:14:35 localhost pppd[738]: Doing disconnect
Jun  1 05:15:00 localhost /USR/SBIN/CRON[2689]: (root) CMD ( test -x
/usr/bin/ARKPER && /usr/bin/ARKPER 1>/dev/null 2>/dev/null)
Jun  1 10:52:56 localhost syslogd 1.4.1: restart.
Jun  1 10:53:01 localhost kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Jun  1 10:53:01 localhost kernel: Inspecting /boot/System.map

# 2.4.19-pre9 hangs:
Jun  2 12:20:29 localhost pppd[699]: LCP terminated by peer
Jun  2 12:20:29 localhost pppd[699]: Couldn't increase MTU to 1500.
Jun  2 12:20:29 localhost pppd[699]: Couldn't increase MRU to 1500
Jun  2 12:20:29 localhost modify_resolvconf: restored
/etc/resolv.conf.saved.by.pppd.ppp0 to /etc/resolv.conf
Jun  2 12:20:29 localhost ip-down: [gShield] flushing all rulsets --
firewall disabled
Jun  2 12:20:31 localhost pppd[699]: Connection terminated.
Jun  2 12:20:31 localhost pppd[699]: Connect time 1440.2 minutes.
Jun  2 12:20:31 localhost pppd[699]: Sent 4423100 bytes, received
158864391 bytes.
Jun  2 12:20:31 localhost pppd[699]: Doing disconnect
Jun  2 12:29:24 localhost syslogd 1.4.1: restart.
Jun  2 12:29:29 localhost kernel: klogd 1.4.1, log source = /proc/kmsg
started.
Jun  2 12:29:29 localhost kernel: Inspecting /boot/System.map


# 2.4.18-pre9-ac4 DOES NOT hang :
May  7 11:15:45 localhost pppd[740]: LCP terminated by peer
May  7 11:15:45 localhost pppd[740]: Couldn't increase MTU to 1500.
May  7 11:15:45 localhost pppd[740]: Couldn't increase MRU to 1500
May  7 11:15:45 localhost pppd[740]: Modem hangup
May  7 11:15:45 localhost pppd[740]: Connection terminated.
May  7 11:15:45 localhost pppd[740]: Connect time 1440.2 minutes.
May  7 11:15:45 localhost pppd[740]: Sent 3933988946 bytes, received
4231711948 bytes.
May  7 11:15:45 localhost pppd[740]: Doing disconnect
May  7 11:15:45 localhost modify_resolvconf: restored
/etc/resolv.conf.saved.by.pppd.ppp0 to /etc/resolv.conf
May  7 11:15:45 localhost ip-down: [gShield] flushing all rulsets --
firewall disabled
May  7 11:16:15 localhost pppd[740]: Starting link
May  7 11:16:15 localhost pppd[740]: Sending PADI
May  7 11:16:15 localhost pppd[740]: HOST_UNIQ successful match
May  7 11:16:15 localhost pppd[740]: HOST_UNIQ successful match
May  7 11:16:15 localhost pppd[740]: Got connection: f96


-------------------------------------------
lspci -vvv:
-------------------------------------------
00:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate]
System Controller (rev 13)
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort+ >SERR- <PERR-
	Latency: 32
	Region 0: Memory at d0000000 (32-bit, prefetchable) [size=128M]
	Region 1: Memory at de002000 (32-bit, prefetchable) [size=4K]
	Region 2: I/O ports at d000 [disabled] [size=4]
	Capabilities: [a0] AGP version 2.0
		Status: RQ=15 SBA+ 64bit- FW+ Rate=x1,x2
		Command: RQ=0 SBA+ AGP+ 64bit- FW- Rate=x1

00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 [Irongate] AGP
Bridge (prog-if 00 [Normal decode])
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
	Status: Cap- 66Mhz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
	I/O behind bridge: 0000f000-00000fff
	Memory behind bridge: da000000-dcffffff
	Prefetchable memory behind bridge: d8000000-d9ffffff
	BridgeCtl: Parity- SERR+ NoISA+ VGA+ MAbort- >Reset- FastB2B-

00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)
	Subsystem: VIA Technologies, Inc. VT82C686/A PCI to ISA Bridge
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 0
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
(prog-if 8a [Master SecP PriP])
	Subsystem: VIA Technologies, Inc. Bus Master IDE
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 4: I/O ports at d400 [size=16]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 16)
(prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin D routed to IRQ 10
	Region 4: I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:07.4 SMBus: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
40)
	Subsystem: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI]
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Capabilities: [68] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0a.0 SCSI storage controller: LSI Logic Corp. / Symbios Logic Inc.
(formerly NCR) 53c810 (rev 02)
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr+
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 11
	Region 0: I/O ports at e000 [size=256]
	Region 1: Memory at de000000 (32-bit, non-prefetchable) [size=256]

00:0b.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
08)
	Subsystem: Creative Labs CT4832 SBLive! Value
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 5000ns max)
	Interrupt: pin A routed to IRQ 9
	Region 0: I/O ports at e400 [size=32]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0b.1 Input device controller: Creative Labs SB Live! (rev 08)
	Subsystem: Creative Labs Gameport Joystick
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Region 0: I/O ports at e800 [size=8]
	Capabilities: [dc] Power Management version 1
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

00:0c.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
	Subsystem: Netgear FA310TX
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32
	Interrupt: pin A routed to IRQ 10
	Region 0: I/O ports at ec00 [size=256]
	Region 1: Memory at de001000 (32-bit, non-prefetchable) [size=256]
	Expansion ROM at <unassigned> [disabled] [size=256K]

00:0d.0 Multimedia video controller: Brooktree Corporation Bt878 (rev
02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (4000ns min, 10000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at de003000 (32-bit, prefetchable) [size=4K]

00:0d.1 Multimedia controller: Brooktree Corporation Bt878 (rev 02)
	Subsystem: Hauppauge computer works Inc. WinTV/GO
	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 32 (1000ns min, 63750ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: Memory at de004000 (32-bit, prefetchable) [size=4K]

01:05.0 VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP
(rev 82) (prog-if 00 [VGA])
	Subsystem: Matrox Graphics, Inc.: Unknown device 0641
	Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
	Latency: 64 (4000ns min, 8000ns max), cache line size 08
	Interrupt: pin A routed to IRQ 11
	Region 0: Memory at d8000000 (32-bit, prefetchable) [size=32M]
	Region 1: Memory at da000000 (32-bit, non-prefetchable) [size=16K]
	Region 2: Memory at db000000 (32-bit, non-prefetchable) [size=8M]
	Expansion ROM at <unassigned> [disabled] [size=128K]
	Capabilities: [dc] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [f0] AGP version 2.0
		Status: RQ=31 SBA+ 64bit- FW- Rate=x1,x2
		Command: RQ=15 SBA+ AGP+ 64bit- FW- Rate=x1


-------------------------------------------
sam:/var/log # lsmod
-------------------------------------------
Module                  Size  Used by    Not tainted
ide-cd                 27168   0  (autoclean)
cdrom                  28960   0  (autoclean) [ide-cd]
floppy                 45888   0  (autoclean)
snd-pcm-oss            36036   0  (autoclean)
snd-mixer-oss           9152   0  (autoclean)
mga                   103504  22
agpgart                13888   3  (autoclean)
ipt_TOS                 1024  17  (autoclean)
ipt_unclean             6688   1  (autoclean)
ipt_state                608   6  (autoclean)
ipt_REJECT              2816   8  (autoclean)
ipt_LOG                 3136  12  (autoclean)
ipt_limit                960   2  (autoclean)
iptable_mangle          2144   1  (autoclean)
pppoe                   6784   1  (autoclean)
pppox                   1160   1  (autoclean) [pppoe]
af_packet              11592   1  (autoclean)
parport_pc             12164   1  (autoclean)
lp                      6112   0  (autoclean)
parport                14208   1  (autoclean) [parport_pc lp]
snd-seq-midi            3296   0  (autoclean) (unused)
snd-emu10k1-synth       3840   0  (autoclean)
snd-emux-synth         23936   0  (autoclean) [snd-emu10k1-synth]
snd-seq-midi-emul       4560   0  (autoclean) [snd-emux-synth]
snd-seq-virmidi         2680   0  (autoclean) [snd-emux-synth]
snd-seq-oss            23168   0  (autoclean)
snd-seq-midi-event      3112   0  (autoclean) [snd-seq-midi
snd-seq-virmidi snd-seq-oss]
snd-seq                37484   2  (autoclean) [snd-seq-midi
snd-emux-synth snd-seq-midi-emul snd-seq-virmidi snd-seq-oss
snd-seq-midi-event]
snd-emu10k1            56228   0  [snd-emu10k1-synth]
snd-pcm                47936   0  [snd-pcm-oss snd-emu10k1]
snd-timer              10432   0  [snd-seq snd-pcm]
snd-ac97-codec         22852   0  [snd-emu10k1]
snd-rawmidi            12864   0  [snd-seq-midi snd-seq-virmidi
snd-emu10k1]
snd-hwdep               3712   0  [snd-emu10k1]
snd-seq-device          3920   0  [snd-seq-midi snd-emu10k1-synth
snd-emux-synth snd-seq-oss snd-seq snd-emu10k1 snd-rawmidi]
snd-util-mem            1232   0  [snd-emux-synth snd-emu10k1]
snd                    25000   0  [snd-pcm-oss snd-mixer-oss
snd-seq-midi snd-emux-synth snd-seq-virmidi snd-seq-oss
snd-seq-midi-event snd-seq snd-emu10k1 snd-pcm snd-timer snd-ac97-codec
snd-rawmidi snd-hwdep snd-seq-device snd-util-mem]
soundcore               3588  10  [snd]
iptable_nat            13172   0  (autoclean) (unused)
ip_conntrack           13708   2  (autoclean) [ipt_state iptable_nat]
iptable_filter          1760   1  (autoclean)
ip_tables              10624  11  [ipt_TOS ipt_unclean ipt_state
ipt_REJECT ipt_LOG ipt_limit iptable_mangle iptable_nat iptable_filter]
nls_iso8859-1           2880   1  (autoclean)
nls_cp437               4384   1  (autoclean)
vfat                    9532   1  (autoclean)
fat                    29816   0  (autoclean) [vfat]


