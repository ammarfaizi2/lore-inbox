Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278541AbRJSQrF>; Fri, 19 Oct 2001 12:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278542AbRJSQqz>; Fri, 19 Oct 2001 12:46:55 -0400
Received: from [208.129.208.52] ([208.129.208.52]:53252 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S278541AbRJSQqp>;
	Fri, 19 Oct 2001 12:46:45 -0400
Date: Fri, 19 Oct 2001 09:50:10 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Hubertus Franke <frankeh@watson.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] A try for a more fair scheduler ...
In-Reply-To: <20011019083141.A10035@watson.ibm.com>
Message-ID: <Pine.LNX.4.40.0110190942350.1424-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Oct 2001, Hubertus Franke wrote:

> Seems like a good approach. Could that be made more flexible.
> Architectures today expose cache miss numbers, which
> through simple markovian chains approximation allow a much better estimation
> of the cache footprint then inferring from time.
> Any chance to incoporate something like
> this into your cost function flexibly or is this just too <way out there> ?

I just wanted to code a solution that is compatible with all architectures
and that has the lower cost in terms of i-d/cache.
That's why i used jiffies instead of get_cycles() and time instead of perf
counters.
The bottom line is that having to choose between a process that is run for
10 ms and one that is run for 150 ms, by choosing the 150 one we have a
very good probability to pick up the one that has a greater footprint.
Coding more complex solutions will have the effect to add an extra cost
that will _probably_ vanish the better behavior given by the patch.




- Davide


