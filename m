Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbUC3OCQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbUC3OBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:01:35 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:328 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263666AbUC3OAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:00:32 -0500
Message-ID: <40696FFB.8000809@myrealbox.com>
Date: Tue, 30 Mar 2004 05:02:51 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040327
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roger Luethi <rl@hellgate.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via-Rhine ethernet driver problem?
References: <40685BC9.1040902@myrealbox.com> <20040329183658.GA28252@k3.hellgate.ch>
In-Reply-To: <20040329183658.GA28252@k3.hellgate.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roger Luethi wrote:
> On Mon, 29 Mar 2004 09:24:25 -0800, walt wrote:
> 
>>ECS K7VTA3 motherboard with built-in ethernet chip:
>>
>>00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 
>>74)
>>[...]
>>I also discovered by using 'scp' to copy files between machines that the bad
>>performance is assymetrical:  copying a file *to* this machine runs at about
>>half-speed (5 MB/sec) whereas copying a file *from* this machine runs at
>>45 KiloB/sec, about one percent of expected.


> If you have ACPI and/or IO-APIC enabled, does the behavior change if
> you turn them off?

I did have both -- no difference when I turned them both off.

> Any info in the kernel log? If not, what if you
> change the driver's debug level to 3? 

This is debug=4 since debug=3 didn't put out much:
Mar 30 04:27:58 k9 kernel: via-rhine.c:v1.10-LK1.1.19-2.5  July-12-2003  Written by Donald Becker
Mar 30 04:27:58 k9 kernel:   http://www.scyld.com/network/via-rhine.html
Mar 30 04:27:58 k9 kernel: via-rhine: Reset succeeded.
Mar 30 04:27:58 k9 kernel: eth0: VIA VT6102 Rhine-II at 0xe9041000, 00:0d:87:a2:ce:02, IRQ 11.
Mar 30 04:27:58 k9 kernel: eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
Mar 30 04:27:58 k9 kernel: eth0: MII PHY found at address 2, status 0x8000 advertising 0000 Link 8000.
Mar 30 04:27:58 k9 kernel: eth0: MII PHY found at address 3, status 0x8000 advertising 0000 Link 8000.
Mar 30 04:27:58 k9 kernel: eth0: MII PHY found at address 4, status 0x8000 advertising 0000 Link 8000.
Mar 30 04:28:37 k9 kernel: eth0: via_rhine_open() irq 11.
Mar 30 04:28:37 k9 kernel: eth0: Reset succeeded.
Mar 30 04:28:37 k9 kernel: eth0: Done via_rhine_open(), status 081a MII status: 786d.
Mar 30 04:28:37 k9 kernel: eth0: VIA Rhine monitor tick, status 0000.
Mar 30 04:29:17 k9 last message repeated 4 times
Mar 30 04:29:37 k9 last message repeated 2 times
Mar 30 04:29:44 k9 kernel: eth0: exiting interrupt, status=00000000.
Mar 30 04:29:44 k9 last message repeated 25 times
Mar 30 04:29:47 k9 kernel: eth0: VIA Rhine monitor tick, status 0000.
Mar 30 04:29:49 k9 kernel: eth0: exiting interrupt, status=00000000.
Mar 30 04:29:57 k9 last message repeated 543 times
[much more snipped]


> Is the slow transfer rate
> the result of short, fast bursts or actual sustained throughput at
> 45 KB/sec?

Just from watching the lights on the ethernet hub I would say that it
is bursting.  Is there a more accurate way to tell?

Thanks for the quick response!

BTW, this is from ethtool:
Supported ports: [ TP MII ]
Supported link modes:   10baseT/Half 10baseT/Full
                         100baseT/Half 100baseT/Full
Supports auto-negotiation: Yes
Advertised link modes:  10baseT/Half 10baseT/Full
                         100baseT/Half 100baseT/Full
Advertised auto-negotiation: Yes
Speed: 100Mb/s
Duplex: Full
Port: MII
PHYAD: 1
Transceiver: internal
Auto-negotiation: on
Current message level: 0x00000004 (4)
Link detected: yes
