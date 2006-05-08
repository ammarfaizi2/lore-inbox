Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932325AbWEHF5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWEHF5c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbWEHF5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:57:32 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:3787 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S932325AbWEHF5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:57:31 -0400
Date: Mon, 8 May 2006 07:57:26 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: sky2 tx hangups
Message-ID: <20060508055726.GI8522@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Stephen Hemminger <shemminger@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Stephen,
I think that I still have sky2 problems. And I am going to switch to a
more reliable eepro100, I think. What I experience is that I can't ping
my default router for about 100 seconds, after that my watchdog reboots
the machine. But the difference to my last report is, that there are no
additional sky2 related printk's that indicate a problem. I raised the
timeout from 100 seconds to 500 and try again. This happens ca. once a day
and since this machine is supposed to be a production system, this is a
bad thing.

        Thomas

--eRtJSFbw+EEWtPj3
Content-Type: message/rfc822
Content-Disposition: inline

Date: Mon, 1 May 2006 23:55:56 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Stephen Hemminger <shemminger@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: sky2 tx hangups
Message-ID: <20060501215556.GH1487@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Stephen Hemminger <shemminger@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11

Hello Stephen and others,
I have a Intel board with a SKY2 network card[1]. The board stopped to receive
packages under havy network load with Linus linux tree (GIT HEAD at this timestamp:
2.6.17-rc2 (root@faui02) #1 SMP Mon Apr 24 22:30:57 CEST 2006) version. The
following was in the syslog:

        Apr 30 00:11:31 localhost kernel: sky2 eth0: tx timeout
        Apr 30 00:11:31 localhost kernel: sky2 eth0: transmit ring 271 .. 248 report=273 done=273
        Apr 30 00:11:31 localhost kernel: sky2 status report lost?
        Apr 30 00:11:41 localhost kernel: sky2 eth0: tx timeout
        Apr 30 00:11:41 localhost kernel: sky2 eth0: transmit ring 273 .. 250 report=273 done=273
        Apr 30 00:11:41 localhost kernel: sky2 hardware hung? flushing
        Apr 30 00:43:41 localhost kernel: sky2 eth0: tx timeout
        Apr 30 00:43:41 localhost kernel: sky2 eth0: transmit ring 250 .. 227 report=273 done=273
        Apr 30 00:43:41 localhost kernel: sky2 status report lost?
        Apr 30 00:45:16 localhost kernel: sky2 eth0: tx timeout
        Apr 30 00:45:16 localhost kernel: sky2 eth0: transmit ring 273 .. 250 report=273 done=273
        Apr 30 00:45:16 localhost kernel: sky2 hardware hung? flushing

Note: There went a few changes from 25th April into the kernel which I missed.
A few look relevant: (git-whatchanged -p drivers/net/sky2.c | less)

        [PATCH] sky2: add fake idle irq timer
        [PATCH] sky2: reschedule if irq still pending

I rebuild a new kernel with the changes in and have that at the moment running
(Linus linux kernel tree GIT HEAD) and stress testing the network card. If the
problem pops up again, I raise my voice.

Thanks for putting that much work in the driver,
                                                Thomas

[1] sky2 networkcard

0000:04:00.0 0200: 11ab:4361 (rev 17)
0000:04:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown device 4361 (rev 17)
        Subsystem: Intel Corp.: Unknown device 3065
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 0, Cache Line Size: 0x10 (64 bytes)
        Interrupt: pin A routed to IRQ 58
        Region 0: Memory at ff720000 (64-bit, non-prefetchable) [size=16K]
        Region 2: I/O ports at 9800 [size=256]
        Expansion ROM at ff700000 [disabled] [size=128K]
        Capabilities: [48] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [50] Vital Product Data
        Capabilities: [5c] Message Signalled Interrupts: 64bit+ Queue=0/1 Enable+
                Address: 00000000fee00000  Data: 403a
        Capabilities: [e0] #10 [0011]

--eRtJSFbw+EEWtPj3--
