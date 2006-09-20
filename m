Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWITQZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWITQZT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751738AbWITQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:25:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9938 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751629AbWITQZR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:25:17 -0400
Date: Wed, 20 Sep 2006 09:25:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: CKRM-Tech <ckrm-tech@lists.sourceforge.net>, devel@openvz.org, pj@sgi.com,
       npiggin@suse.de, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch00/05]: Containers(V2)- Introduction
In-Reply-To: <1158718568.29000.44.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609200916140.30572@schroedinger.engr.sgi.com>
References: <1158718568.29000.44.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Rohit Seth wrote:

> For example, a user can run a batch job like backup inside containers.
> This job if run unconstrained could step over most of the memory present
> in system thus impacting other workloads running on the system at that
> time.  But when the same job is run inside containers then the backup
> job is run within container limits.

I just saw this for the first time since linux-mm was not cced. We have 
discussed a similar mechanism on linux-mm.

We already have such a functionality in the kernel its called a cpuset. A 
container could be created simply by creating a fake node that then 
allows constraining applications to this node. We already track the 
types of pages per node. The statistics you want are already existing. 
See /proc/zoneinfo and /sys/devices/system/node/node*/*.

> We use the term container to indicate a structure against which we track
> and charge utilization of system resources like memory, tasks etc for a
> workload. Containers will allow system admins to customize the
> underlying platform for different applications based on their
> performance and HW resource utilization needs.  Containers contain
> enough infrastructure to allow optimal resource utilization without
> bogging down rest of the kernel.  A system admin should be able to
> create, manage and free containers easily.

Right thats what cpusets do and it has been working fine for years. Maybe 
Paul can help you if you find anything missing in the existing means to 
control resources.
