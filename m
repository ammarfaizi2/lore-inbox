Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288809AbSANSyW>; Mon, 14 Jan 2002 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288862AbSANSyS>; Mon, 14 Jan 2002 13:54:18 -0500
Received: from mail.myrio.com ([63.109.146.2]:31217 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S288809AbSANSx1> convert rfc822-to-8bit;
	Mon, 14 Jan 2002 13:53:27 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] Rx FIFO Overrun error found
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Mon, 14 Jan 2002 10:52:17 -0800
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB2D@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Rx FIFO Overrun error found
Thread-Index: AcGdIgapp60g6HV5Tp6wzqBA9yB8NgAA/UdA
From: "Torrey Hoffman" <torrey.hoffman@myrio.com>
To: "Manfred Spraul" <manfred@colorfullife.com>,
        "Jeff Garzik" <jgarzik@mandrakesoft.com>
Cc: "Tim Hockin" <thockin@sun.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Spraul wrote, and my ears perked up:
...
> Attached is the patch against the nic hang. Now all rx error bits
> trigger netdev_rx - it doesn't hurt and could catch further hardware
> oddities.

hello natsemi-users ...  

We've been having difficult-to-reproduce problems with IP 
multicast receive on our natsemi hardware, could this be 
related?

Our application receives an IP multicast stream (MPEG-2
video) at about 4 Mb/sec, and sometimes, randomly, 
multicast packets just stop showing up at the app layer.
This typically happens after hours of no problems.
(Kernel is 2.4.16 with low-latency patch)

When this happens, tcpdump on the same machine doesn't 
see the multicast packets either, but: TCP connections 
like FTP still work fine, and other machines on the same 
hub still see the multicast traffic, so we are sure the 
packets are on the wire.

Our app detects the unexpected loss of the stream and 
repeatedly does multicast joins to try to get it back, 
but this does not seem to help.  However, switching to a 
different IP multicast address works - if we change to
a different channel and then back again, everything
will work again... until next time.

I wonder if the multicast hash table is getting corrupted 
somehow...

Maybe I should force the multicast hash table to be
rebuilt on any rx error?

Advice welcome, even suggestions on where to put printk
statements...

Torrey

