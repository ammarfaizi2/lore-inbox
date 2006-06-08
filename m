Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964929AbWFHShS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964929AbWFHShS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 14:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWFHShS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 14:37:18 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:17547 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964929AbWFHShQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 14:37:16 -0400
Date: Thu, 08 Jun 2006 14:36:40 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: Merge of per task delay accounting (was Re: 2.6.18 -mm merge plans)
In-reply-to: <20060608104224.b2fe8c60.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: balbir@in.ibm.com, linux-kernel@vger.kernel.org, jlan@engr.sgi.com,
       peterc@gelato.unsw.edu.au
Message-id: <44886E38.3090809@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <20060604135011.decdc7c9.akpm@osdl.org>
 <4484D25E.4020805@in.ibm.com> <4486017F.8030308@watson.ibm.com>
 <20060606154034.10147da7.akpm@osdl.org> <448833E2.6000608@watson.ibm.com>
 <20060608104224.b2fe8c60.akpm@osdl.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>On Thu, 08 Jun 2006 10:27:46 -0400
>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>
>  
>
>>Andrew Morton wrote:
>>
>>    
>>
>>>On Tue, 06 Jun 2006 18:28:15 -0400
>>>Shailabh Nagar <nagar@watson.ibm.com> wrote:
>>>
>>> 
>>>
>>>      
>>>
>>>>So, we have a good consensus from existing/potential users of taskstats and would
>>>>very much appreciate it being included in 2.6.18.
>>>>   
>>>>
>>>>        
>>>>
>>>Yes, for 2.6.18 I'm inclined to send taskstats and to continue to play
>>>wait-and-see on the statistics infrastructure.  Greg is taking a look at
>>>the stats code, which is good.
>>>
>>> 
>>>
>>>      
>>>
>>Thanks !
>>
>>The suggestion from  Jay Lan to extend the interface by making sending 
>>of tgid stats configurable
>>is quite reasonable and can be done relatively simply:
>>set some parameter, either by sending a separate command (verify sender 
>>is privileged) or by
>>some sysfs parameter and use that to control sending of tgid stats on 
>>task exit (as well as allocation of
>>any tgid stat related structures).
>>    
>>
>
>hm.  Is it possible to check the privileges of a netlink message sender?
>  
>
Not entirely sure. But there's a check in net/netlink/genetlink.c: 
genl_rcv_msg()
for
if ((ops->flags & GENL_ADMIN_PERM) && security_netlink_recv(skb))
{    err = -EPERM;
    goto errout;
}

and security_netlink_recv(skb), normally set to cap_netlink_recv, checks 
on the skb's effective capability
being CAP_NET_ADMIN which I thought would be sufficient.
Need to look further.

If it doesn't turn out to fit properly, sysfs config variable can be used.

>>Would you recommend we submit a patch for it now or wait till after 
>>delay accounting has gone into
>>2.6.18 ?
>>    
>>
>
>Earlier, please.
>  
>
Ok. will submit asap.

>  
>
>>Such requests for extending the interface are likely to happen as more 
>>users start using the interface.
>>But since any patch will need some testing etc. and we are very close to 
>>the 2.6.18 merge window, I
>>wanted your advice on whether this should wait until later.
>>    
>>
>
>If it's merged, we'll have a couple more months to test it, and to fix any
>little problems.
>  
>
Sounds good.


Thanks,
Shailabh

