Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275155AbRJFOAt>; Sat, 6 Oct 2001 10:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275156AbRJFOAj>; Sat, 6 Oct 2001 10:00:39 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:32012 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275155AbRJFOA3>; Sat, 6 Oct 2001 10:00:29 -0400
Date: Sat, 6 Oct 2001 16:00:21 +0200 (CEST)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Reply-To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33L.0110050857080.4835-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.3.96.1011006154039.27272A-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > After simple bash fork bombing (about 200 forks) on my UP Celeron/96MB
> > I get quite a lot %u-allocations failed, but only when swap is turned
> > off.
> 
> > I'm not familiar with LinuxVM.. so... is it normal behaviour ? or (if not)
> > what's happening when such messages are printed my kernel ?
> 
> This is perfectly normal behaviour:
> 
> 1) on your system, you have no process limit configured for
>    yourself so you can start processes until all resources
>    (memory, file descriptors, ...) are used
> 
> 2) when all processes are used, there really is no way the
>    kernel can buy you more hardware on ebay and install it
>    on the fly ... all it can do is start failing allocations
> 
> On production systems, good admins setup per-user limits for
> the various resources so no single user is able to run the
> system into the ground.

No, it's not normal. It is long-standing bug - I think from 2.2 kernels. 
You know that without swap and with certain memory allocation strategy
(when process in a loop allocates one anonymous page, one file cache page
and again...) this bug can be triggered even when there is half memory
free.

Buddy allocator is broken - kill it. Or at least do not misuse it for
anything except kernel or driver initialization.

Mikulas

