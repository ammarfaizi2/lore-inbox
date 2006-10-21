Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992843AbWJUHYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992843AbWJUHYQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 03:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992895AbWJUHYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 03:24:16 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:21451 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S2992843AbWJUHYO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 03:24:14 -0400
Date: Sat, 21 Oct 2006 00:24:00 -0700
From: Paul Jackson <pj@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: akpm@osdl.org, mbligh@google.com, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, dino@in.ibm.com, rohitseth@google.com,
       holt@sgi.com, dipankar@in.ibm.com, suresh.b.siddha@intel.com,
       clameter@sgi.com
Subject: Re: [RFC] cpuset: add interface to isolated cpus
Message-Id: <20061021002400.fb25f327.pj@sgi.com>
In-Reply-To: <4539BAB2.3010501@yahoo.com.au>
References: <20061019092607.17547.68979.sendpatchset@sam.engr.sgi.com>
	<453750AA.1050803@yahoo.com.au>
	<20061019105515.080675fb.pj@sgi.com>
	<4537BEDA.8030005@yahoo.com.au>
	<20061019115652.562054ca.pj@sgi.com>
	<4537CC1E.60204@yahoo.com.au>
	<20061019203744.09b8c800.pj@sgi.com>
	<453882AC.3070500@yahoo.com.au>
	<20061020130141.b5e986dd.pj@sgi.com>
	<4539BAB2.3010501@yahoo.com.au>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you always have other domains overlapping them (regardless
> that it is a parent), then what actual use does cpu_exclusive
> flag have?

Good question.  To be a tad too honest, I don't consider it to be
all that essential.

It does turn out to be a bit useful, in that you can be confident that
if you are administering the batch scheduler and it has a cpu_exclusive
cpuset covering a big chunk of your system, then no other cpuset other
than the top cpuset right above, which you administer pretty tightly,
could have anything overlapping it.  You don't have to actually look
at the cpumasks in all the parallel cpusets and cross check each one
against the batch schedulers set of cpus for overlap.

But as you can see by grep'ing in kernel/cpuset.c, it is only used
to generate a couple of error returns, for things that you can do
just fine by turning off the cpu_exclusive flag.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
