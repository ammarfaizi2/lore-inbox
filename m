Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1766643AbWJUSXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766643AbWJUSXU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 14:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766650AbWJUSXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 14:23:20 -0400
Received: from smtp-out.google.com ([216.239.33.17]:43993 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1766644AbWJUSXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 14:23:19 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=T+kbiZh23cIKifoMls8FqRjJip3O+MNIYduQz+hy2IsfyKzvDQxk5KS4vdWWhmPS2
	BWEO0TeJvh5tKWkQNzmww==
Message-ID: <6599ad830610211123i35d2e132y8ef1e0f612b94877@mail.gmail.com>
Date: Sat, 21 Oct 2006 11:23:06 -0700
From: "Paul Menage" <menage@google.com>
To: "Martin Bligh" <mbligh@google.com>
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Cc: "Nick Piggin" <nickpiggin@yahoo.com.au>, "Paul Jackson" <pj@sgi.com>,
       akpm@osdl.org, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       dino@in.ibm.com, rohitseth@google.com, holt@sgi.com,
       dipankar@in.ibm.com, suresh.b.siddha@intel.com
In-Reply-To: <4537D6E8.8020501@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	 <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com>
	 <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/06, Martin Bligh <mbligh@google.com> wrote:
>
> > I don't know of anyone else using cpusets, but I'd be interested to know.
>
> We (Google) are planning to use it to do some partitioning, albeit on
> much smaller machines. I'd really like to NOT use cpus_allowed from
> previous experience - if we can get it to to partition using separated
> sched domains, that would be much better.

Actually, what we'd really like is to be able to set cpus_allowed in
arbitrary ways (we're already doing this via sched_setaffinity() -
doing it via cpusets would just be an optimization when changing cpu
masks) and have the scheduler automatically do balancing efficiently.
In some cases sched domains might be appropriate, but in most of the
cases we have today, we have a job that's running with a CPU reserved
for itself but also has access to a "public" CPU, and some CPUs are
not public, but shared amongst a set of jobs. I'm not very familiar
with the sched domains code but I guess it doesn't handle overlapping
cpu masks very well?

Paul
