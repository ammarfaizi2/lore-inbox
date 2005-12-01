Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932469AbVLAU6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469AbVLAU6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVLAU6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:58:39 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:61169 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S932466AbVLAU6j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:58:39 -0500
Message-ID: <438F6440.2010409@mvista.com>
Date: Thu, 01 Dec 2005 12:59:44 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dino@in.ibm.com
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: Perf degradation from -rt14 onwards
References: <20051201204227.GA16035@in.ibm.com>
In-Reply-To: <20051201204227.GA16035@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dinakar Guniguntala wrote:

>I was wondering why the following change was made from -rt14
>onwards.
>
>
>@@ -1634,7 +1531,7 @@ asmlinkage long sys_futex(u32 __user *ua
>                          int val3)
> {
>        struct timespec t;
>-       unsigned long timeout = MAX_SCHEDULE_TIMEOUT;
>+       unsigned long timeout = 0;
>
>This was introduced in patch-2.6.14-rt13-rf3 by David.
>
>This seems to return spurious -ETIMEDOUT errors even in the
>non-robust code and results in userspace (glibc) retrying
>several mutex operations before it succeeds. I was chasing
>down a degradation of performance of some testcases and was
>able to fix those by reverting this change back.
>  
>

Yes.  The default timeout should be set to MAX_SCHEDULE_TIMEOUT, not zero.

David

>	-Dinakar
>
>  
>

