Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276522AbRJKPVN>; Thu, 11 Oct 2001 11:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276444AbRJKPVD>; Thu, 11 Oct 2001 11:21:03 -0400
Received: from samar.sasken.com ([164.164.56.2]:32713 "EHLO samar.sasken.com")
	by vger.kernel.org with ESMTP id <S276381AbRJKPU4>;
	Thu, 11 Oct 2001 11:20:56 -0400
From: "Shiva Raman Pandey" <shiva@sasken.com>
Subject: NetFilter: Problem in adding additional header using NetFilter
Date: Thu, 11 Oct 2001 20:52:42 +0530
Message-ID: <9q4ddj$bo3$1@ncc-z.sasken.com>
X-Priority: 3
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
To: linux-kernel@vger.kernel.org
X-News-Gateway: ncc-z.sasken.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Friends,
My actual requirement is to insert my own header between Ethernet header and
IP header to all the packets generated at this machine and  remove the same
from all the packets meant for this machine.
So Packets leaving from this machine will look like(assume my header is
BlueTooth header)
Ethernet header -- BT header --IPheader--TCP/UDP/ICMP header
I tried to using Netfilter to solve my purpose, but found that I cant get
the packet directly from ethernet. Even the very first hook PRE_ROUTING also
gives from IP layer only.
So if I add my BT header before IP header, IP layer will not accept the
packet when I will call 'set_verdict'.
So I changed my design :(, to do some dirty work like add the copy of IP
header before BT header again.
Now it will look like
IP header--BT header--IP header--TCP/UDP/ICMP header
and at the recieving end it will remove the IP header--BT header leaving the
remaining packet starting with IP header.

For example, say ping command, packet length = 84 bytes, IP header length =
20 bytes, ICMP header length = 8bytes and my BT header length = 5 bytes
so I made the new packet of length 20+5+20+(84-20) = 109 bytes and called
the function set_verdict, with data_len = 109, and this 109 bytes long
payload.
Now at the recieving machine I should get the 109 bytes long packet, but in
fact IP_QUEUE is giving the packet of 84 bytes only, that are in fact first
84 bytes of the 109 bytes long packet.
Note - I have not touched the checksum fields.

So, my questions are :
1) When I am sending 109 bytes, why I am getting only 84 bytes?
2) I tried changing the payload[3] (ie, packet length field) to 109, in that
case the packet never reaches the destination, why?
3) Is this problem due to checksum?
4) Is there any way using netfilter, I can get the packet from ethernet
directly, that will suit my actual design? or any other easy way?
5) How can I verify that the sending machine is actually sending 109 bytes(I
mean not reducing it to 84)?

Please send me your suggestions to  find out the solution for this problem

Thanks alot.
Regards
Shiva Raman Pandey
Research Associate, Computer Science -R&D
Sasken Communication Technologies Limited
Bangalore, India


