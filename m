Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264117AbUDVVKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264117AbUDVVKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 17:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264675AbUDVVKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 17:10:41 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:18949 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S264117AbUDVVKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 17:10:39 -0400
Date: Thu, 22 Apr 2004 23:08:39 +0200
From: Willy Tarreau <w@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
Message-ID: <20040422210839.GA8142@alpha.home.local>
References: <XFMail.20040422102359.pochini@shiny.it> <Pine.LNX.4.53.0404220734330.8039@chaos> <20040422131704.GA6839@alpha.home.local> <Pine.LNX.4.53.0404220929500.8745@chaos> <20040422141848.GA6986@alpha.home.local> <Pine.LNX.4.53.0404221621130.610@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0404221621130.610@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2004 at 04:25:19PM -0400, Richard B. Johnson wrote:
> On Thu, 22 Apr 2004, Willy Tarreau wrote:
> 
> > Richard,
> >
> > you are confusing several thinks, stateful vs stateless protocols. A ping
> > doesn't need a session on the remote host to be interpreted. A TCP segment
> > whose flags don't show a SYN need a session to be interpreted. Please note
> > that I'm not arguing that you won't crash a linux box with an RST addressed
> > to a broadcast address, I'm saying that there's absolutely no reason why
> > this should reset all connections, as you proposed it. Someone would have
> > had to code this explicitly, it cannot be a simple side effect.
> >
> > Imagine that each packet which enters the system is presented to a hash
> > table containing the sessions, and that its session is looked for into
> > this hash table. You agree that in such code, there's no reason to find
> > anything that runs through all sessions and kill everyone, since this
> > code has no use there, and has no reason to be implemented on purpose !
> >
> > Look at functions such as tcp_v4_lookup() in net/ipv4/tcp_ipv4.c for
> > example. When it reaches tcp_v4_lookup_established(), you find this :
> >
> >         for(sk = head->chain; sk; sk = sk->next) {
> >                 if(TCP_IPV4_MATCH(sk, acookie, saddr, daddr, ports, dif))
> >                         goto hit; /* You sunk my battleship! */
> >         }
> >
> > You cannot match more than once.
> 
> [SNIPPED...]
> 
> So you are sure an attacker will fire only one bullet?

I don't see where you want to go. An attacker will have to fire at least
one "bullet" per port, per sequence number block and per timestamp if any.
That's the basis of the protocol. You were asking if *one* packet sent
to a broadcast address could reset *every* TCP connections, David showed
you that broadcasts were dropped, and I showed you that you need as many
packets as possible combinations to shoot all connections. That's all.

And BTW, do you think that such a "serious" vulnerability wouldn't have
been demonstrated on live sites if it was so obvious ? Don't worry, we
still have a few years in front of us before home networks are fast enough
to scan such large ranges in a matter of days.

Cheers,
Willy

