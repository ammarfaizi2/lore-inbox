Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVLIVoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVLIVoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVLIVoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:44:34 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:42245 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932354AbVLIVoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:44:34 -0500
Date: Fri, 9 Dec 2005 22:44:17 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Brent <brent@skyblue.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: High load since upgrade
Message-ID: <20051209214417.GE15993@alpha.home.local>
References: <000001c5fcb7$c006e820$030c0b0a@mforma.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c5fcb7$c006e820$030c0b0a@mforma.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2005 at 11:57:37AM -0000, Brent wrote:
> Hi
> Hope this is the right list I'm posting to but here goes.
> 
> I recently upgraded 3 servers to the stock 2.6.14.3 kernels from an older
> 2.4.28 kernel, all identical running debian stable and all up to date with
> no outstandng updates needed to the OS.
> As from these 3 graphs (all servers almost identical hardware), PIII 900, 1G
> RAM, you can quite clearly see when the upgrades where made and sending the
> load avg up way above the previous averages.
> http://pics.skyblue.eu.org/graphs/

you graphs show a permanent load of 1 + something low. In the past, there
have been some bugs in modules which made them increase the apparent load
average by 1. I suspect that you're witnessing something similar here.

> All these servers are only running; shorewall, squid and ntop as their
> primary functions.
> 
> Before I go pasting my .config etc etc I wanted to know first off what
> anyone would really like so I don't paste too much to create a really large
> post.

# ps aux
# lsmod
# dmesg

> Also if it's a known issue?

I don't think so. I've encountered scheduler fairness problems on 2.6
which always made me go back to 2.4, except for my home web server on
parisc which has never been stable for more than a few days on 2.4,
while it's rock solid on 2.6.11, but I never monitor performance there
so it's not a problem. Anyway, its loadavg is ~0.

> But here is a quick vmstat and as can see the 'in' is rather larger than
> normal I would think?

It's expected. In 2.6 on x86, you now have the system timer set to 250 Hz,
while it was at 100 on 2.4. So it implies 150 more interrupts/s that you
can count in the 'in' column. I guess you were roughly between 110 and 160
on 2.4 here.

> Top is not reporting anything usefull really.
> 
> /usr/src/linux-2.6.14.3# vmstat -n 1 
> procs -----------memory---------- ---swap-- -----io---- --system--
> ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id
> wa
>  0  0      0     26    231    364    0    0     0    13   13     4  1  2 97
> 0
>  0  0      0     26    231    364    0    0     0     0  272    42  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  265    35  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  276    46  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0    36  290    70  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0    48  276    64  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  291    69  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0    12  266    37  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  315   120  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     4  322   116  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  313    99  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  301    92  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  279    49  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  298    77  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  315    93  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0    36  300    74  0  0 100
> 0
>  0  0      0     26    231    364    0    0     0     0  283    45  0  0 100
> 0
> 
> A list of the hardware is from lspci is:
> 
> 0000:00:00.0 Host bridge: ServerWorks CNB20HE Host Bridge (rev 23)
> 0000:00:00.1 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
> 0000:00:00.2 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
> 0000:00:00.3 Host bridge: ServerWorks CNB20HE Host Bridge (rev 01)
> 0000:00:01.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
> (rev 08)
> 0000:00:02.0 Ethernet controller: Intel Corp. 82557/8/9 [Ethernet Pro 100]
> (rev 08)
> 0000:00:03.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev
> 27)
> 0000:00:0f.0 ISA bridge: ServerWorks OSB4 South Bridge (rev 50)
> 0000:00:0f.1 IDE interface: ServerWorks OSB4 IDE Controller
> 0000:00:0f.2 USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev
> 04)
> 0000:01:04.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev
> 05)
> 0000:02:00.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev
> 05)
> 0000:02:01.0 SCSI storage controller: QLogic Corp. ISP12160 Dual Channel
> Ultra3 SCSI Processor (rev 06)
> 0000:03:00.0 RAID bus controller: American Megatrends Inc. MegaRAID (rev 20)
> 0000:04:05.0 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 0000:04:05.1 SCSI storage controller: Adaptec AIC-7899P U160/m (rev 01)
> 0000:04:06.0 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet
> Controller (rev 03)
> 0000:04:06.1 Ethernet controller: Intel Corp. 82546GB Gigabit Ethernet
> Controller (rev 03)

Regards,
Willy

