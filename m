Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVBTJWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVBTJWR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 04:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbVBTJWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 04:22:17 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:34961 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S261732AbVBTJWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 04:22:10 -0500
Date: Sun, 20 Feb 2005 10:22:09 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Subject: Re: IBM Thinkpad G41 PCMCIA problems
Message-ID: <20050220092208.GA12738@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt wrote:
> I have a IBM Thinkpad G41 with a pentium4M with Hyperthreading.  I can't
> get the PCMCIA working at all.  I've tried turning off hyperthreading,
> I've tried with and without preempt, I've even added pci=noacpi. I've
> added Len's ACPI patches, but nothing works.


I see the same problem with an IBM Thinkpad G40, and only when there is 
1Gb of memory or more in the machine.

The problem was reported the first time (to my knowledge), here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0306.3/0956.html
by a Thinkpad T40 user.

So the problem seems to affect at least three different Thinkpad models.

The workaround I've seen so far have either been to disable 
pci_fixup_transparent_bridge (as mentioned in this thread) or to raise 
the value of pci_mem_start.

Re,
David

lspci -vvv with pci_fixup_transparent bridge disabled:
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 81) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR+
        Latency: 0
        Bus: primary=00, secondary=02, subordinate=05, sec-latency=64
        I/O behind bridge: 00003000-00006fff
        Memory behind bridge: d0200000-dfffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff
        BridgeCtl: Parity- SERR- NoISA+ VGA- MAbort- >Reset- FastB2B-

