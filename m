Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265293AbUF1XiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUF1XiN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 19:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265294AbUF1XiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 19:38:12 -0400
Received: from gizmo10bw.bigpond.com ([144.140.70.20]:31684 "HELO
	gizmo10bw.bigpond.com") by vger.kernel.org with SMTP
	id S265293AbUF1XiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 19:38:08 -0400
Message-ID: <40E0ABDD.5010108@bigpond.net.au>
Date: Tue, 29 Jun 2004 09:38:05 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Nice 19 process still gets some CPU
References: <40E035CE.1020401@techsource.com>
In-Reply-To: <40E035CE.1020401@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:
> Given how much I've read here about schedulers, I should probably be 
> able to answer this question myself, but I just thought I might talk to 
> the experts.
> 
> I'm running SETI@Home, and it has a nice value of 19.  Everything else, 
> for the most part, is at zero.
> 
> I'm running kernel gentoo-dev-sources-2.6.7-r6 (I believe).
> 
> When I'm not running SETI@Home, compiler threads (emerge of a package, 
> kernel compile, etc.) get 100% CPU.  When I AM running SETI@Home, 
> SETI@Home still manages to get between 5% and 10% CPU.
> 
> I would expect that nice 0 processes should get SO MUCH more than nice 
> 19 processes that the nice 19 process would practically starve (and in 
> the case of a nice 19 process, I think starvation by nice 0 processes is 
> just fine), but it looks like it's not starving.
> 
> Why is that?

If you wish to control the "severity" of nice you should try the "pb" 
mode of the scheduler evaluation patch:

<http://prdownloads.sourceforge.net/cpuse/patch-2.6.7-spa_hydra_FULL-v1.2?download>

The "severity" of nice will vary with the ratio of the promotion 
interval (/proc/sys/kernel/cpusched/promotion_interval in milliseconds) 
to the time slice (/proc/sys/kernel/cpusched/time_slice also in 
milliseconds).  To experiment with these settings you can use two CPU 
bound processes with different nice values and use top to see how much 
changing the promotion interval to time slice ratio effects their CPU 
usage rates.

There's a primitive GUI for setting these parameters' values at:

<http://prdownloads.sourceforge.net/cpuse/gcpuctl_hydra-1.0.tar.gz?download>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

