Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751334AbWAEOax@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWAEOax (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 09:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWAEOax
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 09:30:53 -0500
Received: from dpc6682004040.direcpc.com ([66.82.4.40]:28691 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751323AbWAEOau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 09:30:50 -0500
Date: Thu, 05 Jan 2006 09:30:23 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH] fix workqueue oops during cpu offline
In-reply-to: <1136440988.4840.60.camel@localhost.localdomain>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Nathan Lynch <ntl@pobox.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Message-id: <1136471423.4430.58.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <20060105045810.GE16729@localhost.localdomain>
 <200601051558.14275.ncunningham@cyclades.com>
 <1136440988.4840.60.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 17:03 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2006-01-05 at 15:58 +1000, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Thursday 05 January 2006 14:58, Nathan Lynch wrote:
> > > With 2.6.15, powerpc systems oops when cpu 0 is offlined.  This is a
> > > regression from 2.6.14, caused by commit id
> > > bce61dd49d6ba7799be2de17c772e4c701558f14 ("Fix hardcoded cpu=0 in
> > > workqueue for per_cpu_ptr() calls").
> > 
> > So it's valid on ppc for cpu 0 to be taken offline? IIRC, trying that on my P4 
> > a while back did nothing. I think you'll find other places that assume that 
> > cpu 0 is always up (swsusp? ... I should check suspend2).
> 
> It's bogus, cpu0 can be put offline.

Not only that, but on some systems it may never even exist. Which was
the whole reason for my problem in the first place with the workqueue
code.

I haven't tested it, but the patch would appear to work for me. Since
sparc64 doesn't support CPU hotplug, the cpu_possible_map is just a copy
of cpu_present_map. I'll merge it into my tree and give it a run on the
ultra3k.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

