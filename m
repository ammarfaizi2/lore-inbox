Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271520AbRHXNos>; Fri, 24 Aug 2001 09:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271798AbRHXNo0>; Fri, 24 Aug 2001 09:44:26 -0400
Received: from ns.suse.de ([213.95.15.193]:9222 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271520AbRHXNoO>;
	Fri, 24 Aug 2001 09:44:14 -0400
To: Bernhard Busch <bbusch@biochem.mpg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Poor Performance for ethernet bonding
In-Reply-To: <3B865882.24D57941@biochem.mpg.de.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 24 Aug 2001 15:44:29 +0200
In-Reply-To: Bernhard Busch's message of "24 Aug 2001 15:39:15 +0200"
Message-ID: <oupg0ahmv2a.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Busch <bbusch@biochem.mpg.de> writes:

> Hi
> 
> 
> I have tried to use ethernet  network interfaces bonding to increase
> peformance.
> 
> Bonding is working fine, but the performance is rather poor.
> FTP between 2 machines ( kernel 2.4.4 and 4 port DLink 100Mbit ethernet
> card)
> results in a transfer rate of 3MB/s).
> 
> Any Hints?

Bonding reorders packets, which causes frequent retransmits and stalls in TCP.
One setup that doesn't is multipath routing (ip route .. with multiple 
nexthops over different interfaces). It'll only load balance (srcip, dstip,tos)
tuples though, not individual flows, but then it has the advantage that
it actually works.

-Andi
