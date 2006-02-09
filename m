Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWBISnG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWBISnG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 13:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWBISnG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 13:43:06 -0500
Received: from mail.dvmed.net ([216.237.124.58]:12472 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750702AbWBISnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 13:43:05 -0500
Message-ID: <43EB8D2C.6020708@pobox.com>
Date: Thu, 09 Feb 2006 13:42:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: kill not-so-popular simple flag testing macros
References: <20060208085728.GA21065@htj.dyndns.org>
In-Reply-To: <20060208085728.GA21065@htj.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > This patch kills the following
	request flag testing macros. > > blk_noretry_request() >
	blk_rq_started() > blk_pm_suspend_request() > blk_pm_resume_request() >
	blk_sorted_rq() > blk_barrier_rq() > blk_fua_rq() > > All above macros
	test for single request flag and not used widely and > seem to
	contribute more to obscurity than readability. > > Signed-off-by: Tejun
	Heo <htejun@gmail.com> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> This patch kills the following request flag testing macros.
> 
> blk_noretry_request()
> blk_rq_started()
> blk_pm_suspend_request()
> blk_pm_resume_request()
> blk_sorted_rq()
> blk_barrier_rq()
> blk_fua_rq()
> 
> All above macros test for single request flag and not used widely and
> seem to contribute more to obscurity than readability.
> 
> Signed-off-by: Tejun Heo <htejun@gmail.com>

heh, I guess that's a manner of opinion :)

To me, your patch makes things less readable.  Example:

> -	int is_barrier = blk_fs_request(rq) && blk_barrier_rq(rq);
> +	int is_barrier = blk_fs_request(rq) && rq->flags & REQ_HARDBARRIER;

After your change is applied, the above statement is no longer visually 
consistent with itself.  The reader must decode two different styles of 
test in his brain, as opposed to one.

	Jeff


