Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbWBQJJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbWBQJJW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 04:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWBQJJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 04:09:22 -0500
Received: from fw5.argo.co.il ([194.90.79.130]:3346 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S932327AbWBQJJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 04:09:21 -0500
Message-ID: <43F592BC.9080606@argo.co.il>
Date: Fri, 17 Feb 2006 11:09:16 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Walker <dwalker@mvista.com>
CC: Ingo Molnar <mingo@elte.hu>, Johannes Stezenbach <js@linuxtv.org>,
       linux-kernel@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       David Singleton <dsingleton@mvista.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/5] lightweight robust futexes: -V1
References: <20060215151711.GA31569@elte.hu> <20060216145823.GA25759@linuxtv.org> <20060216172007.GB29151@elte.hu> <Pine.LNX.4.64.0602161055100.30911@dhcp153.mvista.com>
In-Reply-To: <Pine.LNX.4.64.0602161055100.30911@dhcp153.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 09:09:19.0687 (UTC) FILETIME=[D5D49D70:01C633A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Walker wrote:

> On Thu, 16 Feb 2006, Ingo Molnar wrote:
>
>>
>> that's memory corruption - which robust futexes do not (and cannot)
>> solve. Robustness is mostly about handling sudden death (e.g. which is
>> due to oom, or is due to a user killing the task, or due to the
>> application crashing in some non-memory-corrupting way), but it cannot
>> handle all possible failure modes.
>
>
>     I don't think this is a weakness in Dave or Inaky's versions. Dave 
> at least maintained the bulk of the information in kernel space. The 
> uaddr was used for the fast locking in userspace, but not for 
> maintaining the robustness .
>
> Correct me if I'm wrong Dave.


In the general case of memory corruption, the data protected by the 
robust futex might be corrupted, and no robust futex implementation can 
protect against that, In fact it's a lot more likely since the 
application code has pointers to the data but not to the robust list.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

