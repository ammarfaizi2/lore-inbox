Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266632AbUGKTo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266632AbUGKTo2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 15:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266639AbUGKTo2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 15:44:28 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:48272 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S266632AbUGKToZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 15:44:25 -0400
From: Daniel Phillips <phillips@istop.com>
To: sdake@mvista.com
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
Date: Sun, 11 Jul 2004 15:44:25 -0400
User-Agent: KMail/1.6.2
Cc: Daniel Phillips <phillips@redhat.com>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       Lars Marowsky-Bree <lmb@suse.de>
References: <200407050209.29268.phillips@redhat.com> <200407101657.06314.phillips@redhat.com> <1089501890.19787.33.camel@persist.az.mvista.com>
In-Reply-To: <1089501890.19787.33.camel@persist.az.mvista.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407111544.25590.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 July 2004 19:24, Steven Dake wrote:
> On Sat, 2004-07-10 at 13:57, Daniel Phillips wrote:
> > On Saturday 10 July 2004 13:59, Steven Dake wrote:
> > > overload conditions that have caused the kernel to run low on memory
> > > are a difficult problem, even for kernel components...
> > > ...I hope that helps atleast answer that some r&d is underway to solve
> > > this particular overload problem in userspace.
> >
> > I'm certain there's a solution, but until it is demonstrated and proved,
> > any userspace cluster services must be regarded with narrow squinty
> > eyes.
>
> I agree that a solution must be demonstrated and proved.
>
> There is  another option, which I regularly recommend to anyone that
> must deal with memory overload conditions.  Don't size the applications
> in such a way as to ever cause memory overload.

That, and "just add more memory" are the two common mistakes people make when 
thinking about this problem.  The kernel _normally_ runs near the low-memory 
barrier, on the theory that caching as much as possible is a good thing.

Unless you can prove that your userspace approach never deadlocks, the other 
questions don't even move the needle.  I am sure that one day somebody, maybe 
you, will demonstrate a userspace approach that is provably correct.  Until 
then, if you want your cluster to stay up and fail over properly, there's 
only one game in town.  

We need to worry about ensuring that no API _depends_ on the cluster manager 
being in-kernel, and we also need to seek out and excise any parts that could 
possibly be moved out to user space without enabling the deadlock or grossly 
messing up the kernel code.

> > > I'd invite you, or others interested in these sorts of services, to
> > > contribute that code, if interested.
> >
> > Humble suggestion: try grabbing the Red Hat (Sistina) DLM code and see
> > if you can hack it to do what you want.  Just write a kernel module
> > that exports the DLM interface to userspace in the desired form.
> >
> >    http://sources.redhat.com/cluster/dlm/
>
> I would rather avoid non-mainline kernel dependencies at this time as it
> makes adoption difficult until kernel patches are merged into upstream
> code.  Who wants to patch their kernel to try out some APIs?

Everybody working on clusters.  It's a fact of life that you have to apply 
patches to run cluster filesystems right now.  Production will be a different 
story, but (except for the stable GFS code on 2.4) nobody is close to that.

> I am doubtful these sort of kernel patches will be merged without a strong
> argument of why it absolutely must be implemented in the kernel vs all
> of the counter arguments against a kernel implementation.

True.  Do you agree that the PF_MEMALLOC argument is a strong one?

> There is one more advantage to group messaging and distributed locking
> implemented within the kernel, that I hadn't originally considered; it
> sure is sexy.

I don't think it's sexy, I think it's ugly, to tell the truth.  I am actively 
researching how to move the slow-path cluster infrastructure out of kernel, 
and I would be pleased to work together with anyone else who is interested in 
this nasty problem.

Regards,

Daniel
