Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSGAXYq>; Mon, 1 Jul 2002 19:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316579AbSGAXYp>; Mon, 1 Jul 2002 19:24:45 -0400
Received: from w007.z208177138.sjc-ca.dsl.cnc.net ([208.177.141.7]:57514 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S316578AbSGAXYo>;
	Mon, 1 Jul 2002 19:24:44 -0400
Subject: Is ff:00:00:00:00:00 a broadcast frame?
From: Dax Kelson <dax@GuruLabs.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0206291000060.23706-100000@w-nivedita2.des.beaverton.ibm.com>
References: <Pine.LNX.4.33.0206291000060.23706-100000@w-nivedita2.des.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Jul 2002 17:27:11 -0600
Message-Id: <1025566031.5129.179.camel@porthos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In the "earlier" 2.4 kernels (those that shipped/errata with RHL 7.1
~2.4.6), an ethernet frame destined to ff:00:00:00:00:00 were not
processed and passed up the stack.

Now, with "current" 2.4 kernels (RHL 7.2 errata, and RHL 7.3
2.4.9-2.4.18), the same frame IS processed and passed up the stack.

The hardware is identical, the NICs are 3c905C.

Is this an intentional optimization/bug?

Here is an ARP request encapsulated in a "bogus" ethernet frame (look at
the layer 2 destination). A RHL 7.3 (2.4.18) system will respond (see
Frame 2 below) to this frame, an older RHL 7.1 (2.4.6) system will not
respond.

Frame 1 (42 on wire, 42 captured)
    Arrival Time: Jul  1, 2002 17:16:35.565996000
    Time delta from previous packet: 1.009672000 seconds
    Time relative to first packet: 1.009833000 seconds
    Frame Number: 3
    Packet Length: 42 bytes
    Capture Length: 42 bytes
Ethernet II
    Destination: ff:00:00:00:00:00 (ff:00:00:00:00:00)
    Source: ff:00:00:00:00:00 (ff:00:00:00:00:00)
    Type: ARP (0x0806)
Address Resolution Protocol (request)
    Hardware type: Ethernet (0x0001)
    Protocol type: IP (0x0800)
    Hardware size: 6
    Protocol size: 4
    Opcode: request (0x0001)
    Sender MAC address: 00:01:03:de:56:a4 (00:01:03:de:56:a4)
    Sender IP address: 10.100.0.8 (10.100.0.8)
    Target MAC address: 00:00:00:00:00:00 (00:00:00:00:00:00)
    Target IP address: 10.100.0.10 (10.100.0.10)

Frame 2 (60 on wire, 60 captured)
    Arrival Time: Jul  1, 2002 17:16:35.566146000
    Time delta from previous packet: 0.000150000 seconds
    Time relative to first packet: 1.009983000 seconds
    Frame Number: 4
    Packet Length: 60 bytes
    Capture Length: 60 bytes
Ethernet II
    Destination: 00:01:03:de:56:a4 (00:01:03:de:56:a4)
    Source: 00:01:03:de:57:37 (00:01:03:de:57:37)
    Type: ARP (0x0806)
    Trailer: 00000000000000000000000000000000...
Address Resolution Protocol (reply)
    Hardware type: Ethernet (0x0001)
    Protocol type: IP (0x0800)
    Hardware size: 6
    Protocol size: 4
    Opcode: reply (0x0002)
    Sender MAC address: 00:01:03:de:57:37 (00:01:03:de:57:37)
    Sender IP address: 10.100.0.10 (10.100.0.10)
    Target MAC address: 00:01:03:de:56:a4 (00:01:03:de:56:a4)
    Target IP address: 10.100.0.8 (10.100.0.8)

