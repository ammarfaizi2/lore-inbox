Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAVSRI>; Mon, 22 Jan 2001 13:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129985AbRAVSQs>; Mon, 22 Jan 2001 13:16:48 -0500
Received: from dweeb.lbl.gov ([128.3.1.28]:32775 "EHLO beeble.lbl.gov")
	by vger.kernel.org with ESMTP id <S129444AbRAVSQm>;
	Mon, 22 Jan 2001 13:16:42 -0500
Message-ID: <3A6C78A9.1EB43322@lbl.gov>
Date: Mon, 22 Jan 2001 10:15:05 -0800
From: Thomas Davis <tadavis@lbl.gov>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-RAID i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Chabot <chabotc@reviewboard.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Interface statistics for Bonding bug in 2.4
In-Reply-To: <3A6CF2EB.7EB23951@reviewboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The answer is in the source; in v2.4, stats are only collected on sent
packets; in v2.2, stats are not collected at all; they are simply summed
from the interfaces stats.

It's not a bug; it's simply a design decision.

Chris Chabot wrote:
> 
> I recently upgraded my main server to a 2.4 kernel (2.4.1pre9). This
> machine uses 2 3Com 3C905B networkcards, bonded together (using the
> bonding module).
> 
> When doing a 'ifconfig' the bond0 device shows 0 RX packets, and a valid
> # of TX packets. However looking at eth0 / eth1 (the 2 network cards)
> they have the just about the same amount of RX packets, so recieving
> does apear to be balanced over the two interfaces.
> 
> When running this machine on 2.2.16 the interface it does show the
> interface statistics accuratly. I also tested this on a clean 2.4.0
> kernel, and it had the same bug.
> 
> The ifconfig output (note the 0 packets in bond0's RX)
> 
> bond0     Link encap:Ethernet  HWaddr 00:50:DA:B8:33:0F
>           inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
> 
>           UP BROADCAST RUNNING MASTER MULTICAST  MTU:1500  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:3655 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:0
> 
> eth0      Link encap:Ethernet  HWaddr 00:50:DA:B8:33:0F
>           inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
> 
>           UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
>           RX packets:1992 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1828 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           Interrupt:11 Base address:0x9800
> 
> eth1      Link encap:Ethernet  HWaddr 00:50:DA:B8:33:0F
>           inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
> 
>           UP BROADCAST RUNNING SLAVE MULTICAST  MTU:1500  Metric:1
>           RX packets:1878 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:1827 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:100
>           Interrupt:10 Base address:0x9400
> 
> Please CC me in any replies since im not subscribed to the kernel list.
> 
>     -- Chris

-- 
------------------------+--------------------------------------------------
Thomas Davis		| PDSF Project Leader
tadavis@lbl.gov		| 
(510) 486-4524		| "Only a petabyte of data this year?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
