Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263353AbTDSE7a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 00:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTDSE7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 00:59:30 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:38632 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263353AbTDSE72
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 00:59:28 -0400
Message-ID: <3EA0D2ED.6000904@pacbell.net>
Date: Fri, 18 Apr 2003 21:39:09 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Steven Dake <sdake@mvista.com>, kpfleming@cox.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com, greg@kroah.com
Subject: Re: [ANNOUNCE] udev 0.1 release
References: <20030411172011.GA1821@kroah.com>	<200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk>	<20030411182313.GG25862@wind.cocodriloo.com>	<3E970A00.2050204@cox.net>	<3E9725C5.3090503@mvista.com> <20030411150933.43fd9a84.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Steven Dake <sdake@mvista.com> wrote:
> 
>>A much better solution could be had by select()ing on a filehandle 
>>indicating when a new hotswap event is ready to be processed.  No races, 
>>no security issues, no performance issues.
> 
> 
> I must say that I've always felt this to be a better approach than the
> /sbin/hotplug callout.

Better in some environments, not all.  It's a tradeoff.

Me, I'd far rather allocate those hotplug resources on demand
than pre-allocate them into Yet Another Daemon.  For bounded
response-time systems, or for systems that are generating huge
event streams, I'd likely want more control though.


> Apart from the performance issue, it means that the kernel can buffer the
> "insertion" events which happen at boot-time discovery until the userspace
> handler attaches itself.

It could do that regardless of whether the event is eventually
delivered through some socket or by spawning a new process.

The way hotplug events are handled after some subsystem decides
to send them isn't written in stone.  They've been asynchronous
all through the 2.4 series, so queueing is semantically OK.

- Dave



