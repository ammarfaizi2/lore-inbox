Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRJEUSi>; Fri, 5 Oct 2001 16:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271906AbRJEUS3>; Fri, 5 Oct 2001 16:18:29 -0400
Received: from smtp9.xs4all.nl ([194.109.127.135]:30457 "EHLO smtp9.xs4all.nl")
	by vger.kernel.org with ESMTP id <S271800AbRJEUSS>;
	Fri, 5 Oct 2001 16:18:18 -0400
Date: Fri, 5 Oct 2001 22:18:39 +0200 (CEST)
From: Seth Mos <knuffie@xs4all.nl>
To: Rik van Riel <riel@conectiva.com.br>
cc: Krzysztof Rusocki <kszysiu@main.braxis.co.uk>, linux-xfs@oss.sgi.com,
        linux-kernel@vger.kernel.org
Subject: Re: %u-order allocation failed
In-Reply-To: <Pine.LNX.4.33L.0110050857080.4835-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.BSI.4.10.10110052208390.303-100000@xs3.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2001, Rik van Riel wrote:

> On Fri, 5 Oct 2001, Krzysztof Rusocki wrote:
> 
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

Fair enough.

> 2) when all processes are used, there really is no way the
>    kernel can buy you more hardware on ebay and install it
>    on the fly ... all it can do is start failing allocations

So it needs a handbrake in case of a emergency? The box at work deadlocks
or crashes. I can hardly call that normal operational behaviour.

I have a Dell PE 2500 (Serverworks LE) with 2GB ram and 2 1.13Ghz
processors. If I disable HIGHMEM (4GB) support the box does not produce
these allocations messages and does not deadlock or die under the same
load or worse. What I used was a mongo.pl with 5 processes (does not
matter if the
fs is ext2 reiserfs or xfs) and the box dies within minutes/seconds after
starting the benchmark.
This happens using either 2.4.10-xfs or 2.4.11-pre3-xfs.

Using a single process hides the issue.
> On production systems, good admins setup per-user limits for
> the various resources so no single user is able to run the
> system into the ground.

The system is beafy enough to tolerate something mundane as this. It
should definitely not die.

Cheers
Seth

