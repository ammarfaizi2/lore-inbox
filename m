Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281831AbRK1CcR>; Tue, 27 Nov 2001 21:32:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281846AbRK1CcH>; Tue, 27 Nov 2001 21:32:07 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:785 "EHLO vasquez.zip.com.au")
	by vger.kernel.org with ESMTP id <S281831AbRK1Cbw>;
	Tue, 27 Nov 2001 21:31:52 -0500
Message-ID: <3C044C5F.237E0901@zip.com.au>
Date: Tue, 27 Nov 2001 18:30:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: J Sloan <jjs@pobox.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: heads-up: preempt kernel and tux NO-GO
In-Reply-To: <3C043B11.2FA17A19@pobox.com> <Pine.LNX.4.40.0111272007070.9338-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> On Tue, 27 Nov 2001, J Sloan wrote:
> 
> > I have been looking into the tux2 webserver -
> > Man, what a thing of beauty. A web benchmark
> > that sends the load on the web server to 150
> > when running apache results in a load average
> > of  maybe 2 when running tux, and much faster
> > results to boot - anyway, I digress....
> 
> Loadavg isn't much of a measure here, it's a measure of the length of the
> runnable queue. If you've only got two processes because your server has a
> thread per processor, then yes, you'll see lower loadavg, but not lower
> load. A real measure would look at idle percentage and throughput.

Even idle percentage is quite misleading.  Lots of interrupt
processing gets credited to the idle task and you don't see
it at all with normal accounting tools.

The `subtractive' approach is more accurate.  See how much
processing capacity is left behind when all the foreground
task and interrupt processing is complete.

Grab http://www.zip.com.au/~akpm/linux/zc.tar.gz
Type make
run ./cyclesoak -C
run ./cyclesoak

easy.
