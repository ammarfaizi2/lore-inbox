Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUHMDx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUHMDx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 23:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUHMDx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 23:53:29 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:17037 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268961AbUHMDx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 23:53:27 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <1092364786.877.1.camel@mindpipe>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu>  <20040812235116.GA27838@elte.hu>
	 <1092360317.1304.72.camel@mindpipe>  <1092360704.1304.76.camel@mindpipe>
	 <1092364786.877.1.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1092369242.2769.1.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 23:54:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 22:39, Lee Revell wrote:
> On Thu, 2004-08-12 at 21:31, Lee Revell wrote:
> > On Thu, 2004-08-12 at 21:25, Lee Revell wrote:
> > > Does not compile.  For each module I get:
> > > 
> > 
> > Never mind, stupid mistake on my part.
> > 
> 
> Argh, this is actually a fatal bug, and not a mistake on my part. 
> mcount is an unknown symbol, and make modules_install does not like
> that.
> 
> I checked Module.symvers and it is not in there, but this seems to be a
> generated file, and I have no idea why mcount does not appear.
> 

I think appending this to i386_ksyms.c fixes the problem:

#ifdef CONFIG_PREEMPT_TIMING
EXPORT_SYMBOL(mcount);
#endif

Possibly that should be CONFIG_LATENCY_TRACE.

Lee



