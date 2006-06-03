Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751559AbWFCHx2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbWFCHx2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 03:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWFCHx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 03:53:28 -0400
Received: from mail25.syd.optusnet.com.au ([211.29.133.166]:33163 "EHLO
	mail25.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751317AbWFCHx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 03:53:27 -0400
From: Con Kolivas <kernel@kolivas.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: [patch] fix smt nice lock contention and optimization
Date: Sat, 3 Jun 2006 17:52:58 +1000
User-Agent: KMail/1.9.3
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       "'Chris Mason'" <mason@suse.com>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
References: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
In-Reply-To: <000701c686e1$71f2f7f0$df34030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606031752.59532.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 June 2006 17:43, Chen, Kenneth W wrote:
> OK, final rolled up patch with everyone's changes. I fixed one bug
> introduced by Con's earlier patch that there is an unpaired
> spin_trylock/spin_unlock in the for loop of dependent_sleeper().
> Chris, Con, Nick - please review and provide your signed-off-by line.
> Andrew - please consider for -mm inclusion.  Thanks.

Looks good. Just one style nitpick.

>  	for_each_domain(this_cpu, tmp)
> -		if (tmp->flags & SD_SHARE_CPUPOWER)
> +		if (tmp->flags & SD_SHARE_CPUPOWER) {
>  			sd = tmp;
> -
> +			break;
> +		}

Could we make this neater with extra braces such as:

 	for_each_domain(this_cpu, tmp) {
		if (tmp->flags & SD_SHARE_CPUPOWER) {
 			sd = tmp;
			break;
		}
	}

and same for the other uses of for_each ? I know it's redundant but it's 
neater IMO when there are multiple lines of code below it.

-- 
-ck
