Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbUCWTZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 14:25:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262754AbUCWTZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 14:25:24 -0500
Received: from fire.osdl.org ([65.172.181.4]:59834 "EHLO fire-2.osdl.org")
	by vger.kernel.org with ESMTP id S262729AbUCWTZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 14:25:22 -0500
Subject: Re: 2.6.4-mm2
From: Mary Edie Meredith <maryedie@osdl.org>
Reply-To: maryedie@osdl.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <20040322162729.2f2ddbe4.akpm@osdl.org>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	 <200403181737.i2IHbCE09261@mail.osdl.org>
	 <20040318100615.7f2943ea.akpm@osdl.org> <20040318192707.GV22234@suse.de>
	 <20040318191530.34e04cb2.akpm@osdl.org>
	 <20040318194150.4de65049.akpm@osdl.org>
	 <20040319183906.I8594@osdlab.pdx.osdl.net>
	 <1079975940.23641.580.camel@localhost>
	 <20040322162729.2f2ddbe4.akpm@osdl.org>
Content-Type: text/plain
Organization: OSDL
Message-Id: <1080069704.10668.122.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Mar 2004 11:21:44 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-22 at 16:27, Andrew Morton wrote:
> Mary Edie Meredith <maryedie@osdl.org> wrote:
> >
> > [was "Poor DBT-3 pgsql 8way numbers on recent 2.6 mm kernels" on
> > linux-mm]
> > 
> > Andrew,
> > 
> > This same patch (02) applied in STP (plm 2780) when run against
> > dbt3-pgsql DSS workload displays the performance problem with the
> > throughput numbers that I reported on linux-mm on our 8way systems,
> > where the previous patch (plm 2777 -01) does not.  
> > 
> > Here is the data (patches applied to 2.6.5-rc1)
> > 
> > PLM.....CPUs.Runid..Thruput Metric (bigger is better)
> > 2777(01)  8  290298  138.22  (base  )
> > 2779(02)  8  290304  88.57   (-35.9%)
> 
> 36% regression due to the CPU scheduler changes?  ow.
> 
> And that machine is a PIII, so presumably the setting of CONFIG_SCHED_SMT
> makes no difference.
> 
> >From a quick look at the material you have there it appears that this
> workload also is very I/O bound.  It's a little surprising that the CPU
> scheduler could make so much difference.
I'm not sure why you think this is IO bound. For 
the throughput phase of the test (from which the 
metric above is taken) there is very little physical 
IO except at the start when the updates occur.  They
finish in a few minutes, after which there is very
little.

http://khack.osdl.org/stp/290304/results/plot/thuput.vmstat_io.png
http://khack.osdl.org/stp/290304/results/plot/thuput.vmstat.txt
Perhaps you were looking at the start or at some other
part of the test?

The power test (single stream phase) does not display 
any performance hit at all compared to the baseline.
The throughput test runs eight streams (processes)
and does display the problem.  Furthermore the problem
is worse on 8 ways than on 4 ways.  It seems reasonable 
to me that this could be due to a task schedule issue.

Am I missing something?

> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Mary Edie Meredith 
maryedie@osdl.org
503-626-2455 x42
Open Source Development Labs

