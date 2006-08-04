Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWHDFhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWHDFhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030259AbWHDFhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:37:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9092 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030265AbWHDFhQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:37:16 -0400
Date: Thu, 3 Aug 2006 22:36:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: vatsa@in.ibm.com
Cc: mingo@elte.hu, nickpiggin@yahoo.com.au, sam@vilain.net,
       linux-kernel@vger.kernel.org, dev@openvz.org, efault@gmx.de,
       balbir@in.ibm.com, sekharan@us.ibm.com, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: Re: [RFC, PATCH 0/5] Going forward with Resource Management - A cpu
 controller
Message-Id: <20060803223650.423f2e6a.akpm@osdl.org>
In-Reply-To: <20060804050753.GD27194@in.ibm.com>
References: <20060804050753.GD27194@in.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Aug 2006 10:37:53 +0530
Srivatsa Vaddagiri <vatsa@in.ibm.com> wrote:

> Resource management has been talked about quite extensively in the
> past, more recently in the context of containers. The basic requirement
> here is to provide isolation between *groups* of task wrt their use
> of various resources like CPU, Memory, I/O bandwidth, open file-descriptors etc.
> 
> Different maintainers have however expressed different opinions over the need to
> complicate the kernel to meet this need, especially since it involves core 
> kernel code like the resource schedulers. 
> 
> A BoF was hence held at OLS this year to come to a consensus on the minimum 
> requirements of a resource management solution for Linux kernel. Some notes 
> taken at the BoF are posted here:
> 
> 	http://www.uwsg.indiana.edu/hypermail/linux/kernel/0607.3/0896.html
> 
> An important consensus point of the BoF seemed to be "focus on real 
> controllers more, preferably memory first, using some simple interface
> and task grouping mechanism".

ug, I didn't know this.  Had I been there (sorry) I'd have disagreed with
this whole strategy.

I thought the most recently posted CKRM core was a fine piece of code.  It
provides the machinery for grouping tasks together and the machinery for
establishing and viewing those groupings via configfs, and other such
common functionality.  My 20-minute impression was that this code was an
easy merge and it was just awaiting some useful controllers to come along.

And now we've dumped the good infrastructure and instead we've contentrated
on the controller, wired up via some imaginative ab^H^Hreuse of the cpuset
layer.

I wonder how many of the consensus-makers were familiar with the
contemporary CKRM core?

> In going forward, following points will need to be addressed:
> 
> 	- Grouping and interface
> 		- What mechanism to use for grouping tasks and
> 		  for specifying task-group resource usage limits?

ckrm ;)

> 	- Design of individual resource controllers like memory and cpu

Right.  We won't be controlling memory, numtasks, disk, network etc
controllers via cpusets, will we?


> This patch series is an attempt to take forward the design discussion of a
> CPU controller.

That's good.  The controllers are the sticking point.  Most especially the
memory controller.

> For simplicity and convenience, cpuset has been chosen as the means to group 
> tasks here, primarily because cpuset already exists in the kernel and also 
> perhaps resource container definition should be unique only inside a cpuset.
> 

Correct me if I'm wrong, but a cpuset isn't the appropriate machinery to be
using to group tasks.

And if this whole resource-control effort is to end up being successful, it
should have as core infrastructure a flexible, appropriate and uniform way
of grouping tasks together and of getting data into and out of those
aggregates.  We already have that, don't we?



