Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWFVF41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWFVF41 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 01:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWFVF41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 01:56:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16350 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932179AbWFVF40 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 01:56:26 -0400
Date: Wed, 21 Jun 2006 22:56:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, ashok.raj@intel.com, pavel@ucw.cz,
       clameter@sgi.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-Id: <20060621225609.db34df34.akpm@osdl.org>
In-Reply-To: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 12:51:59 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> When the application is mis-configurated at cpu hot removal, a task's 
> cpus_allowd can be empty. this patch adds sysctl to stop tasks whose 
> cpus_allowed is empty.
> 
> I think there isn't one good answer to handle this problem and this is
> depend on system management policy. In a system, forced migration is better 
> than stop. In another, stopping tasks (and killing) will meet requirement.
> 
> How about this ?
> 
> -Kame
> 
> Now, when a task loses all of its allowed cpus because of cpu hot removal,
> it will be foreced to migrate to not-allowed cpus.
> 
> In this case, the task is not properly reconfigurated by a user before
> cpu-hot-removal. Here, the task (and system) is in a unexpeced wrong state.
> This migration is maybe one of realistic workarounds. But sometimes it will be
> harmfull.
> (stealing other cpu time, making bugs in thread controllers, do some unexpected
>  execution...)
> 
> This patch adds sysctl "sigstop_on_cpu_lost". When sigstop_on_cpu_lost==1,
> a task which losts is cpu will be stopped by SIGSTOP.
> Depends on system management policy, mis-configurated applications are stopped.
> 

Well that's a pretty unpleasant patch, isn't it?

But I guess it's policy, and if we cannot think of anything better then we'll
have to do it this way :(

> 
> 
>  include/linux/sysctl.h |    1 +
>  kernel/sched.c         |   14 ++++++++++++++
>  kernel/sysctl.c        |   14 ++++++++++++++

An update to Documentation/cpu-hotplug.txt would seem appropriate, please, and a
line in Documentation/sysctl/kernel.txt which refers to it.
