Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131728AbRCOOU3>; Thu, 15 Mar 2001 09:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131733AbRCOOUT>; Thu, 15 Mar 2001 09:20:19 -0500
Received: from robur.slu.se ([130.238.98.12]:17937 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S131730AbRCOOUR> convert rfc822-to-8bit;
	Thu, 15 Mar 2001 09:20:17 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <15024.53099.41814.716733@robur.slu.se>
Date: Thu, 15 Mar 2001 15:19:23 +0100 (CET)
To: Mårten_Wikström <Marten.Wikstrom@framfab.se>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: How to optimize routing performance
X-Mailer: VM 6.75 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rik van Riel writes:
 > On Thu, 15 Mar 2001, [ISO-8859-1] Mårten Wikström wrote:
 > 
 > > I've performed a test on the routing capacity of a Linux 2.4.2 box
 > > versus a FreeBSD 4.2 box. I used two Pentium Pro 200Mhz computers with
 > > 64Mb memory, and two DEC 100Mbit ethernet cards. I used a Smartbits
 > > test-tool to measure the packet throughput and the packet size was set
 > > to 64 bytes. Linux dropped no packets up to about 27000 packets/s, but
 > > then it started to drop packets at higher rates. Worse yet, the output
 > > rate actually decreased, so at the input rate of 40000 packets/s
 
 It is a known problem yes. And just as Rik says its has been adressed
 in 2.1.x by Alexey for first time.


> > almost no packets got through. The behaviour of FreeBSD was different,
 > > it showed a steadily increased output rate up to about 70000 packets/s
 > > before the output rate decreased. (Then the output rate was apprx.
 > > 40000 packets/s).
 > 
 > > So, my question is: are these figures true, or is it possible to
 > > optimize the kernel somehow? The only changes I have made to the
 > > kernel config was to disable advanced routing.
 > 
 > There are some flow control options in the kernel which should
 > help. From your description, it looks like they aren't enabled
 > by default ...

 CONFIG_NET_HW_FLOWCONTROL enables kernel code for it. But device
 drivers has to have support for it. But unfortunely very few drivers
 has support for it.

 Also we done experiments were we move the device RX processing to 
 SoftIRQ rather than IRQ. With this RX is in better balance with 
 other kernel tasks and TX. Under very high load and under DoS 
 attacks the system is now manageable. It's in practical use already.


 > At the NordU/USENIX conference in Stockholm (this february) I
 > saw a nice presentation on the flow control code in the Linux
 > networking code and how it improved networking performance.
 > I'm pretty convinced that flow control _should_ be saving your
 > system in this case.

 Thanks Rik. 

 This is work/experiments by Jamal and me with support from Gurus. :-) 
 Jamal did this presentation at OLS 2000. At NordU/USENIX I gave an
 updated presentation of it. The presentation is not yet available form 
 the usenix webb I think.
 
 It can ftp from robur.slu.se:
 /pub/Linux/tmp/FF-NordUSENIX.pdf or .ps

 In summary Linux is very decent router. Wire speed small packets
 @ 100 Mbps and capable of Gigabit routing (1440 pkts tested) 
 we used.
 
 Also if people are interested we have done profiling on a Linux
 production router with full BGP at pretty loaded site. This to
 give us costs for route lookup, skb malloc/free, interrupts etc.
 
 http://Linux/net-development/experiments/010313

 I'm on netdev but not the kernel list.

 Cheers.

						--ro
