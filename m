Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319024AbSHMUQe>; Tue, 13 Aug 2002 16:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319025AbSHMUQe>; Tue, 13 Aug 2002 16:16:34 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62214 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319024AbSHMUQd>; Tue, 13 Aug 2002 16:16:33 -0400
Date: Tue, 13 Aug 2002 13:22:51 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Matt Dobson <colpatch@us.ibm.com>
Subject: Re: [PATCH] NUMA-Q disable irqbalance
In-Reply-To: <2012000000.1029269043@flay>
Message-ID: <Pine.LNX.4.44.0208131320280.1260-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Martin J. Bligh wrote:
> 
> Right, accepted. But if it's good for P4, and bad for P3 (at least for some 
> workloads), surely this leads to the conclusion that it should be a config 
> option (probably defaulting to being on)? If you can see another way to
> solve the conundrum ....

But this is exactly the kinds of cases that config options do _not_ work 
well for.

There are tons of reasons to run the same kernel on a multitude of 
machines, even ignoring the issue of things like installers etc. 

We had this CONFIG_xxxx disease when it came to SSE, we had it when it 
came to TSC, etc. And in every case it ended up being bad, simply because 
it's not the right interface for _users_. 

So this is why I think the IRQ balance code has to be there, regardless, 
and then it gets turned on dynamically for when it is needed (or turned 
off when it hurts, whatever). But it should _not_ be a CONFIG option.

		Linus

