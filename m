Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751657AbWFVGO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751657AbWFVGO7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbWFVGO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:14:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:58548 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751654AbWFVGO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:14:58 -0400
Date: Wed, 21 Jun 2006 23:14:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com, pavel@ucw.cz,
       ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
In-Reply-To: <20060621225609.db34df34.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0606212311570.25441@schroedinger.engr.sgi.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
 <20060621225609.db34df34.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Andrew Morton wrote:

> > Now, when a task loses all of its allowed cpus because of cpu hot removal,
> > it will be foreced to migrate to not-allowed cpus.
> > 
> > In this case, the task is not properly reconfigurated by a user before
> > cpu-hot-removal. Here, the task (and system) is in a unexpeced wrong state.
> > This migration is maybe one of realistic workarounds. But sometimes it will be
> > harmfull.
> > (stealing other cpu time, making bugs in thread controllers, do some unexpected
> >  execution...)
> > 
> > This patch adds sysctl "sigstop_on_cpu_lost". When sigstop_on_cpu_lost==1,
> > a task which losts is cpu will be stopped by SIGSTOP.
> > Depends on system management policy, mis-configurated applications are stopped.
> > 
> 
> Well that's a pretty unpleasant patch, isn't it?

The cleanest solution is to terminate the process. If the user has 
configured the process to only run on a certain cpu and the processor then 
becomes unavailable then the process needs to terminate by default since 
it has no resource left to run. This is similar to an Out of Memory 
condition.

We can add this sigstop_on_cpu_lost as an additional measure but it should 
be off by default. So far we have never had the system stop a process 
because resources are not available. This would be unexpected system 
behavior.

