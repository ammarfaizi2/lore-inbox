Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263203AbTDLIlE (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 04:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbTDLIlE (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 04:41:04 -0400
Received: from [12.47.58.73] ([12.47.58.73]:3371 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S263203AbTDLIlD (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 04:41:03 -0400
Date: Sat, 12 Apr 2003 01:52:53 -0700
From: Andrew Morton <akpm@digeo.com>
To: oliver@neukum.name
Cc: oliver@neukum.org, miquels@cistron-office.nl, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-Id: <20030412015253.6471774e.akpm@digeo.com>
In-Reply-To: <200304121040.07947.oliver@neukum.org>
References: <20030411172011.GA1821@kroah.com>
	<20030412000829.GL4539@kroah.com>
	<b77m71$7bs$1@news.cistron.nl>
	<200304121040.07947.oliver@neukum.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Apr 2003 08:52:41.0085 (UTC) FILETIME=[E02E8AD0:01C300D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum <oliver@neukum.org> wrote:
>
> 
> > The pipe/socket solution is probably better anyway, I was just
> > wondering why /sbin/hotplug wasn't serialized from the start.
> 
> It was. Deadlocks happened and the semaphore was removed.
> I don't remember details. They might be in the archives.
> 

register_netdevice() is called under rtnl_lock.  It calls
net_run_sbin_hotplug() which ends up waiting on ifconfig.  But
ifconfig needs rtnl_lock.

