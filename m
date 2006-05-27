Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751760AbWE0CIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751760AbWE0CIm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 22:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWE0CIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 22:08:42 -0400
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:40637 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751760AbWE0CIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 22:08:41 -0400
From: Con Kolivas <kernel@kolivas.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] cfq: ioprio inherit rt class
Date: Sat, 27 May 2006 12:08:32 +1000
User-Agent: KMail/1.9.1
Cc: Jens Axboe <axboe@suse.de>, ck list <ck@vds.kolivas.org>
References: <200605271150.41924.kernel@kolivas.org>
In-Reply-To: <200605271150.41924.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605271208.33037.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 May 2006 11:50, Con Kolivas wrote:
> Jens, ml
>
> I was wondering if cfq io priorities should be explicitly set to the
> realtime class when no io priority is specified from realtime tasks as in
> the following patch? (rt_task() will need to be modified to suit the PI
> changes in -mm)
>
> ---
> Set cfq io priority class to realtime and scale the priority according to
> the rt priority when no io priority is explicitly set in realtime tasks.

sorry, rather than this:
> +		return (task->rt_priority * IOPRIO_BE_NR / MAX_RT_PRIO);

it should be:
return ((MAX_RT_PRIO - task->rt_priority) * IOPRIO_BE_NR / MAX_RT_PRIO);

-- 
-ck
