Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTBTTKx>; Thu, 20 Feb 2003 14:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266948AbTBTTKx>; Thu, 20 Feb 2003 14:10:53 -0500
Received: from 251.017.dsl.syd.iprimus.net.au ([210.50.55.251]:58247 "EHLO
	file1.syd.nuix.com.au") by vger.kernel.org with ESMTP
	id <S266940AbTBTTKq> convert rfc822-to-8bit; Thu, 20 Feb 2003 14:10:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: Song Zhao <song.zhao@nuix.com.au>
Reply-To: song.zhao@nuix.com.au
Organization: Nuix
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Date: Fri, 21 Feb 2003 06:20:21 -0500
User-Agent: KMail/1.4.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302210620.21799.song.zhao@nuix.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: Manish Lachwani <manish@Zambeel.com>

On Thu, 20 Feb 2003 12:54 pm, you wrote:
> WHat kind of benchmarks are you running? I had evaluated a Supermicro board
> with e7500 chipset and it showed good performance. Are you benchmarking
> network, memory, disk? Note that 3ware controllers operate at 33 MHZ PCI
> and if the nics share the same PCI bus with 3ware, they too will operate at
> 33 MHZ PCI and not 133 MHZ. Have you disabled hyperthreading in the BIOS?

I did some disk I/O and CPU benchmarks, including bonnie++, hdparm, nbench,
unixbench, dbench, tiotest. I haven't done any network/memory testing yet,
the onboard Broadcom and Intel gigabit controllers both seem to work quite
well. I have taken care to make sure that the 3ware card has its own PCI bus,
in this case slot 5. I have not disabled hyperthreading but I am not sure why
I would.

On that note, I have also done benchmarking with a Supermicro E7500 board
(P4DPR, Intel Gigabit 82544GC onboard controller), the tests I ran included
Netperf, Netperf3, NetPIPE (TCP), Tbench, nttcp, Aim9 and the ones I
mentioned above. It seemed that if I had two identical machines hooked up
directly (back to back with CAT5E crossover cable), the performance would be
a lot better and is very consistent. I tried different combinations
HT=on/off, CPU affinity, IRQ affinity, SMP/UP. Some results were:

Supermicro
=========
Netperf Result (MB/s) - 112.21
Netperf3 Result (MB/s) - 112.22
Tbench Result (MB/s) - 114.48
Nttcp Result (Mb/s) - 946.55

However, if I hook it up to a different machine, problems started to occur.
For example, with the Tyan S2720 Thunder i7500  board (E7500 chipset, Intel
82544EI onboard gigabit controller), I see good performance on the Tyan but
not Supermicro.

Supermicro
=========
Netperf Result (MB/s) - 29.23
Netperf3 Result (MB/s) - 78.19
Tbench Result (MB/s) - 117.32
Nttcp Result (Mb/s) - 646.77

Tyan
====
Netperf Result (MB/s) - 112.22
Netperf3 Result (MB/s) - 112.02
Tbench Result (MB/s) - can't find it
Nttcp Result (Mb/s) - 945.9

-------------------------------------------------------

