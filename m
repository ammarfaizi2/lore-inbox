Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312397AbSC3Vna>; Sat, 30 Mar 2002 16:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312456AbSC3VnU>; Sat, 30 Mar 2002 16:43:20 -0500
Received: from gumby.it.wmich.edu ([141.218.23.21]:2513 "EHLO
	gumby.it.wmich.edu") by vger.kernel.org with ESMTP
	id <S312397AbSC3VnN>; Sat, 30 Mar 2002 16:43:13 -0500
Subject: Re: Linux 2.4.19-pre5
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Randy Hron <rwhron@earthlink.net>
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <E16rQNU-00007G-00@gull.prod.itd.earthlink.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 30 Mar 2002 16:42:52 -0500
Message-Id: <1017524577.444.61.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-03-30 at 16:33, Randy Hron wrote:
> > > run.  More importantly, read_latency2 drops max latency
> > > with 32-128 tiobench threads from 300-600+ seconds
> > > down to 2-8 seconds.  (2.4.19-pre5 is still unfair
> > > to some read requests when threads >= 32)
> > 
> > These numbers are surprising.  The get_request starvation
> > change should have smoothed things out.   Perhaps there's
> > something else going on, or it's not working right.  If
> > you could please send me all the details to reproduce this
> > I'll take a look.  Thanks.
> 
> There was an improvement (reduction) in max latency
> during sequential _writes after get_request starvation 
> went in.  Tiobench didn't show an improvement for seq _read 
> max latency though.  read_latency2 makes the huge difference.
> 
> The sequential read max latency walls for various trees looks like:
> tree		# of threads
> rmap		128
> ac		128
> marcelo		32
> linus		64
> 2.5-akpm-everything	>128 
> 2.4 read latency2	>128
> 
> I.E. tiobench with threads > the numbers above would probably
> give the impression the machine was locked up or frozen if your
> read request was the unlucky max.  The average latencies are 
> generally reasonable.  It's the max, and % of high latency

Is that to say an ac branch (which uses rmap) can do the 128 but is
non-responsive?   I sent a couple mails of my own preliminary runs and
the feel i got when running the test was absolutely no effect on
responsiveness even as the load hit 110.  Of course this is with riel's
preempt patch for 2.4.19-pre4-ac3.  I guess I'll try with threads = 256
just to see if this frozen feeling occurs in preempt kernels as well. 
You dont seem to test them anywhere on your own site.  

