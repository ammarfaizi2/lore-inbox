Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTIIOyF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTIIOyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:54:05 -0400
Received: from mail.cs.tu-berlin.de ([130.149.17.13]:1187 "EHLO
	mail.cs.tu-berlin.de") by vger.kernel.org with ESMTP
	id S264170AbTIIOx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:53:58 -0400
Date: Tue, 9 Sep 2003 16:49:06 +0200 (MEST)
From: Peter Daum <gator@cs.tu-berlin.de>
Reply-To: Peter Daum <gator@cs.tu-berlin.de>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Jamie Lokier <jamie@shareable.org>,
       Adrian Bunk <bunk@fs.tum.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.4 patch] fix CONFIG_X86_L1_CACHE_SHIFT
In-Reply-To: <3F5CDC65.6060409@colorfullife.com>
Message-ID: <Pine.LNX.4.30.0309091528380.13877-100000@swamp.bayern.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Sep 2003, Manfred Spraul wrote:

> Context: Peter experiences very bad network performance with 2.4.22 - it
> looks like 99% packet drop or something like that. The packet drop
> disappears if CONFIG_L1_CACHE_SHIFT is set to 7 (i.e. 128 byte cache
> line size). 2.4.21 works.
> The network cards are some kind of atm cards. Several systems are
> affected - at least Pentium II and PPro systems.
>
> Peter: what's the exact brand and nic driver that you use? Could you try
> to figure out what exactly breaks? I'd use "ping -f -s 1500", perhaps
> together with "tcpdump -s 1500 -x" on both ends.

Meanwhile, I could verify that the problems do not occur, when I use
an ethernet network adapter. All the machines have Marconi/Fore Systems
Forerunner LE ATM cards (/proc/pci: ATM network controller: Integrated
Device Tech IDT77211 ATM Adapter (rev 3)) with LAN emulation.

To figure out what exactly breaks, is the hard part: There is no general
malfunction, I only found some particular test cases. The easiest of these
is: "wget ftp://ftp.nai.com/pub/datfiles/english/dat-4291.zip". With a
vanilla 2.4.22 kernel, the data connection dies with a timeout after
transferring some kbytes. When capturing the connection with tcpdump, the
only thing unusual I can discover is that the time interval between 2
data packets coming in is unusually hight. I don't have the slightest
idea, what is really going wrong. Transferring data from some other ftp
server (e.g. ftp.kernel.org) works as usual.

As esoterical as it sounds, the whole issue is 100% reproducible and
disappears with CONFIG_L1_CACHE_SHIFT set to 7. (The example with wget
is only the easiest test I could find - for my purposes, the fact that
sendmail and samba don't work correctly makes the kernel almost useless).
"Ping" doesn't show anything unusual (no dropped packets). Since the
problem did not occur with older kernels, the "CONFIG_L1_CACHE_SHIFT"
setting can hardly be the real problem.

Regards,
               Peter


