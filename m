Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbUKWBrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbUKWBrG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbUKWBqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:46:12 -0500
Received: from mpls-qmqp-01.inet.qwest.net ([63.231.195.112]:40716 "HELO
	mpls-qmqp-01.inet.qwest.net") by vger.kernel.org with SMTP
	id S262522AbUKWBjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:39:10 -0500
Date: Mon, 22 Nov 2004 18:47:17 -0700
Message-ID: <DHEOJAHAGKDLCDOHPMIECEFNCCAA.stuart@ken-caryl.net>
From: "Stuart Macdonald" <stuart@ken-caryl.net>
To: "Henrik Nordstrom" <hno@marasystems.com>,
       "cranium2003" <cranium2003@yahoo.com>
Cc: kernelnewbies@nl.linux.org, netfilter-devel@lists.netfilter.org,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Reply-To: <stuart@ken-caryl.net>
Subject: RE: netfilter query
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.61.0411221245470.20973@filer.marasystems.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a parallel thought here,

A different approach is to implement the Netfilter Bridge hooks and run a
box as a bridge. This requires a kernel parameter for Bridge to be enabled
when the kernel is built and then the brctl utility to setup the bridge. In
this manner, your bridge netfilter hooks always receive packets starting at
the MAC headers. You can parse from there to derive subsequent protocols:
IP, IPX, LLC, SNAP, NETBEUI...

Stuart



-----Original Message-----
From: kernelnewbies-bounce@nl.linux.org
[mailto:kernelnewbies-bounce@nl.linux.org]On Behalf Of Henrik Nordstrom
Sent: Monday, November 22, 2004 5:03 AM
To: cranium2003
Cc: kernelnewbies@nl.linux.org; netdev@oss.sgi.com;
netfilter-devel@lists.netfilter.org; linux-kernel@vger.kernel.org
Subject: Re: netfilter query


On Sun, 21 Nov 2004, cranium2003 wrote:

> Also,which headers are added when packet
> reaches to netfilter hook NF_IP_LOCAL_OUT? I found
> TCP/UDP/ICMP ,IP. Is that correct?

Yes.

netfilter is running at the IP layer and only reliably have access to IP
headers and up. Lower level headers such as Ethernet MAC header is
transport dependent and not always available, and certainly not available
in NF_IP_LOCAL_OUT as it is not yet known the packet will be sent to an
Ethernet.

In some netfilter hooks it is possible to rewind back to the Ethernet MAC
header but one must be careful to verify that it really is an Ethernet
packet one is looking at when doing this. Unfortunately there is no
perfect solution how to detect this.. For an example of how one may try to
look at the Ethernet MAC header see ipt_mac.c. But be warned that it is
possible for non-Ethernet frames to pass the simple checks done there..

Regards
Henrik

--
Kernelnewbies: Help each other learn about the Linux kernel.
Archive:       http://mail.nl.linux.org/kernelnewbies/
FAQ:           http://kernelnewbies.org/faq/


