Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268199AbUJDOUd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268199AbUJDOUd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:20:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268184AbUJDOSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:18:16 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:37062 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S268168AbUJDORO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:17:14 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Mon, 4 Oct 2004 16:15:24 +0200
User-Agent: KMail/1.6.2
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       mbligh@aracnet.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200410032221.26683.efocht@hpce.nec.com> <416156E8.7060708@watson.ibm.com>
In-Reply-To: <416156E8.7060708@watson.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410041615.24384.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 04 October 2004 15:58, Hubertus Franke wrote:
> Erich Focht wrote:
> > Can CKRM (as it is now) fulfil the requirements?
> > 
> > I don't think so. CKRM gives me to some extent the confidence that I
> > will really use the part of the machine for which I paid, say 50%. But
> > it doesn't care about the structure of the machine. CKRM tries giving
> > a user as much of the machine as possible, at least the amount he paid
> > for. For example: When I come in with my job the machine might be
> > already running another job who's user also paid for 50% but was the
> > only user and got 100% of the machine (say some Java application with
> > enough threads...). This job maybe has filled up most of the memory
> > and uses all CPUs. CKRM will take care of getting me cycles (maybe
> > exclusively on 50% of the CPUs and will treat my job preferrentially
> > when allocating memory, but will not care about the placement of the
> > CPUs and the memory. Neither will it care whether the previously
> > running job is still using my memory blocks and reducing my bandwith
> > to them. So I get 50% of the cycles and the memory but these will be
> > BAD CYCLES and BAD MEMORY. My job will run slower than possible and a
> > second run will be again different. Don't misunderstand me: CKRM in
> > its current state is great for different things and running it inside
> > a cpuset sounds like a good thing to do.
> 
> You forget that CKRM does NOT violate the constraints set forward by 
> cpu_allowed masks. So most of your drawbacks described above are simply 
> not true.

I explicitely implied that I only use CKRM. This means all processes
have the trivial cpus_allowed mask and are allowed to go wherever they
want. With this assumption (and my understanding of CKRM) the
drawbacks will be there.

Cpusets is my method of choice (for the future) for setting the
cpus_allowed mask (and the memories_allowed). If I use cpusets AND
CKRM together all is fine, of course.

> I am certainly not stipulating that cpusets can replace share based 
> scheduling or vice versa.
> 
> What remains to be discussed is whether
> In order to allow CKRM scheduling within a cpuset here are a few 
> questions to be answered:
> (a) is it a guarantee/property that cpusets at with the same
>      parent cpuset do not overlap ?

Right now it isn't AFAIK. Paul, if all cpusets on the same level are
disjunct this certainly simplifies life. Would this be a too strong
limitation for you? We could live with it.

> (b) can we enforce that a certain task class is limited to a cpuset
>      and its subsets.

That is intended, yes. A task escaping from its set would be a
security (or denial of service) risk.

Regards,
Erich

