Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269631AbUJFXTM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269631AbUJFXTM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 19:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269603AbUJFXQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 19:16:47 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:62128 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269620AbUJFXOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 19:14:00 -0400
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Paul Jackson <pj@sgi.com>
Cc: Simon.Derr@bull.net, "Martin J. Bligh" <mbligh@aracnet.com>,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, LSE Tech <lse-tech@lists.sourceforge.net>,
       hch@infradead.org, steiner@sgi.com, Jesse Barnes <jbarnes@sgi.com>,
       sylvain.jeaugey@bull.net, djh@sgi.com,
       LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       sivanich@sgi.com
In-Reply-To: <20041005200124.415f39d1.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	 <20040805190500.3c8fb361.pj@sgi.com> <247790000.1091762644@[10.10.2.4]>
	 <200408061730.06175.efocht@hpce.nec.com>
	 <20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com>
	 <20041001164118.45b75e17.akpm@osdl.org>
	 <20041001230644.39b551af.pj@sgi.com> <20041002145521.GA8868@in.ibm.com>
	 <415ED3E3.6050008@watson.ibm.com> <415F37F9.6060002@bigpond.net.au>
	 <821020000.1096814205@[10.10.2.4]> <20041003083936.7c844ec3.pj@sgi.com>
	 <834330000.1096847619@[10.10.2.4]> <835810000.1096848156@[10.10.2.4]>
	 <20041003175309.6b02b5c6.pj@sgi.com> <838090000.1096862199@[10.10.2.4]>
	 <20041003212452.1a15a49a.pj@sgi.com> <843670000.1096902220@[10.10.2.4]>
	 <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	 <1097015619.4065.61.camel@arrakis>  <20041005200124.415f39d1.pj@sgi.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1097104367.4907.91.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 06 Oct 2004 16:12:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 20:01, Paul Jackson wrote:
> Matthew writes:
> > 
> > If that's all 'exclusive' means then 'exclusive' is a poor choice of
> > terminology.  'Exclusive' sounds like it would exclude all tasks it is
> > possible to exclude from running there (ie: with the exception of
> > certain necessary kernel threads).
> 
> I suspect that my aggressive pushing of mechanism _out_ of the
> kernel has obscured what's going on here.
> 
> The real 'exclusive' use of some set of CPUs and Memory Nodes
> is provided by the workload managers, PBS and LSF.  They fabricate
> this out of the kernel cpuset 'exclusive' property, plus other
> optional user level stuff.
> 
> For instance, one doesn't have to follow Simon's example, and leave the
> classic Unix daemon load running in a cpuset that share resources with
> all other cpusets.  Instead, one can coral this classic Unix load into a
> bootcpuset, administratively, at system boot.  All the kernel mechanisms
> required to support this exist in my current cpuset patch in Andrew's
> tree.
> 
> The kernel cpuset 'mems_exclusive' and 'cpus_exclusive' flags are like
> vitamin precursors.  They are elements out of which the real nutrative
> compound is constructed.  Occassionally, as in Simon's configuration,
> they are actually sufficient in their current state.  Usually, more
> processing is required.  This processing just isn't visible to the
> kernel code.
> 
> Perhaps these flags should be called:
> 	mems_exclusive_precursor
> 	cpus_exclusive_precursor
> ;).

Ok...  So if we could offer the 'real' exclusion that the PBS and LSF
workload managers offer directly, would that suffice?  Meaning, could we
make PBS and LSF work on top of in-kernel mechanisms that offer 'real'
exclusion.  'Real' exclusion defined as isolated groups of CPUs and
memory that the kernel can guarantee will not run other processes?  That
way we can get the job done without having to rely on these external
workload managers, and be able to offer this dynamic partitioning to all
users.  Thoughts?

-Matt

