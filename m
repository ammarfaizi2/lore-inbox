Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750752AbWJVWPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750752AbWJVWPa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 18:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJVWPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 18:15:30 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:63872 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750752AbWJVWP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 18:15:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hQXc7mBpiLcFGCo0lYbaHy/cjK4zM369QSeAY67oaDzXBRRQ8zt++0gtY+LNI2D7kjiptjyPjpVL1Zl+D9bHH3UX+WDo2WtWQtqty28/gXT3ehuPzzReHaOqERKagktJfv8XpA9h9kfzSLUk0dbbsLc3b8wWoOQBPZoj7gEqCFU=
Message-ID: <4807377b0610221515m42e638c3pfb461fbb7133845e@mail.gmail.com>
Date: Sun, 22 Oct 2006 15:15:27 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Martin J. Bligh" <mbligh@google.com>
Subject: Re: Strange errors from e1000 driver (2.6.18)
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
In-Reply-To: <453BD41B.4010007@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <453BBC9E.4040300@google.com> <453BC0E7.1060308@mbligh.org>
	 <4807377b0610221321i62455faende025f88142dd087@mail.gmail.com>
	 <453BD41B.4010007@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Analysis follows, but I wanted to ask you to bisect back if you can to
find the apparent patch to make the difference.  Basically at this
point I'd say its not likely to be an e1000 issue, but I'd like to
follow up and make sure.

On 10/22/06, Martin J. Bligh <mbligh@google.com> wrote:
> 0000:00:0a.0 Ethernet controller: Intel Corporation 82546EB Gigabit
> Ethernet Con
> troller (Copper) (rev 01)
>          Latency: 32 (63750ns min), Cache Line Size: 0x08 (32 bytes)
>          Interrupt: pin A routed to IRQ 5
>          Region 0: Memory at ef020000 (64-bit, non-prefetchable) [size=128K]
>          Region 4: I/O ports at a000 [size=64]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
>                  Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>          Capabilities: [e4]      Capabilities: [f0] Message Signalled
> Interrupts:
>   64bit+ Queue=0/0 Enable-
>                  Address: 0000000000000000  Data: 0000
>
> 0000:00:0a.1 Ethernet controller: Intel Corporation 82546EB Gigabit
> Ethernet Con
> troller (Copper) (rev 01)
>          Subsystem: Intel Corporation PRO/1000 MT Dual Port Server Adapter
>          Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Step
> ping- SERR- FastB2B-
>          Status: Cap+ 66MHz+ UDF- FastB2B- ParErr- DEVSEL=medium
>  >TAbort- <TAbort
> - <MAbort- >SERR- <PERR-
>          Latency: 32 (63750ns min), Cache Line Size: 0x08 (32 bytes)
>          Interrupt: pin B routed to IRQ 11
>          Region 0: Memory at ef000000 (64-bit, non-prefetchable) [size=128K]
>          Region 4: I/O ports at a400 [size=64]
>          Capabilities: [dc] Power Management version 2
>                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot
> +,D3cold+)
>                  Status: D0 PME-Enable- DSel=0 DScale=1 PME-
>          Capabilities: [e4]      Capabilities: [f0] Message Signalled
> Interrupts:
>   64bit+ Queue=0/0 Enable-
>                  Address: 0000000000000000  Data: 0000

Nothing seems out of order, but the latency may be low, I'd be curious
what these looked like before with the old kernel.  Some of the other
things to compare would have been the lspci -vv output from your
chipset with old/new kernel, in case the bridge/system configuration
changed.  There are no known problems right now with this chipset
82546EB

> > cat /proc/interrupts,
>
>             CPU0
>    5:    1975991          XT-PIC  ehci_hcd:usb2, VIA8237, eth0
> NMI:          0
> LOC:  146264664
> ERR:      52805

shared int, fine, but whats with the ERR: ?

> > dmesg
>
> Did that bit already.

except you didn't include any of the e1000 load information nor the
system's boot information as it came up.

> > ethtool -e eth0,
>
> root@titus:/usr/local/autotest/bin # ethtool -e eth0
> Offset          Values
> ------          ------
> 0x0000          00 07 e9 09 0b 08 30 05 ff ff ff ff ff ff ff ff
> 0x0010          44 a9 03 98 0b 46 11 10 86 80 10 10 86 80 68 34
> 0x0020          0c 00 10 10 00 00 02 21 c8 18 ff ff ff ff ff ff
> 0x0030          ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 0x0040          0c c3 61 78 04 50 02 21 c8 08 ff ff ff ff ff ff
> 0x0050          ff ff ff ff ff ff ff ff ff ff ff ff ff ff 02 06
> 0x0060          2c 00 00 40 07 11 00 00 2c 00 00 40 ff ff ff ff
nothing out of order here that I can see immediately.

> > and maybe output of
> > dmidecode, etc.
>
> Attached.
>
> > only a little.  There are so many different pieces of e1000 hardware
> > and so few specifics in this report that I'll be able to tell you lots
> > more when you get us the info requested.
>
> Thanks. Not sure if the bug wasn't there in earlier kernels, or if we
> just weren't printing anything.

I think it may not have been in earlier kernels, but I also don't
think this is an e1000 problem, at least initially.

<snip>
> BIOS Information
>         Vendor: Phoenix Technologies, LTD
>         Version: 6.00 PG
>         Release Date: 09/13/2004
>         Address: 0xE0000
>         Runtime Size: 128 kB
>         ROM Size: 256 kB
<snip>

> Handle 0x0001, DMI type 1, 25 bytes.
> System Information
>         Manufacturer: VIA Technologies, Inc.
>         Product Name: KT600-8237
>
> Handle 0x0002, DMI type 2, 8 bytes.
> Base Board Information
>         Manufacturer:
>         Product Name: KT600-8237
>         Version:
>         Serial Number:

This chipset is one of the most frequent common elements in problem
reports of TX hangs for e1000.  My current theory (we've bought a
bunch of these systems and never reproduced the issue) is that there
is something either design specific or BIOS specific that causes this
chipset to interact very badly with e1000 hardware.  Some systems have
the issue and some don't.  If you could bisect back to a working point
it would be interesting to see where that pointed.

> Handle 0x0004, DMI type 4, 32 bytes.
> Processor Information
>         Socket Designation: Socket A
>         Type: Central Processor
>         Family: Athlon XP
>         Manufacturer: AMD
>         ID: A0 06 00 00 FF FB 83 03
>         Signature: Family 6, Model A, Stepping 0
>         Version: AMD Athlon(tm) XP
>         Voltage: 1.5 V
>         External Clock: 100 MHz
>         Max Speed: 3000 MHz
>         Current Speed: 1100 MHz

doesn't seem you're overclocked.  Good.
