Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbUDPDPV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 23:15:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbUDPDPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 23:15:21 -0400
Received: from tantale.fifi.org ([216.27.190.146]:2448 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S262043AbUDPDPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 23:15:15 -0400
To: Russell Miller <rmiller@duskglow.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: udp traceroute dropping packets
References: <200404152155.18724.rmiller@duskglow.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 15 Apr 2004 20:15:10 -0700
In-Reply-To: <200404152155.18724.rmiller@duskglow.com>
Message-ID: <87brlstxz5.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> writes:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I came across this archived linux-kernel message:
> 
> http://www.uwsg.iu.edu/hypermail/linux/net/0007.2/0111.html
> 
> I am having the exact same problem as is outlined there, from a post three 
> years ago.  Here's a summary:
> 
> "I think I've found a bug in UDP/ICMP code in the kernel using 
>  traceroute. 
>  
> To reproduce: Launch traceroute -n to some Linux system nearby 
>  really quickly 3 times in the row; localhost won't work, it has to go 
>  through network. Quick response is crucial. I used systems w/ in 
>  the same physical network and a few routers between (still < 5 ms 
>  response). 
>  
> The effect: On third traceroute (or perhaps second/first, if you're quick 
>  enough), ICMP port unreachable will not be sent to the UDP datagram. "
> 
> I reproduced this on a redhat 8.0 machine running kernel 2.4.23.
> Changing to the -I option of traceroute (to use ICMP) works
> flawlessly.  I'll be glad to provide more information if you need
> it.  Please CC, as I'm not subscribed.

You're probably hitting the ICMP rate limit.

Play with /proc/sys/net/ipv4/icmp_rate*.

 - increase /proc/sys/net/ipv4/icmp_ratelimit

or

 - clear bit 3 in /proc/sys/net/ipv4/icmp_ratemask

Phil.
