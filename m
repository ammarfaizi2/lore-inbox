Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269723AbRHIIG5>; Thu, 9 Aug 2001 04:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269728AbRHIIGs>; Thu, 9 Aug 2001 04:06:48 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:65260 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S269723AbRHIIGh>; Thu, 9 Aug 2001 04:06:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: Dan Hollis <goemon@anime.net>, David Ford <david@blue-labs.org>
Subject: Re: RP_FILTER runs too late
Date: Thu, 9 Aug 2001 04:05:57 -0400
X-Mailer: KMail [version 1.2]
Cc: <landley@webofficenow.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0108071206190.3304-100000@anime.net>
In-Reply-To: <Pine.LNX.4.30.0108071206190.3304-100000@anime.net>
MIME-Version: 1.0
Message-Id: <01080904055701.15175@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 August 2001 15:07, Dan Hollis wrote:
> On Tue, 7 Aug 2001, David Ford wrote:
> > I'd rather see SNAT available in pre-routing and have rp_filter run
> > against the packet before it hits the netfilter code.

I believe the reason they put SNAT at the end is that when we're about to 
send out we no longer care what the source address is, but before that we do, 
and changing it early would overwrite fields the rest of the network stack is 
still using.  (Same reason dnat happens first thing.  If we redirect it, we 
want it the rest of the network stack to use the NEW destination, and among 
other things send it out the right interface...)

Principle of "least amount of new code".  (Laziness IS one of Larry Wall's 
Seven Deadly Virtues in programmers...)

> There is one other problem with rp_filter.... rp_filter violations are
> S I L E N T. You never know when traffic is dropped because of it. Packets
> just disappear.
>
> If it generated printk's it would make it a lot easier to track down
> filtering problems.

There is a logging option, but it needs a lot of extra knobs if you ask me.  
(Logging to a file would be nice.  I suspect there's a way to do that but I 
couldn't find it circa 2.4.3, which is the last time I gave it much thought.  
Also "log if last rule triggered".  Haven't been bothered enough to break 
open the source other than for debugging purposes, though...)

> -Dan

Rob
