Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270947AbRIARlY>; Sat, 1 Sep 2001 13:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270958AbRIARlP>; Sat, 1 Sep 2001 13:41:15 -0400
Received: from colin.muc.de ([193.149.48.1]:55817 "HELO colin.muc.de")
	by vger.kernel.org with SMTP id <S270947AbRIARlA>;
	Sat, 1 Sep 2001 13:41:00 -0400
Message-ID: <20010901194141.44617@colin.muc.de>
Date: Sat, 1 Sep 2001 19:41:41 +0200
From: Andi Kleen <ak@muc.de>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: "David S . Miller" <davem@redhat.com>, Andi Kleen <ak@muc.de>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, linux-kernel@vger.kernel.org
Subject: Re: Excessive TCP retransmits over lossless, high latency link
In-Reply-To: <20010901181729.A2204@thefinal.cern.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.88e
In-Reply-To: <20010901181729.A2204@thefinal.cern.ch>; from Jamie Lokier on Sat, Sep 01, 2001 at 07:17:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 07:17:29PM +0200, Jamie Lokier wrote:
> The appended "tcpdump -i ppp0 -n" trace shows an excessive number of
> retransmits from the remote POP server.  The retransmits are triggered
> by excessive duplicate ACKs from the local client.  By excessive, I mean
> lots of retransmits of the same data.

The duplicate ACKs should not cause any retransmits (unless the sender
is badly broken), because they contain a high enough ACK number.

The problem is really that a TCP sender cannot recover from a too short RTT 
estimate; if the RTT is longer and it doesn't get any acks it'll assume 
packet loss and never has a chance to find out about the longer RTT, because
that only works with new ACKs. 

The standard initial RTT is 3 seconds; but your RTT is 5.2s. 

What you can do is to change the initial RTT on the sender side. On Linux
it can be done with the "irtt" option of route or the equivalent one of
iproute2. Most other OS have a similar way to configure the IRTT. 

-Andi
