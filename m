Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292282AbSB1Ik6>; Thu, 28 Feb 2002 03:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSB1Iio>; Thu, 28 Feb 2002 03:38:44 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:47047 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S293184AbSB1Igi>;
	Thu, 28 Feb 2002 03:36:38 -0500
Date: Thu, 28 Feb 2002 14:01:17 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Message-ID: <20020228140117.L12590@in.ibm.com>
In-Reply-To: <10460000.1014833979@w-hlinder.des>, <10460000.1014833979@w-hlinder.des> <67850000.1014834875@flay> <3C7D374B.4621F9BA@zip.com.au> <19890000.1014839877@w-hlinder.des>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <19890000.1014839877@w-hlinder.des>; from hannal@us.ibm.com on Wed, Feb 27, 2002 at 11:57:57AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 11:57:57AM -0800, Hanna Linder wrote:
> 
> > 
> > I have a concern about the lockmeter results.  Lockmeter appears
> > to be measuring lock frequency and hold times and contention.  But
> > is it measuring the cost of the cacheline transfers?   
> 
> 	This has come up a few times on lse-tech. Lockmeter doesnt
> measure cacheline hits/misses/bouncing. However, someone said
> kernprof could be used to access performance registers on the Pentium
> chip to get this info. I don't know anyone who has tried that though.

I have tried using kernprof; What kernprof can do is list 
out the routine-wise performance event counts for a given workload.

I use it with benchmark runs using a script to start and stop profiling
and run the tests in between
something like

kernprof -r
kernprof -b -c all -d pmc -a 0x0020024 
urtesttobeexecuted
kernprof -e

Event above "0x0020024" is L2_LINES_IN for P6 family

I've used this to measure cache effects with smp friendly counters,
But for lockmetering, this would not be as good as having cache event 
measurements built into lockmeter .......

-Kiran
