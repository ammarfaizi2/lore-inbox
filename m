Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269748AbUJGJCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269748AbUJGJCg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267354AbUJGJCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:02:36 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:20142 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S269759AbUJGJBe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:01:34 -0400
Date: Thu, 7 Oct 2004 01:59:12 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: Simon.Derr@bull.net, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and
 memory placement
Message-Id: <20041007015912.3da745a9.pj@sgi.com>
In-Reply-To: <1097104367.4907.91.camel@arrakis>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040805190500.3c8fb361.pj@sgi.com>
	<247790000.1091762644@[10.10.2.4]>
	<200408061730.06175.efocht@hpce.nec.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<1097015619.4065.61.camel@arrakis>
	<20041005200124.415f39d1.pj@sgi.com>
	<1097104367.4907.91.camel@arrakis>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew wrote:
> > Perhaps these flags should be called:
> > 	mems_exclusive_precursor
> > 	cpus_exclusive_precursor
> > ;).
> 
> Ok...  So if we could offer the 'real' exclusion that the PBS and LSF
> workload managers offer directly, would that suffice?  Meaning, could we
> make PBS and LSF work on top of in-kernel mechanisms that offer 'real'
> exclusion.  'Real' exclusion defined as isolated groups of CPUs and
> memory that the kernel can guarantee will not run other processes?  That
> way we can get the job done without having to rely on these external
> workload managers, and be able to offer this dynamic partitioning to all
> users.  Thoughts?


I agree entirely.  Before when I was being a penny pincher about
how much went in the kernel, it might have made sense to have
the mems_exclusive and cpus_exclusive precursor flags.

But now that we have demonstrated a bone fide need for a really
really exclusive cpuset, it was silly of me to consider offering:

> > 	mems_exclusive_precursor
> > 	cpus_exclusive_precursor
> >     really_really_exclusive

These multiple flavors just confuse and annoy.

You're right.  Just one flag option, for the really exclusive cpuset,
is required here.

A different scheduler domain (whether same scheduler with awareness of
the boundaries, or something more substantially distinct) may only be
attached to a cpuset if it is exclusive.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
