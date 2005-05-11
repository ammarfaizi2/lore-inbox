Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVEKEXy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVEKEXy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 00:23:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbVEKEXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 00:23:53 -0400
Received: from wproxy.gmail.com ([64.233.184.206]:16586 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261873AbVEKEXv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 00:23:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=o3oNLFfsBEJHAeJjyC4D4DOxArCicw0GwuXT28qNzGwBmv5+iessHPZ1TOswSYW3TsAnHCdABsNf21OhieyFZcK3PqdKRfotvDUk8mI1GBd5wMOJ3zQ3+pMA83tK15tSgDlrVdXI5LtvSOoMzaoRTLeXKQkhJPHu/IzFd2G9WnE=
Message-ID: <d6e6e6dd050510212313319029@mail.gmail.com>
Date: Wed, 11 May 2005 00:23:51 -0400
From: Haoqiang Zheng <haoqiang@gmail.com>
Reply-To: Haoqiang Zheng <haoqiang@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [RFC PATCH] swap-sched: schedule with dynamic dependency detection (2.6.12-rc3)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200505091557.32810.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d6e6e6dd050507231174d99fb0@mail.gmail.com>
	 <200505090926.59335.kernel@kolivas.org>
	 <d6e6e6dd0505082056538221bd@mail.gmail.com>
	 <200505091557.32810.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While your swap-sched allows tasks waiting on other tasks to run better, it
> also introduces a greater degree of unfairness in cpu resource sharing. By
> allowing the dependent tasks to stay on the runqueue you increase
> substantially their share of the resources they would otherwise have gotten.
> The whole point of decrementing priority and runqueue expiration is to
> maintain fairness and you're introducing another way to delay that system
> from working. process_load is not the ideal task to test this unfairness on
> this design but even that shows twice as much cpu usage with your own tests.
> How do you propose to ensure we maintain fairness in this model ?

Sorry for the late response. I was busy with some other projects.

AFAIK, there are basically two task properties that can affect its
long term CPU allocation: the nice value and the interactiveness. The
nice value affects the time slice value. The interactiveness affects
the time_slice recharge frequency (an interactive task doesn't expire
unless there's an ``expire_starving'').

Well, swap-sched doesn't affect a task's time_slice value, but it does
has impact on interactivity detection. Currently, Linux detects task
interactivity based on ``sleep_average''. With swap-sched, a task with
dependency will sleep less than it does in vanilla kernel. I am not
sure if ``different'' necessary means bad. But I am sure
swap-sched can be modified so that the dependency detection part will
work exactly the same way as vanilla kernel.

Best regards,
Haoqiang
