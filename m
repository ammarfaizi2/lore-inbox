Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932466AbWFGXpg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932466AbWFGXpg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 19:45:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWFGXpg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 19:45:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:12759 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932466AbWFGXpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 19:45:36 -0400
Message-ID: <44876510.1050808@engr.sgi.com>
Date: Wed, 07 Jun 2006 16:45:20 -0700
From: Jay Lan <jlan@engr.sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060411
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@watson.ibm.com>
CC: Balbir Singh <balbir@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, csturtiv@sgi.com,
       jamal <hadi@cyberus.ca>
Subject: Re: taskstats interface for accounting
References: <44863376.5020701@sgi.com> <44864030.6010906@watson.ibm.com>
In-Reply-To: <44864030.6010906@watson.ibm.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh Nagar wrote:
> Jay Lan wrote:
>
>> Hi Balbir and Shailabh,
>>
>> I finally have time to think about implementation details of CSA over
>> taskstats interface. I took another look at the taskstats interface
>> proposal and was a little bit nervous.
>>
>> Do you remember i suggested to use #ifdef to cut down traffic and i
>> was told a generic netlink header would serve the purpose?
>> What i see now at Documentation/accounting/taskstats.txt saying
>> NETLINK_GENERIC family is used for unicast query/reply mode. The
>> NETLINK_GENERIC family provides great flexsibility on what to
>> receive. However, CSA only uses the multicast mode to receive from
>> kernel
>> whenever tasks are existing. I guess i would need to read the netlink
>> documentation more carefully to see whether my understanding is
>> correct.
>
> I don't think there's a problem here. The netlink socket opened for
> listening to
> taskstat data sent on task exit can be done in multicast mode....the
> example code in the
> Documentation does that.
>
>>
>> Another thing i overlooked when i did the review was that taskstats
>> interface is designed to provide _BOTH_ per task _AND_ per thread
>> accounting data EVERY TIME a task exists. A thread is an aggregate
>> of (per-pid) tasks. Since this type of aggregation is not used in
>> CSA, half of data traffic would be useless. Can we add a way to
>> configure to not send per-thread data to the socket?
>
> I don't see why not. We could extend the command set to set tgid
> sending on/off.

This would be great!

But, we can have a number of applications listening on the socket. We
surely do not want applications to send conflicting commands to the kernel.
Maybe we can make it a /etc/sysconfig option.

Regards,
 - jay

>
> Regards,
> Shailabh
>
>> Regards,
>> jay
>
>

