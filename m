Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWDLL1g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWDLL1g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 07:27:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWDLL1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 07:27:36 -0400
Received: from mail19.syd.optusnet.com.au ([211.29.132.200]:28068 "EHLO
	mail19.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932183AbWDLL1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 07:27:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [patch][rfc] quell interactive feeding frenzy
Date: Wed, 12 Apr 2006 21:27:19 +1000
User-Agent: KMail/1.9.1
Cc: ck list <ck@vds.kolivas.org>, linux-kernel@vger.kernel.org,
       Mike Galbraith <efault@gmx.de>
References: <200604112100.28725.kernel@kolivas.org> <200604121936.16584.kernel@kolivas.org> <200604121339.40563.a1426z@gawab.com>
In-Reply-To: <200604121339.40563.a1426z@gawab.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1478
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604122127.20322.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 April 2006 20:39, Al Boldi wrote:
> Con Kolivas wrote:
> > Installed and tested here just now. They run smoothly concurrently here.
> > Are you testing on staircase15?
>
> staircase14.2-test3.  Are you testing w/ DRM?  If not then all mesa
> requests will be queued into X, and then runs as one task (check top d.1)

Nvidia driver; all separate tasks in top.

> Try ping -A (10x).  top d.1 should show skewed times.  If you have a fast
> machine, you may have to increase the load.

Ran for a bit over 10 mins outside of X to avoid other tasks influencing 
results. I was too lazy to go to init 1.

ps -eALo pid,spid,user,priority,ni,pcpu,vsize,time,args

15648 15648 root      39   0  9.2  1740 00:01:03 ping -A localhost
15649 15649 root      28   0  9.8  1740 00:01:06 ping -A localhost
15650 15650 root      39   0  9.9  1744 00:01:07 ping -A localhost
15651 15651 root      39   0  9.3  1740 00:01:03 ping -A localhost
15652 15652 root      39   0 10.3  1740 00:01:10 ping -A localhost
15653 15653 root      39   0 10.8  1740 00:01:13 ping -A localhost
15654 15654 root      39   0 10.0  1740 00:01:08 ping -A localhost
15655 15655 root      39   0 10.5  1740 00:01:11 ping -A localhost
15656 15656 root      39   0  9.9  1740 00:01:07 ping -A localhost
15657 15657 root      39   0 10.2  1740 00:01:09 ping -A localhost

mean 68.7 seconds

range 63-73 seconds.

For a load that wakes up so frequently for such a short period of time I think 
that is pretty fair cpu distribution over 10 mins. Over shorter periods top 
is hopeless at representing accurate cpu usage, especially at low HZ settings 
of the kernel. You can see the current cpu distribution on ps there is pretty 
consistent across the tasks and gives what I consider quite a fair cpu 
distribution over 10 mins.

-- 
-ck
