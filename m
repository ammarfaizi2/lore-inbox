Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289357AbSAVTQK>; Tue, 22 Jan 2002 14:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289360AbSAVTQB>; Tue, 22 Jan 2002 14:16:01 -0500
Received: from trantor.cosmic.com ([209.58.189.187]:5901 "EHLO cosmic.com")
	by vger.kernel.org with ESMTP id <S289357AbSAVTP5>;
	Tue, 22 Jan 2002 14:15:57 -0500
From: mirian@cosmic.com (Mirian Crzig Lennox)
X-Newsgroups: cosmic.linux.kernel
Subject: network hangs, NETDEV WATCHDOG messages, Dual AMD Duron, APIC
Date: Tue, 22 Jan 2002 19:16:16 +0000 (UTC)
Organization: The Cosmic Computing Corporation of Alpha Centauri
Message-ID: <slrna4rek0.akh.mirian@trantor.cosmic.com>
X-Complaints-To: news@trantor.cosmic.com
User-Agent: slrn/0.9.6.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen a few other reports of this; let me add mine to the mix in
hopes of working out a solution:

I have a dual processor AMD Duron, using the Tyan Tiger motherboard and
Intel APIC.  On every kernel I've tried, from the 2.4.6 that comes with
Mandrake to 2.4.17 and 2.4.18-pre3 with ac-patches, I get the same
problem:  when transferring files over my local network, the first 5K or
so arrive properly and then my network interface goes completely dead.
This happens predictably and reliably.  The problem does not happen with
bursty net activity (ssh logins) on my local net, or at all with file
transfers across the internet ... just sustained network activity with
other machines on my local net.

One the network device goes dead, it stays dead and the NETDEV WATCHDOG
messages appear in the syslog, periodically, until (a) the net device is
ifconfig'ed down, or (b) the driver module (tulip.o) is unloaded.  After
that, if the module is reloaded or the device ifconfig'ed back up, the
net is fine again, until the next such file transfer.

I've tried most of the advice that others have suggested (moving the
network card to another PCI slot, using the -noapic boot option).  I've
even applied both of the suggested patches for this problem (both of
which appear to attempt to address the problem by edge/level'ing the
relevant IRQ.  I can verify that this code is triggered properly, and
operates on the correct IRQ, but it does not unwedge the network device
(and in fact, the code just keeps getting called over and over again,
along with the NETDEV WATCHDOG messages.

I'm fairly conversant with Linux kernel code, but I don't really
understand the inner magic of APIC.  Can someone help me in getting to
the bottom of this problem?

--Mirian

