Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWFLMC1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWFLMC1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 08:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751896AbWFLMC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 08:02:27 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:41872 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751897AbWFLMC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 08:02:26 -0400
Message-ID: <448D57CD.4030007@de.ibm.com>
Date: Mon, 12 Jun 2006 14:02:21 +0200
From: Martin Peschke <mp3@de.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: Jay Lan <jlan@sgi.com>
CC: Shailabh Nagar <nagar@watson.ibm.com>, balbir@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Sturtivant <csturtiv@sgi.com>,
       Peter Chubb <peterc@gelato.unsw.edu.au>
Subject: Re: Merge of per task delay accounting (was Re: 2.6.18 -mm merge
 plans)
References: <20060604135011.decdc7c9.akpm@osdl.org> <4484D25E.4020805@in.ibm.com> <4486017F.8030308@watson.ibm.com> <4486073B.2040102@sgi.com>
In-Reply-To: <4486073B.2040102@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:
> Shailabh Nagar wrote:
>> Balbir Singh wrote:

>> Andrew,
>>
>> The only other new set of patches to be discussed in this context are the
>> statistics-infrastructure patches from Martin Peschke.
>>
>> That infrastructure cannot meet the needs of delay accounting, CSA 
>> etc. because
>> - it only provides "user pull" model of getting stats whereas "kernel 
>> push" is
>> needed for delay accounting
> 
> Doesn't taskstats interface provide "user pull" request-reply model
> also? Serious accounting needs to push accounting data as soon as
> possible.
> 
>> - it uses a relatively slow interface unsuitable for high volumes of 
>> data. 

By design.

I think it would be fatal to report every event relevant
to statistical data gathering up to user space. It's fine to have
the kernel maintain counters and to provide preprocessed data.

Given that, is there a need for a high-speed interface for a
huge amount of unprocessed statistical data?

However, the user interface is a just one building brick,
which can be enhanced or replaced with moderate effort, if
there is a need.

 >> Each statistic has its own definition,

Allowing users to restrict accounting to what they need in their
particular case. Sensible defaults are usually available.

>> needs to be read separately using ASCII,
>> reading data continuously means open/read/close each time.....all of
>> which is not very conducive to large structures being sent to userspace.

Debugfs file are fine for larger structures.

Unless one keeps reading statistics dozens of times per second,
I don't see an issue with that.

The question is: what are the requirements to be covered?

> Yes, i second the point. It won't be able to catch up the traffic.
> 
>> - its oriented towards sampled data whereas taskstats isn't.
>>
>> So, we have a good consensus from existing/potential users of 
>> taskstats and would
>> very much appreciate it being included in 2.6.18.
> 
> Andrew, it has become clear that the community wants to see accounting
> data processing being moved to userspace. Thus there is a need for a
> common accounting interface to provide minimal works at kernel (via
> hooks at fork and exit) and deliver data to userspace.

Both, the statistics infrastructure on behalf of its exploiters as well
as the exploiters of the taskstats interface do data preprocessing,
that is, maintain counters in the kernel.
User space counters won't perform, of course.

AFAICS, actual differences are:
- triggers for data delivery to user space
   (statistics infrastructure: when user reads statistics through file,
    taskstats: on certain task related events, right?)
- and, therewith, frequency of data delivery to user space


Martin

