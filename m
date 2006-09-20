Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWITSIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWITSIU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 14:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWITSIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 14:08:20 -0400
Received: from smtp-out.google.com ([216.239.45.12]:60358 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932179AbWITSIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 14:08:19 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=VlC0hyyWB1GHsJxPRZAr+2+iIrerCseWRGsMOKPhaI389AfYFTBC5KfSn4xb6KFRa
	R256OssRsnQdnvzpC0PpQ==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Christoph Lameter <clameter@sgi.com>
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org, pj@sgi.com,
       npiggin@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
	 <1158773208.8574.53.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 11:07:58 -0700
Message-Id: <1158775678.8574.81.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 10:38 -0700, Christoph Lameter wrote:
> On Wed, 20 Sep 2006, Rohit Seth wrote:
> 
> > cpusets provides cpu and memory NODES binding to tasks.  And I think it
> > works great for NUMA machines where you have different nodes with its
> > own set of CPUs and memory.  The number of those nodes on a commodity HW
> > is still 1.  And they can have 8-16 CPUs and in access of 100G of
> > memory.  You may start using fake nodes (untested territory) to
> 
> See linux-mm. We just went through a series of tests and functionality 
> wise it worked just fine.
> 

I thought the fake NUMA support still does not work on x86_64 baseline
kernel.  Though Paul and Andrew have patches to make it work.

> > translate a single node machine into N different nodes.  But am not sure
> > if this number of nodes can change dynamically on the running machine or
> > a reboot is required to change the number of nodes.
> 
> This is commonly discussed under the subject of memory hotplug.
> 

So now we depend on getting memory hot-plug to work for faking up these
nodes ...for the memory that is already present in the system. It just
does not sound logical.

> > Though when you want to have in access of 100 containers then the cpuset
> > function starts popping up on the oprofile chart very aggressively.  And
> > this is the cost that shouldn't have to be paid (particularly) for a
> > single node machine.
> 
> Yes this is a new way of using cpusets but it works and we could fix the 
> scalability issues rather than adding new subsystems.
> 

I think when you have 100's of zones then cost of allocating a page will
include checking cpuset validation and different zone list traversals
and checks...unless there is major surgery.

> > And what happens when you want to have cpuset with memory that needs to
> > be even further fine grained than each node.
> 
> New node?
> 

Am not clear how is this possible.  Could you or Paul please explain.

> > Containers also provide a mechanism to move files to containers. Any
> > further references to this file come from the same container rather than
> > the container which is bringing in a new page.
> 
> Hmmmm... Thats is interesting.
> 
> > In future there will be more handlers like CPU and disk that can be
> > easily embeded into this container infrastructure.
> 
> I think we should have one container mechanism instead of multiple. Maybe 
> merge the two? The cpuset functionality is well established and working 
> right.
> 

I agree that we will need one container subsystem in the long run.
Something that can easily adapt to different configurations.

-rohit

