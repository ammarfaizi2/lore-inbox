Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992715AbWJTXeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992715AbWJTXeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 19:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992724AbWJTXeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 19:34:23 -0400
Received: from mga05.intel.com ([192.55.52.89]:60194 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S2992715AbWJTXeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 19:34:23 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,336,1157353200"; 
   d="scan'208"; a="6134392:sNHT17950284"
Date: Fri, 20 Oct 2006 16:14:04 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Dinakar Guniguntala <dino@in.ibm.com>, pj@sgi.com
Cc: Paul Jackson <pj@sgi.com>, nickpiggin@yahoo.com.au, mbligh@google.com,
       akpm@osdl.org, menage@google.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-ID: <20061020161403.C8481@unix-os.sc.intel.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com> <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com> <4538F34A.7070703@yahoo.com.au> <20061020120005.61239317.pj@sgi.com> <20061020203016.GA26421@in.ibm.com> <20061020144153.b40b2cc9.pj@sgi.com> <20061020223553.GA14357@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20061020223553.GA14357@in.ibm.com>; from dino@in.ibm.com on Sat, Oct 21, 2006 at 04:05:53AM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about something like use_cpus_exclusive flag in cpuset?

And whenever a child cpuset sets this use_cpus_exclusive flag, remove
those set of child cpuset cpus from parent cpuset and also from the
tasks which were running in the parent cpuset. We can probably  allow this
to happen as long as parent cpuset has atleast one cpu.

And if this use_cpus_exclusive flag is cleared in cpuset, its pool of cpus will
be returned to the parent. We can perhaps have cpus_owned inaddition to
cpus_allowed to reflect what is being exclusively used
and owned(which combines all the exclusive cpus used by the parent and children)

So effectively, a sched domain parition will get defined for each
cpuset having 'use_cpus_exclusive'.

And this is mostly inline with what anyone can expect from exclusive
cpu usage in a cpuset right?

Job manager/administrator/owner of the cpusets can set/reset the flags
depending on what cpusets/jobs are active.

Paul will this address your needs?

thanks,
suresh
