Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVIHISU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVIHISU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 04:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVIHISU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 04:18:20 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:37319 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1751346AbVIHISU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 04:18:20 -0400
Date: Thu, 8 Sep 2005 17:18:19 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: Paul Jackson <pj@sgi.com>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
In-Reply-To: <20050908002323.181fd7d5.pj@sgi.com>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	<20050908002323.181fd7d5.pj@sgi.com>
X-Mailer: Sylpheed version 2.1.0+svn (GTK+ 2.6.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050908081819.2EA4E70031@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2005 00:23:23 -0700
Paul Jackson <pj@sgi.com> wrote:

> I've just started reading this - it seems well presented and I think
> you have put much effort into it.  Thank-you for posting it.

Thank you for reading my patches!

> I have not yet taken the time to understand it properly, but a couple
> of questions come to mind offhand.  I hope these questions will not be
> too silly.
> 
>  1) What is the relation of this patch set to CKRM?

My patches consist of two parts, one for subcpuset framework
and another for the cpu resource controller.
Subcpuset framework code doesn't have the relation to CKRM.
CKRM could probably use the cpu resource controller code as 
a resource controller of it with some modification.

>  2) Would a structure similar to Dinakar's patches to connect
>     cpusets and dynamic sched domains (posted to linux-mm)
>     work here as well?

Yes, subcpusets could work with the dynamic sched domains.
The cpu resource controller divides cpu resources by scaling 
time_slice of the tasks, so multiple subcpusets can be created
under the cpuset that has one cpu only.  So, uniprocessor systems
also could get the benefit of subcpusets-patched cpusets.

> My initial understanding is that subcpusets provide a way to partial
> out the proportion of cpu and memory used by various tasks.  A leaf
> node cpuset can partition the tasks attached to it into subsets, called
> subcpusets, where each subcpuset gets a proportion of cpu and memory
> available to the original leaf node cpuset.

That's right.

> I'm guessing you do not want such cpusets (the parents of subcpusets)
> to overlap, because if they did, it would seem to confuse the meaning
> of getting a fixed proportion of available cpu and memory resources.  I
> was a little surprised not to see any additional checks that
> cpu_exclusive and mem_exclusive must be set true in these cpusets, to
> insure non- overlapping cpusets.

Right - I don't want the parents of the subcpusets to overlap and 
I should add such checks, but wanted to know first what people would
think of subcpusets.

Regards,

KUROSAWA, Takahiro
