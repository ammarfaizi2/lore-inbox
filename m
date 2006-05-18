Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWERJPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWERJPj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWERJPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:15:39 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:46541 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750983AbWERJPi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:15:38 -0400
Subject: Re: rt20 scheduling latency testcase and failure data
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: Darren Hart <dvhltc@us.ibm.com>, Lee Revell <rlrevell@joe-job.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Thomas Gleixner <tglx@linutronix.de>, Mike Galbraith <efault@gmx.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20060518085640.GA5171@elte.hu>
References: <200605121924.53917.dvhltc@us.ibm.com>
	 <200605131601.31880.dvhltc@us.ibm.com> <20060515081341.GB24523@elte.hu>
	 <200605151830.23544.dvhltc@us.ibm.com>
	 <1147941862.4996.15.camel@frecb000686> <20060518084722.GA3343@elte.hu>
	 <1147942687.4996.28.camel@frecb000686>  <20060518085640.GA5171@elte.hu>
Date: Thu, 18 May 2006 11:18:09 +0200
Message-Id: <1147943890.4996.31.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 11:16:54,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 18/05/2006 11:18:47,
	Serialize complete at 18/05/2006 11:18:47
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 10:56 +0200, Ingo Molnar wrote:
> * Sébastien Dugué <sebastien.dugue@bull.net> wrote:
> 
> > > thanks for tracking this down. FYI, the latency of stopping the trace is 
> > > that expensive because we are copying large amounts of trace data 
> > > around, to ensure that /proc/latency_trace is always consistent and is 
> > > updated atomically, and to make sure that we can update the trace from 
> > > interrupt contexts too - without /proc/latency_trace accesses blocking 
> > > them. The latency of stopping the trace is hidden from the tracer itself 
> > > - but it cannot prevent indirect effects such as your app from missing 
> > > periods, if the periods are in the 5msec range.
> > > 
> > 
> >   Thanks for the explanation, will have to look deeper into the code 
> > to understand how it works though.
> 
> there's another complexity on SMP: if trace_all_cpus is set then the 
> per-cpu trace buffers are sorted chronologically as well while the 
> copying into the current-max-trace-buffer, to produce easier to read 
> latency_trace output.
> 
  Well, that's not the case here, but thanks for the info.

  Sébastien.

