Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWITRii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWITRii (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 13:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWITRih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 13:38:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15069 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932147AbWITRig (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 13:38:36 -0400
Date: Wed, 20 Sep 2006 10:38:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org, pj@sgi.com,
       npiggin@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158773208.8574.53.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609201035240.31464@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com> 
 <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
 <1158773208.8574.53.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006, Rohit Seth wrote:

> cpusets provides cpu and memory NODES binding to tasks.  And I think it
> works great for NUMA machines where you have different nodes with its
> own set of CPUs and memory.  The number of those nodes on a commodity HW
> is still 1.  And they can have 8-16 CPUs and in access of 100G of
> memory.  You may start using fake nodes (untested territory) to

See linux-mm. We just went through a series of tests and functionality 
wise it worked just fine.

> translate a single node machine into N different nodes.  But am not sure
> if this number of nodes can change dynamically on the running machine or
> a reboot is required to change the number of nodes.

This is commonly discussed under the subject of memory hotplug.

> Though when you want to have in access of 100 containers then the cpuset
> function starts popping up on the oprofile chart very aggressively.  And
> this is the cost that shouldn't have to be paid (particularly) for a
> single node machine.

Yes this is a new way of using cpusets but it works and we could fix the 
scalability issues rather than adding new subsystems.

> And what happens when you want to have cpuset with memory that needs to
> be even further fine grained than each node.

New node?

> Containers also provide a mechanism to move files to containers. Any
> further references to this file come from the same container rather than
> the container which is bringing in a new page.

Hmmmm... Thats is interesting.

> In future there will be more handlers like CPU and disk that can be
> easily embeded into this container infrastructure.

I think we should have one container mechanism instead of multiple. Maybe 
merge the two? The cpuset functionality is well established and working 
right.

