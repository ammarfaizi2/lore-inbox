Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261376AbVHBALq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbVHBALq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 20:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVHBALq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 20:11:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:6539 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261376AbVHBALo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 20:11:44 -0400
Date: Mon, 1 Aug 2005 17:11:43 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Patrick McHardy <kaber@trash.net>
Cc: Josip Loncaric <josip@lanl.gov>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] net/sunrpc: fix time conversion error
Message-ID: <20050802001143.GC8353@us.ibm.com>
References: <42EE9014.7080205@lanl.gov> <20050801225643.GA4285@us.ibm.com> <42EEB86F.1090808@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EEB86F.1090808@trash.net>
X-Operating-System: Linux 2.6.12 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.08.2005 [02:03:59 +0200], Patrick McHardy wrote:
> Nishanth Aravamudan wrote:
> > On 01.08.2005 [15:11:48 -0600], Josip Loncaric wrote:
> > 
> >>Line 589 of linux-2.6.11.10/net/sunrpc/svcsock.c is obviously wrong:
> >>
> >>                skb->stamp.tv_usec = xtime.tv_nsec * 1000;
> >>
> >>To convert nsec to usec, one should divide instead of multiplying:
> >>
> >>                skb->stamp.tv_usec = xtime.tv_nsec / 1000;
> >>
> >>The same bug could be present in the latest kernels, although I haven't 
> >>checked.  This bug makes svc_udp_recvfrom() timestamps incorrect.
> > 
> > 
> > Agreed, the conversion is wrong. I think the code is buggy period, as it
> > accesses xtime without grabbing the xtime_lock first. Following patch
> > should fix both issues.
> > 
> > Description: This function incorrectly multiplies a nanosecond value by
> > 1000, instead of dividing by 1000, to obtain a corresponding microsecond
> > value. Fix the math. Also, the function incorrectly accesses xtime
> > without using the xtime_lock. Fixed as well. Patch is compile-tested.
> 
> Depending on in which release you want this patch included, you might
> want to redo it against Dave's net-2.6.14 tree. It includes a patch that
> changes skb->stamp to an offset against a base timestamp.

Ok, I'll try and get around to rediff'ing tonight or tomorrow. Thanks
for the feedback!

<snip>

> PS: I'll submit the patch to break compilation for unconverted users
> ASAP.

Thanks,
Nish
