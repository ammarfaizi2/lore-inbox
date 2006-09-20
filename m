Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWITR1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWITR1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWITR1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:27:06 -0400
Received: from smtp-out.google.com ([216.239.45.12]:31160 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932090AbWITR1D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:27:03 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=sBymhg2rs2b0uan6WAZA/X0eweQUJfjE2HvyPcI9q+LoqhhCb5nBUzRpec/g3QS54
	WVRVCmxV31aX36eBpkG4w==
Subject: Re: [patch00/05]: Containers(V2)- Introduction
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Christoph Lameter <clameter@sgi.com>
Cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org, pj@sgi.com,
       npiggin@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
	 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: Google Inc
Date: Wed, 20 Sep 2006 10:26:47 -0700
Message-Id: <1158773208.8574.53.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 09:25 -0700, Christoph Lameter wrote:
> On Tue, 19 Sep 2006, Rohit Seth wrote:
> 
> > For example, a user can run a batch job like backup inside containers.
> > This job if run unconstrained could step over most of the memory present
> > in system thus impacting other workloads running on the system at that
> > time.  But when the same job is run inside containers then the backup
> > job is run within container limits.
> 
> I just saw this for the first time since linux-mm was not cced. We have 
> discussed a similar mechanism on linux-mm.
> 
> We already have such a functionality in the kernel its called a cpuset. A 
> container could be created simply by creating a fake node that then 
> allows constraining applications to this node. We already track the 
> types of pages per node. The statistics you want are already existing. 
> See /proc/zoneinfo and /sys/devices/system/node/node*/*.
> 
> > We use the term container to indicate a structure against which we track
> > and charge utilization of system resources like memory, tasks etc for a
> > workload. Containers will allow system admins to customize the
> > underlying platform for different applications based on their
> > performance and HW resource utilization needs.  Containers contain
> > enough infrastructure to allow optimal resource utilization without
> > bogging down rest of the kernel.  A system admin should be able to
> > create, manage and free containers easily.
> 
> Right thats what cpusets do and it has been working fine for years. Maybe 
> Paul can help you if you find anything missing in the existing means to 
> control resources.

cpusets provides cpu and memory NODES binding to tasks.  And I think it
works great for NUMA machines where you have different nodes with its
own set of CPUs and memory.  The number of those nodes on a commodity HW
is still 1.  And they can have 8-16 CPUs and in access of 100G of
memory.  You may start using fake nodes (untested territory) to
translate a single node machine into N different nodes.  But am not sure
if this number of nodes can change dynamically on the running machine or
a reboot is required to change the number of nodes.

Though when you want to have in access of 100 containers then the cpuset
function starts popping up on the oprofile chart very aggressively.  And
this is the cost that shouldn't have to be paid (particularly) for a
single node machine.

And what happens when you want to have cpuset with memory that needs to
be even further fine grained than each node.

Containers also provide a mechanism to move files to containers. Any
further references to this file come from the same container rather than
the container which is bringing in a new page.

In future there will be more handlers like CPU and disk that can be
easily embeded into this container infrastructure.

-rohit

