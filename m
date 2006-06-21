Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWFULlt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWFULlt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 07:41:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWFULlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 07:41:49 -0400
Received: from omta04sl.mx.bigpond.com ([144.140.93.156]:59265 "EHLO
	omta04sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1751064AbWFULls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 07:41:48 -0400
Message-ID: <44993079.40300@bigpond.net.au>
Date: Wed, 21 Jun 2006 21:41:45 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Matt Helsley <matthltc@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       Jes Sorensen <jes@sgi.com>, LSE-Tech <lse-tech@lists.sourceforge.net>,
       Chandra S Seetharaman <sekharan@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>, John T Kohl <jtk@us.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [PATCH 00/11] Task watchers:  Introduction
References: <1150242721.21787.138.camel@stark>	 <4498DC23.2010400@bigpond.net.au> <1150876292.21787.911.camel@stark> <44992EAA.6060805@bigpond.net.au>
In-Reply-To: <44992EAA.6060805@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta04sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Wed, 21 Jun 2006 11:41:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Matt Helsley wrote:
>> On Wed, 2006-06-21 at 15:41 +1000, Peter Williams wrote:
>>> On a related note, I can't see where the new task's notify field gets 
>>> initialized during fork.
>>
>> It's initialized in kernel/sys.c:notify_per_task_watchers(), which calls
>> RAW_INIT_NOTIFIER_HEAD(&task->notify) in response to WATCH_TASK_INIT.
> 
> I think that's too late.  It needs to be done at the start of 
> notify_watchers() before any other watchers are called for the new task.

On second thoughts, it would simpler just before the WATCH_TASK_INIT 
call in copy_process() in fork.c.  It can be done unconditionally there.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
