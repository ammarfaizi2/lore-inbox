Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263014AbTLTCzV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 21:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263650AbTLTCzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 21:55:21 -0500
Received: from c211-28-147-198.thoms1.vic.optusnet.com.au ([211.28.147.198]:5090
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263014AbTLTCzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 21:55:15 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <piggin@cyberone.com.au>,
       Christian Meder <chris@onestepahead.de>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Date: Sat, 20 Dec 2003 13:55:08 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
References: <1071864709.1044.172.camel@localhost> <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au>
In-Reply-To: <3FE3B61C.4070204@cyberone.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312201355.08116.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Dec 2003 13:38, Nick Piggin wrote:
> Christian Meder wrote:
> >On Sat, 2003-12-20 at 02:26, Nick Piggin wrote:
> >>Christian Meder wrote:
> >>>On Sat, 2003-12-20 at 01:48, Nick Piggin wrote:
> >>>>Sounds reasonable. Maybe its large interrupt or scheduling latency
> >>>>caused somewhere else. Does disk activity alone cause a problem?
> >>>>find / -type f | xargs cat > /dev/null
> >>>>how about
> >>>>dd if=/dev/zero of=./deleteme bs=1M count=256
> >>>
> >>>Ok. I've attached the logs from a run with a call with only an
> >>>additional dd. The quality was almost undisturbed only very slightly
> >>>worse than the unloaded case.

Since so many things have actually changed it's going to be hard to extract 
what role the cpu scheduler has in this setting, but lets do our best.

Is there a reason you're running gnomemeeting niced -10? It is hardly using 
any cpu and the problem is actually audio in your case, not the cpu 
gnomemeeting is getting. Running dependant things (gnomemeeting, audio 
server, gnome etc) at different nice levels is not a great idea as it can 
lead to priority inversion scenarios if those apps aren't coded carefully. 

What happens if you run gnomemeeting at nice 0?

How is your dma working on your disks?

What happens if you don't use an audio server (I'm not sure what the audio 
server is in gnome); or if you're not using one what happens when you do?

Renice the audio server instead?

You've already tried different audio drivers right?

Nice the compile instead of -nicing the other stuff.

Try the minor interactivity fix I posted only yesterday for different nice 
level latencies:
http://ck.kolivas.org/patches/2.6/2.6.0/patch-2.6.0-O21int

Is your network responsible and the audio unrelated? Some have reported 
strange problems with ppp or certain network card drivers?

As you see it's not a straight forward problem but there's some things for you 
to get your teeth stuck into. As it stands the cpu scheduler from your top 
output appears to be giving appropriate priorities to the different factors 
in your equation.

Con

