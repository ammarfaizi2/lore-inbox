Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129525AbQLMD3I>; Tue, 12 Dec 2000 22:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129602AbQLMD26>; Tue, 12 Dec 2000 22:28:58 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:59268 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S129525AbQLMD2u>; Tue, 12 Dec 2000 22:28:50 -0500
Date: Wed, 13 Dec 2000 03:02:06 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: via82cxxx_audio - bad latency 
Message-ID: <Pine.LNX.4.30.0012130244140.1326-100000@fogarty.jakma.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i think somethings gone wrong with via82cxxx_audio. Playing anything
through it seems to cause massive latency in apps like xmms, esd,
asmixer, etc.. anything to do with playing or mixer levels suddenly
takes a minute or more to respond.

It didn't always do this, and when it started happening i assumed it
was either something bad in esd or xmms (which i tend to upgrade a
lot). However it still happens when esd is disabled. eg, i use mpg123
to play an mp3 file, and asmixer doesn't change the volume till a
minute or two after i moused it.

if i SIGSTOP mpg123, asmixer immediately becomes responsive again and
implements the pending volume change, as soon i SIGCONT mpg123,
asmixer becomes very unresponsive again.

same thing with esd, if i STOP mpg123, other apps like esd and
non-esd mixers become responsive, soon as i start playing again they
go unresponsive.

same thing with playing from esd applications, everything inlcuding
the playing app itself (eg xmms) is unresponsive, if i STOP it, the
mixers instantly become responsive, soon as i CONT the playing app
everything is "dead" again.

kernel is test12-final. AMD K7, Asus K7M board

[root@fogarty /root]# lspci -vv -s 00:04.5
00:04.5 Multimedia audio controller: VIA Technologies, Inc. VT82C686
[Apollo Super AC97/Audio] (rev 21)
	Subsystem: Asustek Computer, Inc.: Unknown device 800d
	Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium
>TAbort- <TAbort- <MAbort- >SERR- <PERR-
	Interrupt: pin C routed to IRQ 10
	Region 0: I/O ports at d400 [size=256]
	Region 1: I/O ports at d000 [size=4]
	Region 2: I/O ports at cc00 [size=4]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-

[root@fogarty /root]# cat /proc/interrupts
           CPU0
  0:    1064556          XT-PIC  timer
  1:      18405          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  3:     904332          XT-PIC  eth0
  8:          1          XT-PIC  rtc
 10:      75896          XT-PIC  BusLogic BT-958, via82cxxx
 12:     278174          XT-PIC  PS/2 Mouse
 14:       3258          XT-PIC  ide0
 15:     387918          XT-PIC  ide1
NMI:          0
ERR:          0

the via is sharing an interrupt, though normally the buslogic is not
being used. (the interrupt sharing has been there a lot longer than
this problem)

i don't have the /proc/driver/via.... files that the docs mention.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org
PGP5 key: http://www.clubi.ie/jakma/publickey.txt
-------------------------------------------
Fortune:
And they shall beat their swords into plowshares, for if you hit a man
with a plowshare, he's going to know he's been hit.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
