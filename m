Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316655AbSGBGpg>; Tue, 2 Jul 2002 02:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSGBGpf>; Tue, 2 Jul 2002 02:45:35 -0400
Received: from mail.zmailer.org ([62.240.94.4]:31945 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S316655AbSGBGpf>;
	Tue, 2 Jul 2002 02:45:35 -0400
Date: Tue, 2 Jul 2002 09:48:02 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Dax Kelson <dax@GuruLabs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is ff:00:00:00:00:00 a broadcast frame?
Message-ID: <20020702094802.Y28720@mea-ext.zmailer.org>
References: <Pine.LNX.4.33.0206291000060.23706-100000@w-nivedita2.des.beaverton.ibm.com> <1025566031.5129.179.camel@porthos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025566031.5129.179.camel@porthos>; from dax@GuruLabs.com on Mon, Jul 01, 2002 at 05:27:11PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2002 at 05:27:11PM -0600, Dax Kelson wrote:
> In the "earlier" 2.4 kernels (those that shipped/errata with RHL 7.1
> ~2.4.6), an ethernet frame destined to ff:00:00:00:00:00 were not
> processed and passed up the stack.
> 
> Now, with "current" 2.4 kernels (RHL 7.2 errata, and RHL 7.3
> 2.4.9-2.4.18), the same frame IS processed and passed up the stack.

  That IEEE 802 MAC address is NOT a broadcast address.
  Broadcast would be one with all bits set:  ff:ff:ff:ff:ff:ff

  The above mentioned MAC address is a multicast frame, because
  bit  0x01 in the first octet is set.  (All broadcast-frames are
  also multicast.)

> The hardware is identical, the NICs are 3c905C.
> 
> Is this an intentional optimization/bug?
> 
> Here is an ARP request encapsulated in a "bogus" ethernet frame (look at
> the layer 2 destination). A RHL 7.3 (2.4.18) system will respond (see
> Frame 2 below) to this frame, an older RHL 7.1 (2.4.6) system will not
> respond.

  Neither should respond.  IPv4 ARP is defined using only broadcast
  frames.

> Frame 1 (42 on wire, 42 captured)
>     Arrival Time: Jul  1, 2002 17:16:35.565996000
>     Time delta from previous packet: 1.009672000 seconds
>     Time relative to first packet: 1.009833000 seconds
>     Frame Number: 3
>     Packet Length: 42 bytes
>     Capture Length: 42 bytes
> Ethernet II
>     Destination: ff:00:00:00:00:00 (ff:00:00:00:00:00)
>     Source: ff:00:00:00:00:00 (ff:00:00:00:00:00)
>     Type: ARP (0x0806)
> Address Resolution Protocol (request)
>     Hardware type: Ethernet (0x0001)
>     Protocol type: IP (0x0800)
>     Hardware size: 6
>     Protocol size: 4
>     Opcode: request (0x0001)
>     Sender MAC address: 00:01:03:de:56:a4 (00:01:03:de:56:a4)
>     Sender IP address: 10.100.0.8 (10.100.0.8)
>     Target MAC address: 00:00:00:00:00:00 (00:00:00:00:00:00)
>     Target IP address: 10.100.0.10 (10.100.0.10)
> 
> Frame 2 (60 on wire, 60 captured)
>     Arrival Time: Jul  1, 2002 17:16:35.566146000
>     Time delta from previous packet: 0.000150000 seconds
>     Time relative to first packet: 1.009983000 seconds
>     Frame Number: 4
>     Packet Length: 60 bytes
>     Capture Length: 60 bytes
> Ethernet II
>     Destination: 00:01:03:de:56:a4 (00:01:03:de:56:a4)
>     Source: 00:01:03:de:57:37 (00:01:03:de:57:37)
>     Type: ARP (0x0806)
>     Trailer: 00000000000000000000000000000000...
> Address Resolution Protocol (reply)
>     Hardware type: Ethernet (0x0001)
>     Protocol type: IP (0x0800)
>     Hardware size: 6
>     Protocol size: 4
>     Opcode: reply (0x0002)
>     Sender MAC address: 00:01:03:de:57:37 (00:01:03:de:57:37)
>     Sender IP address: 10.100.0.10 (10.100.0.10)
>     Target MAC address: 00:01:03:de:56:a4 (00:01:03:de:56:a4)
>     Target IP address: 10.100.0.8 (10.100.0.8)
