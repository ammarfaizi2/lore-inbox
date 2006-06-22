Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751825AbWFVPm2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825AbWFVPm2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:42:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWFVPm2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:42:28 -0400
Received: from xenotime.net ([66.160.160.81]:19413 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161159AbWFVPm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:42:28 -0400
Date: Thu, 22 Jun 2006 08:45:13 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Nathan Lynch <ntl@pobox.com>
Cc: akpm@osdl.org, kamezawa.hiroyu@jp.fujitsu.com,
       linux-kernel@vger.kernel.org, ashok.raj@intel.com, pavel@ucw.cz,
       clameter@sgi.com, ak@suse.de, nickpiggin@yahoo.com.au, mingo@elte.hu
Subject: Re: [PATCH] stop on cpu lost
Message-Id: <20060622084513.4717835e.rdunlap@xenotime.net>
In-Reply-To: <20060622150848.GL16029@localdomain>
References: <20060620125159.72b0de15.kamezawa.hiroyu@jp.fujitsu.com>
	<20060621225609.db34df34.akpm@osdl.org>
	<20060622150848.GL16029@localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 10:08:48 -0500 Nathan Lynch wrote:

> Andrew Morton wrote:
> > KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> > > 
> > > Now, when a task loses all of its allowed cpus because of cpu hot removal,
> > > it will be foreced to migrate to not-allowed cpus.
> > > 
> > > In this case, the task is not properly reconfigurated by a user before
> > > cpu-hot-removal. Here, the task (and system) is in a unexpeced wrong state.
> > > This migration is maybe one of realistic workarounds. But sometimes it will be
> > > harmfull.
> > > (stealing other cpu time, making bugs in thread controllers, do some unexpected
> > >  execution...)
> > > 
> > > This patch adds sysctl "sigstop_on_cpu_lost". When sigstop_on_cpu_lost==1,
> > > a task which losts is cpu will be stopped by SIGSTOP.
> > > Depends on system management policy, mis-configurated applications are stopped.
> > > 
> > 
> > Well that's a pretty unpleasant patch, isn't it?
> > 
> > But I guess it's policy, and if we cannot think of anything better then we'll
> > have to do it this way :(
> 
> I tend to favor not changing the kernel to handle this case.  We're
> already making a best effort attempt to handle conflicting directives
> from the admin.  This is a policy that can be implemented in userspace
> without much trouble.
> 
> If we really want to keep the admin shooting himself in the foot,
> wouldn't it be preferable to fail the offline operation if there are
> user tasks exclusively bound to the cpu?

Sounds much better than just killing the process.

> While we're on the subject, what if there are interrupts bound to the
> cpu you want to offline?  Should we consider handling that case
> differently as well?


---
~Randy
