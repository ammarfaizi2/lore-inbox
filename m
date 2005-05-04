Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVEDVgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVEDVgv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVEDVgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 17:36:18 -0400
Received: from mailfe08.swip.net ([212.247.154.225]:53149 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S261675AbVEDVfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 17:35:36 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: strange 3c59x behaviour under 2.6.11.7
From: Alexander Nyberg <alexn@dsv.su.se>
To: Jim Faulkner <jfaulkne@ccs.neu.edu>
Cc: vortex@scyld.com, Bogdan.Costescu@iwr.uni-heidelberg.de,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.GSO.4.58.0505041639400.5735@denali.ccs.neu.edu>
References: <Pine.LNX.4.44.0505031057380.9939-100000@kenzo.iwr.uni-heidelberg.de>
	 <Pine.GSO.4.58.0505041639400.5735@denali.ccs.neu.edu>
Content-Type: text/plain
Date: Wed, 04 May 2005 23:35:11 +0200
Message-Id: <1115242511.2562.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some background for the linux-kernel folks:
> 
> http://www.scyld.com/pipermail/vortex/2005-May/002483.html
> 
> http://www.scyld.com/pipermail/vortex/2005-May/002484.html
> 
> On Tue, 3 May 2005, Bogdan Costescu wrote:
> 
> > > Any ideas on what is causing this problem, and how to fix it?
> >
> > Try booting with acpi=off.
> > Try updating BIOS and/or modify power related options in BIOS.
> 
> I've tried disabling ACPI in the kernel, turning on APM support in the
> BIOS, and the combination of the two, and unfortunately the problem
> persisted.
> 
> However, I found this patch (the one at the very bottom of the page):
> http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg78894.html
> 
> And after adapting it to the 2.6.11.7 kernel, everything works again!
> I've rebooted the machine several times, and the 3com cards initialized
> successfully every time.
> 
> I'm CC'ing linux-kernel in the hopes that this fix can make it into the
> mainstream kernel sometime soon.  I'm sure my mother would appreciate it
> greatly. :)
> 
> Please CC my e-mail address in any replies as I am not subscribed to this
> list.

[netdev needs to be up on the CC on this too]

Yeah I get the same behaviour reliably when doing kexec on a box with
the 3c59x, lspci shows:

0000:00:0f.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC Management NIC
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Latency: 32 (2500ns min, 2500ns max), Cache Line Size: 0x08 (32 bytes)
        Interrupt: pin A routed to IRQ 5
        Region 0: I/O ports at b000 [size=128]
        Region 1: Memory at ef004000 (32-bit, non-prefetchable) [size=128]
        Capabilities: [dc] Power Management version 2
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
                Status: D0 PME-Enable- DSel=0 DScale=2 PME-
00: b7 10 00 92 07 00 10 02 74 00 00 02 08 20 00 00
10: 01 b0 00 00 00 40 00 ef 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 b7 10 00 10
30: 00 00 00 00 dc 00 00 00 00 00 00 00 05 01 0a 0a


