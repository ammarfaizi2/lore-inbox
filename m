Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266768AbUJFDEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266768AbUJFDEN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 23:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266775AbUJFDEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 23:04:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40624 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266768AbUJFDEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 23:04:07 -0400
Date: Tue, 5 Oct 2004 20:01:24 -0700
From: Paul Jackson <pj@sgi.com>
To: colpatch@us.ibm.com
Cc: Simon.Derr@bull.net, mbligh@aracnet.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041005200124.415f39d1.pj@sgi.com>
In-Reply-To: <1097015619.4065.61.camel@arrakis>
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
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew writes:
> 
> If that's all 'exclusive' means then 'exclusive' is a poor choice of
> terminology.  'Exclusive' sounds like it would exclude all tasks it is
> possible to exclude from running there (ie: with the exception of
> certain necessary kernel threads).

I suspect that my aggressive pushing of mechanism _out_ of the
kernel has obscured what's going on here.

The real 'exclusive' use of some set of CPUs and Memory Nodes
is provided by the workload managers, PBS and LSF.  They fabricate
this out of the kernel cpuset 'exclusive' property, plus other
optional user level stuff.

For instance, one doesn't have to follow Simon's example, and leave the
classic Unix daemon load running in a cpuset that share resources with
all other cpusets.  Instead, one can coral this classic Unix load into a
bootcpuset, administratively, at system boot.  All the kernel mechanisms
required to support this exist in my current cpuset patch in Andrew's
tree.

The kernel cpuset 'mems_exclusive' and 'cpus_exclusive' flags are like
vitamin precursors.  They are elements out of which the real nutrative
compound is constructed.  Occassionally, as in Simon's configuration,
they are actually sufficient in their current state.  Usually, more
processing is required.  This processing just isn't visible to the
kernel code.

Perhaps these flags should be called:
	mems_exclusive_precursor
	cpus_exclusive_precursor
;).

And I also agree that there is some other, stronger, set of conditions
that the scheduler, allocator and resource manager domains need in order
to obtain sufficient isolation to stay sane.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
