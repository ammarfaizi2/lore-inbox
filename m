Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287615AbSAIPfG>; Wed, 9 Jan 2002 10:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287657AbSAIPe5>; Wed, 9 Jan 2002 10:34:57 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:52456 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S287615AbSAIPel>;
	Wed, 9 Jan 2002 10:34:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Rene Rebe <rene.rebe@gmx.net>
Subject: Re: [patch] O(1) scheduler, -D1, 2.5.2-pre9, 2.4.17
Date: Wed, 9 Jan 2002 07:34:39 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.40.0201082057560.936-100000@blue1.dev.mcafeelabs.com> <Pine.LNX.4.33.0201091154440.2276-100000@localhost.localdomain> <20020109.121916.424252478.rene.rebe@gmx.net>
In-Reply-To: <20020109.121916.424252478.rene.rebe@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16OKkR-0001Km-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 9, 2002 03:19, Rene Rebe wrote:
> Could someone tell a non-kernel-hacker why this benchmark is nearly
> twice as fast when running reniced??? Shouldn't it be slower when it
> runs with lower priority (And you execute / type some commands during
> it)?

In addition for using the nice level as a priority hint, the new scheduler 
also uses it as a hint of how "CPU-bound" a process it. Negative (higher 
priority) nice levels give the process short, frequent timeslices. Positive 
priorities give the process long, infrequent time slices. On an otherwise 
(mostly) idle system, both processes will get the same amount of CPU time, 
but distributed in a different way.

In applications that really don't care about interactivity, the long time 
slice will increase their efficency greatly. In addition to having a fewer 
context switches (and therefore less context switch overhead), the longer 
time slices give them more time to warm up the cache. This has been referred 
to as "batching", as the process is executing at once what would normally 
take many shorter timeslices to complete.

So, what you're actually seeing is the reniced task not taking up more CPU 
time (it's probably actually using slightly less), just using the CPU time 
more efficently.

<worships Ingo>

-Ryan
