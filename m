Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbTDKWf3 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 18:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbTDKWf3 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 18:35:29 -0400
Received: from [12.47.58.73] ([12.47.58.73]:38645 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261866AbTDKWf2 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 18:35:28 -0400
Date: Fri, 11 Apr 2003 15:47:09 -0700
From: Andrew Morton <akpm@digeo.com>
To: Tim Hockin <thockin@hockin.org>
Cc: sdake@mvista.com, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com, greg@kroah.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-Id: <20030411154709.379a139c.akpm@digeo.com>
In-Reply-To: <200304112219.h3BMJMG11078@www.hockin.org>
References: <20030411150933.43fd9a84.akpm@digeo.com>
	<200304112219.h3BMJMG11078@www.hockin.org>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 22:47:07.0011 (UTC) FILETIME=[4762D530:01C3007C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin <thockin@hockin.org> wrote:
>
> > > A much better solution could be had by select()ing on a filehandle 
> > > indicating when a new hotswap event is ready to be processed.  No races, 
> > > no security issues, no performance issues.
> > 
> > I must say that I've always felt this to be a better approach than the
> > /sbin/hotplug callout.
> 
> I've always liked this approach, too - if you look at acpid, it is designed
> to be gereically useful for this model of kernel->userland notification.
> 
> With minor mods, it could become 'eventd' and handle ACPI, hotplug, netlink,
> and any other style kernel->user notice.

It also has the advantage that events are handled in reliable and repeatable
order.

Right now, if you plug and then quickly unplug a device, the unplug event can
be handled first.

It may not happen much in practice, but we have had problem with cardbus
contact bounce causing an event storm in the past.  The daemon could just
swallow the first 5 insert/remove pairs and process the final insert only.

The kernel would have to drop messages on the floor at some point though.
