Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965120AbWHWTIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965120AbWHWTIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965118AbWHWTIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:08:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:9649 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965105AbWHWTIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:08:46 -0400
Date: Wed, 23 Aug 2006 12:08:38 -0700
From: Paul Jackson <pj@sgi.com>
To: Anton Blanchard <anton@samba.org>
Cc: akpm@osdl.org, simon.derr@bull.net, nathanl@austin.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: cpusets not cpu hotplug aware
Message-Id: <20060823120838.efbd79c2.pj@sgi.com>
In-Reply-To: <20060823145817.GA28175@krispykreme>
References: <20060821132709.GB8499@krispykreme>
	<20060821104334.2faad899.pj@sgi.com>
	<20060821192133.GC8499@krispykreme>
	<20060821140148.435d15f3.pj@sgi.com>
	<20060821215120.244f1f6f.akpm@osdl.org>
	<20060821220625.36abd1d9.pj@sgi.com>
	<20060821221433.2bc18198.akpm@osdl.org>
	<20060823145817.GA28175@krispykreme>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton wrote:
> We have a userspace visible change to the sched
> affinity API when the cpusets option is enabled.

Yup - on cpuset kernels, sched_setaffinity is constrained to CPUs in a
tasks cpuset.  Also mbind and set_mempolicy are constrained to nodes in
the tasks cpuset.

This is a long standing, intentional part of the cpuset design.

Using udev isn't papering over it.  It's reflecting the reasonable
preference and expectation on systems using hotplug/unplug that
the default cpuset dynamically reflect the current online maps,
not the static maps as they were at boot.  And using udev is using
just the sort of mechanism one might expect to be used to adjust
the system when devices go on or off line.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
