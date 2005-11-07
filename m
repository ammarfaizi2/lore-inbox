Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965576AbVKGWfp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965576AbVKGWfp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 17:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965578AbVKGWfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 17:35:44 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:62852 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965576AbVKGWfn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 17:35:43 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Brian Twichell <tbrian@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, mbligh@mbligh.org, slpratt@us.ibm.com,
       anton@samba.org
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <436FD291.2060301@us.ibm.com>
References: <436FD291.2060301@us.ibm.com>
Date: Mon, 7 Nov 2005 14:35:33 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: Database regression due to scheduler changes ?
In-Reply-To: <436FD291.2060301@us.ibm.com>
Message-ID: <Pine.LNX.4.62.0511071431030.9339@qynat.qvtvafvgr.pbz>
References: <436FD291.2060301@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian,
   If I am understanding the data you posted, it looks like you are useing 
sched_yield extensivly in your database. This is known to have significant 
problems on SMP machines, and even bigger ones on NUMA machines, in part 
becouse the process doing the sched_yield may get rescheduled immediatly 
and not allow other processes to run (to free up whatever resource it's 
waiting for). This causes the processor to look busy to the scheduler and 
therefor the scheduler doesn't migrate other processes to the CPU that's 
spinning on sched_yield. On NUMA machines this is even more noticable as 
processes now have to migrate through an additional layer of the 
scheduler.

have to tried eliminating the sched_yield to see what difference it makes?

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
