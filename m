Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264661AbUDVUZ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264661AbUDVUZ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264663AbUDVUZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 16:25:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2688 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264661AbUDVUZZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 16:25:25 -0400
Date: Thu, 22 Apr 2004 16:25:19 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Willy Tarreau <w@w.ods.org>
cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
In-Reply-To: <20040422141848.GA6986@alpha.home.local>
Message-ID: <Pine.LNX.4.53.0404221621130.610@chaos>
References: <XFMail.20040422102359.pochini@shiny.it> <Pine.LNX.4.53.0404220734330.8039@chaos>
 <20040422131704.GA6839@alpha.home.local> <Pine.LNX.4.53.0404220929500.8745@chaos>
 <20040422141848.GA6986@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Apr 2004, Willy Tarreau wrote:

> Richard,
>
> you are confusing several thinks, stateful vs stateless protocols. A ping
> doesn't need a session on the remote host to be interpreted. A TCP segment
> whose flags don't show a SYN need a session to be interpreted. Please note
> that I'm not arguing that you won't crash a linux box with an RST addressed
> to a broadcast address, I'm saying that there's absolutely no reason why
> this should reset all connections, as you proposed it. Someone would have
> had to code this explicitly, it cannot be a simple side effect.
>
> Imagine that each packet which enters the system is presented to a hash
> table containing the sessions, and that its session is looked for into
> this hash table. You agree that in such code, there's no reason to find
> anything that runs through all sessions and kill everyone, since this
> code has no use there, and has no reason to be implemented on purpose !
>
> Look at functions such as tcp_v4_lookup() in net/ipv4/tcp_ipv4.c for
> example. When it reaches tcp_v4_lookup_established(), you find this :
>
>         for(sk = head->chain; sk; sk = sk->next) {
>                 if(TCP_IPV4_MATCH(sk, acookie, saddr, daddr, ports, dif))
>                         goto hit; /* You sunk my battleship! */
>         }
>
> You cannot match more than once.

[SNIPPED...]

So you are sure an attacker will fire only one bullet?

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


