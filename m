Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbTDKXL6 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbTDKXL6 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:11:58 -0400
Received: from [12.47.58.73] ([12.47.58.73]:56060 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261844AbTDKXL5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 19:11:57 -0400
Date: Fri, 11 Apr 2003 16:23:38 -0700
From: Andrew Morton <akpm@digeo.com>
To: Greg KH <greg@kroah.com>
Cc: sdake@mvista.com, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-Id: <20030411162338.4b16b8f7.akpm@digeo.com>
In-Reply-To: <20030411230111.GF3786@kroah.com>
References: <20030411172011.GA1821@kroah.com>
	<200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk>
	<20030411182313.GG25862@wind.cocodriloo.com>
	<3E970A00.2050204@cox.net>
	<3E9725C5.3090503@mvista.com>
	<20030411150933.43fd9a84.akpm@digeo.com>
	<20030411230111.GF3786@kroah.com>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 23:23:35.0639 (UTC) FILETIME=[5FE8F670:01C30081]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Fri, Apr 11, 2003 at 03:09:33PM -0700, Andrew Morton wrote:
> > Steven Dake <sdake@mvista.com> wrote:
> > >
> > > A much better solution could be had by select()ing on a filehandle 
> > > indicating when a new hotswap event is ready to be processed.  No races, 
> > > no security issues, no performance issues.
> > 
> > I must say that I've always felt this to be a better approach than the
> > /sbin/hotplug callout.
> > 
> > Apart from the performance issue, it means that the kernel can buffer the
> > "insertion" events which happen at boot-time discovery until the userspace
> > handler attaches itself.
> 
> But how many events to we buffer?

On a large machine: 856,432.

> When do we start to throw them away?
> Fun policy decisions that we don't have to worry about in the current
> scheme.

The current scheme will run out of processes, kernel stacks, etc before a
message scheme would.

> Also, what's the format of the kernel->user interface.

Exactly the same as at present, with /sbin/hotplug chopped off.  So you can
run the daemon:

	while read x
	do
		/sbin/hotplug $x
	done < /dev/hotplug_event_pipe

for compatibility with existing scripts.

But I'm not really very opinionated about it.  I don't expect any of it to be
super-robust, really.
