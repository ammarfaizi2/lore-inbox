Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVB1SLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVB1SLp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 13:11:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVB1SLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 13:11:44 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48850 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261655AbVB1SLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 13:11:43 -0500
Message-ID: <42235EC6.9030900@us.ibm.com>
Date: Mon, 28 Feb 2005 12:11:18 -0600
From: Andrew Theurer <habanero@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mingo@elte.hu, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/13] timestamp fixes
References: <42235517.5070504@us.ibm.com>
In-Reply-To: <42235517.5070504@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick, can you describe the system you run the DB tests on?  Do you have 
any cpu idle time stats and hopefully some context switch rate stats? 

I think I understand the concern [patch 6] of stealing a task from one 
node to an idle cpu in another node, but I wonder if we can have some 
sort of check for idle balance: if the domain/node to steal from has 
some idle cpu somewhere, we do not steal, period.  To do this we have a 
cpu_idle bitmask, we update as cpus go idle/busy, and we reference this 
cpu_idle & sd->cpu_mask to see if there's at least one cpu that's idle.

> Ingo wrote:
>
> But i expect fork/clone balancing to be almost certainly a problem. (We
> didnt get it right for all workloads in 2.6.7, and i think it cannot be
> gotten right currently either, without userspace API help - but i'd be
> happy to be proven wrong.)

Perhaps initially one could balance on fork up to the domain level which 
has task_hot_time=0, up to a shared cache by default.  Anything above 
that could require a numactl like preference from userspace.

-Andrew Theurer
