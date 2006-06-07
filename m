Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWFGCzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWFGCzr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 22:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbWFGCzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 22:55:47 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:27053 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1750742AbWFGCzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 22:55:46 -0400
Date: Tue, 06 Jun 2006 22:55:44 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: taskstats interface for accounting
In-reply-to: <44863376.5020701@sgi.com>
To: Jay Lan <jlan@sgi.com>
Cc: Balbir Singh <balbir@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, csturtiv@sgi.com,
       jamal <hadi@cyberus.ca>
Message-id: <44864030.6010906@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <44863376.5020701@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Lan wrote:

> Hi Balbir and Shailabh,
>
> I finally have time to think about implementation details of CSA over
> taskstats interface. I took another look at the taskstats interface
> proposal and was a little bit nervous.
>
> Do you remember i suggested to use #ifdef to cut down traffic and i
> was told a generic netlink header would serve the purpose?
> What i see now at Documentation/accounting/taskstats.txt saying
> NETLINK_GENERIC family is used for unicast query/reply mode. The
> NETLINK_GENERIC family provides great flexsibility on what to receive. 
> However, CSA only uses the multicast mode to receive from kernel
> whenever tasks are existing. I guess i would need to read the netlink
> documentation more carefully to see whether my understanding is
> correct.

I don't think there's a problem here. The netlink socket opened for 
listening to
taskstat data sent on task exit can be done in multicast mode....the 
example code in the
Documentation does that.

>
> Another thing i overlooked when i did the review was that taskstats
> interface is designed to provide _BOTH_ per task _AND_ per thread
> accounting data EVERY TIME a task exists. A thread is an aggregate
> of (per-pid) tasks. Since this type of aggregation is not used in
> CSA, half of data traffic would be useless. Can we add a way to
> configure to not send per-thread data to the socket?

I don't see why not. We could extend the command set to set tgid sending 
on/off.

Regards,
Shailabh

> Regards,
> jay


