Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161101AbWBNP7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161101AbWBNP7q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161102AbWBNP7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:59:46 -0500
Received: from smtp05.web.de ([217.72.192.209]:11473 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S1161101AbWBNP7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:59:45 -0500
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Date: Tue, 14 Feb 2006 16:59:39 +0100
User-Agent: KMail/1.9.1
References: <20060214135016.GC10701@stusta.de>
In-Reply-To: <20060214135016.GC10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602141659.40176.christiand59@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. Februar 2006 14:50 schrieb Adrian Bunk:
> Hi Steve,
>
> I do obvserve the following on my i386 computer:
>
> I'm connecting to a Samba server.
>
> Copying data to the server works without any problems.
>
> When trying to copy some GB from the server, my computer completely
> frezzes after some 100 MB. This is reproducible.
>
> "Complete freeze" is:
> - no reaction to any input, even when I was in the console the magic
>   SysRq key is not working
> - if XMMS was playing, the approx. half a second of the song that was
>   playing at the time when it happened is played in an endless loop by
>   the sound chip
>
> I once switched to the console waiting for the crash, and I saw the
> following messages:
>   CIFS VFS: No response to cmd 46 mid 5907
>   CIFS VFS: Send error in read = -11
>
> There are no other CIFS messages in my logs, and the messages above
> didn't make it into the logs (there's nothing recorded in the logs at
> the time of the crashes).
>
> I tried kernel 2.6.16-rc2 and 2.6.16-rc3.
>
> CIFS options in my kernel:
> CONFIG_CIFS=y
> # CONFIG_CIFS_STATS is not set
> # CONFIG_CIFS_XATTR is not set
> # CONFIG_CIFS_EXPERIMENTAL is not set
>
> I'm mounting with (slightly anonymized):
> mount -t cifs -o user="foo",ip=11.22.33.44 //DAT/bar bar
>
> I'm using the smbfs 3.0.21a-4 package from Debian.
>
> It doesn't occur in 2.6.15.4, because with this kernel (and AFAIR also
> with older kernels) my computer refuses to mount this share.
>
> Mounting the same share with smbfs works without big problems (on some
> rare occassions the connection might become stale and I have to umount
> and remount the share, but this is rare and it never affects the
> stability of my computer).
>
> I'm using an e100 network card with a 10 MBit/s connection.
>
> Any other information I can provide for helping to debug this problem?
>
> TIA
> Adrian

I'm experiencing something like this too. I can confirm it for at least since 
2.6.12. My current System is Ubuntu Dapper Drake. Whenever I copy a 
reasonably large file (> 150 MB) from my box to a WinXp SP2 box my system 
first gets very large latencies going up to 5 seconds. After nearly a minute 
of copying it will freeze completely. No Numlock no SysRq working anymore.
No output in dmesg at all. It just starts getting slower with high latencies 
and will freeze completely if you not kill -9 the cp process. This so far has 
only happened to me on outbound copying. (E.g. cp a local file to remote) 
host. Inbound (WinXP to my Linux box) works flawlessly.


Some more Info:

cp process hangs with status D in wchan SendRe...
kill -9 not working unless you delete the file on the remote site. Then cp 
exits as it should

Mounting a CIFS fs from a WinXP SP2 box
//xxx/DriveD on /mnt/xxx/D type cifs (rw,mand,noexec,nosuid,nodev)

10 Mbit lan
3Com Corporation 3c905B 100BaseTX


System Info:

uname -a
Linux ubuntu 2.6.15-15-686 #1 SMP PREEMPT Thu Feb 9 20:19:53 UTC 2006 i686 
GNU/Linux

lspci -vvv
0000:00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host 
bridge (rev 02)
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort+ >SERR- <PERR-
        Latency: 64
        Region 0: Memory at d0000000 (32-bit, prefetchable) [size=256M]
        Capabilities: <available only to root>

0000:00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP 
bridge (rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
        I/O behind bridge: 0000d000-0000dfff
        Memory behind bridge: fff00000-000fffff
        Prefetchable memory behind bridge: fff00000-000fffff
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B+

0000:00:07.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
        Control: I/O+ Mem+ BusMaster+ SpecCycle+ MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0

0000:00:07.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 01) 
(prog-if 80 [Master])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Region 4: I/O ports at f000 [size=16]

0000:00:07.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev 
01) (prog-if 00 [UHCI])
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64
        Interrupt: pin D routed to IRQ 11
        Region 4: I/O ports at e000 [size=32]

0000:00:07.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin ? routed to IRQ 9

0000:00:11.0 VGA compatible controller: nVidia Corporation NV4 [RIVA TNT] (rev 
04) (prog-if 00 [VGA])
        Subsystem: Diamond Multimedia Systems Viper V550 with TV out
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz+ UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 248 (1250ns min, 250ns max)
        Interrupt: pin A routed to IRQ 10
        Region 0: Memory at e8000000 (32-bit, non-prefetchable) [size=16M]
        Region 1: Memory at e9000000 (32-bit, prefetchable) [size=16M]
        Expansion ROM at ea000000 [disabled] [size=64K]
        Capabilities: <available only to root>

0000:00:12.0 Ethernet controller: 3Com Corporation 3c905B 100BaseTX [Cyclone] 
(rev 30)
        Subsystem: 3Com Corporation 3C905B Fast Etherlink XL 10/100
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- 
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 64 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 12
        Region 0: I/O ports at e400 [size=128]
        Region 1: Memory at ec000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at eb000000 [disabled] [size=128K]
        Capabilities: <available only to root>

0000:00:14.0 Multimedia audio controller: Ensoniq ES1371 [AudioPCI-97] (rev 
06)
        Subsystem: Ensoniq Creative Sound Blaster AudioPCI64V, AudioPCI128
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- 
<TAbort+ <MAbort- >SERR- <PERR-
        Latency: 64 (3000ns min, 32000ns max)
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at e800 [size=64]
        Capabilities: <available only to root>

fgrep -i CIFS /boot/config-2.6.15-15-686
CONFIG_CIFS=m
# CONFIG_CIFS_STATS is not set
# CONFIG_CIFS_XATTR is not set
# CONFIG_CIFS_EXPERIMENTAL is not set

-Christian
