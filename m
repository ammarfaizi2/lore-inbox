Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUJPOcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUJPOcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 10:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUJPOck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 10:32:40 -0400
Received: from stutter.bur.st ([202.61.227.61]:2331 "EHLO stutter.bur.st")
	by vger.kernel.org with ESMTP id S268750AbUJPOch (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 10:32:37 -0400
Date: Sat, 16 Oct 2004 22:32:34 +0800
From: Trent Lloyd <lathiat@bur.st>
To: S Iremonger <exxsi@bath.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2.6 under DDoS behavior
Message-ID: <20041016143234.GA14601@sweep.bur.st>
References: <66e7584804101413023b16b92a@mail.gmail.com> <Pine.GSO.4.53.0410151301100.15508@amos.bath.ac.uk> <66e75848041015193427c2c6f7@mail.gmail.com> <Pine.GSO.4.53.0410161519100.15508@amos.bath.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.53.0410161519100.15508@amos.bath.ac.uk>
X-Random-Number: 2.36128461241658e-126
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem is the linux box in front has to handle double the packets and
would have to be really fast (e.g. expensive) as well

> >On Fri, 15 Oct 2004 13:04:22 +0100 (BST), S Iremonger <exxsi@bath.ac.uk> wrote:
> >> >the external interface was
> >> >seeing about 600,000 pps at ~350Mbit/sec.    The link is 1Gb, so it
> >> You may want some kind of simpler non-contracking machine infront,
> >>   that has a simpler stateless firewall configuration on it... --
> >> Maybe 'syncookies firewall' on that machine too....
> 
> >Possibly, yeah.  I guess it depends on if it can keep up with the traffic.
> 
> 
> 
> I suggest trying out following configuration:-
> 
> --box infront of the ''firewall'' with:-
> Optimized kernel WITHOUT connection tracking on nice network
>   devices/drivers...
> Make SURE the kernel is configured as "optimize as router not host".
> And -- instigate a **SIMPLE** ruleset (if any rules at all), e.g.
>   just IP addresses and protocol types  or something...
> Install the 'syncookies firewall' on this host, which will answer
>   syn packets from outside with a 'cookie' and expect to see a
>   valid answer to the cookie, and will then (and ONLY THEN) forward
>   connection 'inbounds' to the network...
> 
> Then have your 'real firewall' with connection tracking, and more
>   complicated ruleset inside that....
> 
> I'd like to hear anybody's opinions on the above.
> Maybe what I said is counterproductive, maybe it isn't....
> I want to hear, in any case.
> 
> What I *am* preety sure about, is 'connection tracking' (needed for
>   proper NAT as opposed to static 1-1 NAT) DOES slow down your
>   packet passing rate CONSIDERABLY.
> 
> >Right.  It's an Intel 7502 board, dual on board Gig, and a a couple of
> >Gig cards in the PCI-X slots.  All are the newer kind with interrupt
> >coalescing, but that doesn't matter much with 2.6 and NAPI.  One
> I'm sorry, I dont know that board...
> 
> >It was a Syn flood, so the easy answer here is to let it through and
> >let the target hosts deal with it directly.
> Well, MAYBE, but then MAYBE the SYN flood will just tie up all the
>   conntrack tables ?
> 
> >I'm not seeking an easy answer, but am wondering what kind of pps
> >limit people think is reasonable to expect.
> >Should 1.5M pps be possible, has someone done it?
> I don't know. sorry.....
> 
> 
> Good luck, let me know what happens...
> 
> --S Iremonger <exxsi@bath.ac.uk>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Trent Lloyd <lathiat@bur.st>
Bur.st Networking Inc.
