Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291195AbSBGSj2>; Thu, 7 Feb 2002 13:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291224AbSBGSh7>; Thu, 7 Feb 2002 13:37:59 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:47036 "EHLO
	zcars0m9.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S291195AbSBGShi>; Thu, 7 Feb 2002 13:37:38 -0500
Message-ID: <3C62CB25.75487AD5@nortelnetworks.com>
Date: Thu, 07 Feb 2002 13:44:53 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: "Perches, Joe" <joe.perches@spirentcom.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: want opinions on possible glitch in 2.4 network error reporti ng
In-Reply-To: <Pine.LNX.3.95.1020207125644.8721A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Thu, 7 Feb 2002, Perches, Joe wrote:
> [SNIPPED..]
> > > That is correct UDP behaviour
> >
> > Do you think this is the correct PacketSocket/RAW behaviour?
> 
> Yes.
> 
> > How does one guarantee a send/sendto/write?
> > -
> 
> Easy, you use send() or write(). These work on stream protocol TCP/IP
> where there is a "connection". Connectionless protocols, i.e., UDP are
> not guaranteed to do anything useful -- but, because of their speed,
> they can be useful with some help from user-mode code.

Is there any syscall that can guarantee that a single packet has been sent out
over the wire?  Suppose I want to broadcast an ARP packet.  If I make a packet
socket and call sendto() on it, I want a guarantee that the packet will make it
out onto the wire, or the sendto() should fail.

UDP failing I can understand (kind of, anyway) but for raw sockets, packet
sockets, etc. I think there should be at least some kind of mechanism to bypass
all the congestion controls and either shove the packet onto the device's tx
buffer or return a failure code.

The possibility of random dropping of packets in the kernel means that an
infinite loop on sendto() will chew up the entire machine even if you've only
got a 10Mbit/s link.  This seems just wrong.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
