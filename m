Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265452AbUASRZA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUASRZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:25:00 -0500
Received: from mail33.messagelabs.com ([195.245.230.51]:21736 "HELO
	mail33.messagelabs.com") by vger.kernel.org with SMTP
	id S265452AbUASRY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:24:56 -0500
X-VirusChecked: Checked
X-Env-Sender: okiddle@yahoo.co.uk
X-Msg-Ref: server-23.tower-33.messagelabs.com!1074533094!775317
X-StarScan-Version: 5.1.15; banners=-,-,-
X-VirusChecked: Checked
X-StarScan-Version: 5.0.7; banners=.,-,-
In-reply-to: <20040119145430.GI1748@srv-lnx2600.matchmail.com> 
From: Oliver Kiddle <okiddle@yahoo.co.uk>
References: <7641.1074512162@gmcs3.local> <20040119145430.GI1748@srv-lnx2600.matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure 
Date: Mon, 19 Jan 2004 18:29:03 +0100
Message-ID: <9759.1074533343@gmcs3.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> 
> Try running "vmstat 1" and output that to a file, and post your /proc/meminfo.
> 
> Do you start getting the error before a couple of days, or you just can't
> login after that amount of time?

I can't log in immediately following the first occurence of the error.
I can type in a username at the login prompt but nothing happens after
pressing enter. Two days was just a rough idea of how long the system
could be up before going down. It has gone down twice since I posted
earlier so it wasn't even vaguely an accurate figure. On both
occasions, there has not been a "page allocation failure" error though.

These last two times, I was running xfsdump along with a nfsd activity.
I had the following, possibly unrelated messages on the console.

st0: Block limits 1 - 16777215 bytes.
spurious 8259A interrupt IRQ7

I've put /proc/meminfo below though that is from the beginning while
everything is still fine. The vmstat output is more interesting and I
have it captured for the period when it went down.

vmstat output starts off like this:
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 2  0      0 947908   5792  37128    0    0    54    49 1072   121  0  2 96  2

The free column then slowly drops.

Shortly before the end, is this sequence:

 2  1      0  57036   2412  62044    0    0  2224   512 1950   188  1 70 20  9
 0  0      0  55104   1284  64096    0    0  2204   320 1663   154  0 51 42  7
 2  1      0  53048     44  67168    0    0  3080     0 1939    32  0 59 38  3
 2  0   1388  49748     56  69592    0 1388  2796  1393 1909   161  1 64 15 19
 3  2   1928  45828     60  72376   64 1208  3056  1208 2146   184  3 70  2 25
 1  4   1464  94700     60  22088    0  808  3428   828 1873   213  1 58  0 41
 0  1   1176  93716     60  23060  356  316  1596   429 2079   342  0 56  4 40
 3  3   1176  94116     64  22368  144    0  1124   311 6419  1369  0  6  1 93
 1  2   1176 109176     36   7360    0    0   828   159 29189  7978  0  1  0 99

This is the first time the swpd column is non-zero. The figures don't
change a vast amount after that and only 25 samples later, the very last
sample I got looked like this:

 0  1   1176 109248     40   7364    0    0     0     0 1009    25  0  1  0 99

I can send you the full output if you want (70kb compressed).

/proc/meminfo:
MemTotal:      1034796 kB
MemFree:        884620 kB
Buffers:         14768 kB
Cached:          61192 kB
SwapCached:          0 kB
Active:          51972 kB
Inactive:        35992 kB
HighTotal:      131008 kB
HighFree:        57148 kB
LowTotal:       903788 kB
LowFree:        827472 kB
SwapTotal:      996020 kB
SwapFree:       996020 kB
Dirty:              24 kB
Writeback:           0 kB
Mapped:          16772 kB
Slab:            31064 kB
Committed_AS:    24876 kB
PageTables:        536 kB
VmallocTotal:   114680 kB
VmallocUsed:       692 kB
VmallocChunk:   113988 kB

I have /tmp mounted using tmpfs if that is in any way significant.

Thanks

Oliver
