Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278879AbRK1STw>; Wed, 28 Nov 2001 13:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277371AbRK1STm>; Wed, 28 Nov 2001 13:19:42 -0500
Received: from ns.suse.de ([213.95.15.193]:59408 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S278879AbRK1STc>;
	Wed, 28 Nov 2001 13:19:32 -0500
To: Adrian Daminato <adrian@tucows.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hiding arp for server farms
In-Reply-To: <3C0522C4.E5321021@tucows.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 28 Nov 2001 19:19:31 +0100
In-Reply-To: Adrian Daminato's message of "28 Nov 2001 18:48:24 +0100"
Message-ID: <p731yiisqq4.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Daminato <adrian@tucows.com> writes:

> Now, introduce an unpatched 2.4.x kernel.  The hidden option no longer exists,
> and for ease of operating a production environment, we prefer to use stock
> kernels straight from kernel.org, no patches at all.  I've tried many different
> suggestion from the list:
> 
> 1) ifconfig eth0 -arp

It'll make the stack no put any mac addresses into your packets,
which is likely not what you want.

> 
> Is there any way to have this work on an unpatched 2.4.x kernel?  Any
> documentation/examples for arp_filter, how it works, how it can be implemented
> for this?

arp_filter was not really designed to fix such a br^wweird setup.

It is possible to do it but a bit ugly. Basically you have to express a policy
filter rule/route that matches the outgoing ARP, but not the data and make the arp
route a blackhole route. The kernel unfortunately has no special key to select
ARP, so it has to be expressed in some other way (e.g. mark rules etc.), which is 
usually possible, but ugly. 

Your problems in (3) is that you asked for ARP to be turned off which
obviously breaks things if noone else (like your load balancing monstrosity) does 
the ARP for you. IIRC the hidden guys usually work around this by using a 
separate hidden virtual interface and only use that for load balancing purposes.
In the end it gets similarly ugly as the arp_filter setup.

-Andi

P.S.: I would not recommend 2.4.9 unpatched for any production setup. 
