Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVBURG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVBURG7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbVBURG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:06:59 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:26076 "EHLO
	vms048pub.verizon.net") by vger.kernel.org with ESMTP
	id S262038AbVBURG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:06:56 -0500
Date: Mon, 21 Feb 2005 12:06:53 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: BicTCP Implementation Bug
In-reply-to: <fd9de42cb9cca9589da8a65bb6e719d5@may.ie>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200502211206.53419.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <fd9de42cb9cca9589da8a65bb6e719d5@may.ie>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 February 2005 08:47, Yee-Ting Li wrote:
>Hi,
>
>We have discovered a serious implementation bug in BicTCP on the
> Linux kernels. Note that because BicTCP is ON by default, this
> affects all users of kernel versions 2.6.8 and above.
>
>For further details please see:
>http://www.hamilton.ie/net/bic-fix/Linux%20BicTCP.pdf
>
>and the patch is:
>
>Index: linux-2.6.10/include/net/tcp.h
>===================================================================
>--- linux-2.6.10.orig/include/net/tcp.h Fri Dec 24 21:34:00 2004
>+++ linux-2.6.10/include/net/tcp.h      Thu Feb 17 14:13:14 2005
>@@ -1280,8 +1280,7 @@
>                 if (sysctl_tcp_bic_fast_convergence &&
>                     tp->snd_cwnd < tp->bictcp.last_max_cwnd)
>                         tp->bictcp.last_max_cwnd
>-                               = (tp->snd_cwnd *
>(2*BICTCP_1_OVER_BETA-1))
>-                               / (BICTCP_1_OVER_BETA/2);
>+                           = tp->snd_cwnd - ( tp->snd_cwnd /
>(BICTCP_1_OVER_BETA*2) );
>                 else
>                         tp->bictcp.last_max_cwnd = tp->snd_cwnd;

Could this explain why there was a lot of complaining that tcp was 
slower back about then? (2.6.6 release time)

I've built and rebooted to a kernel patched as above, and will report, 
but on my home network, the closest it will come to being congested 
would be during an rsync or amdump from a client run, so it is 
possible I will see no 'get my attention' differences.  Nothing else 
can approach me any faster than a 10base-T circuit.

In case no one else mentions it Mr. Li, patches such as this need a 
"signed off by $yourname" line for record keeping, this just started 
a few months ago.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.34% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
