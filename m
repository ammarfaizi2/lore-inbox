Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbULQF0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbULQF0I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 00:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262749AbULQF0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 00:26:08 -0500
Received: from [62.206.217.67] ([62.206.217.67]:26301 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S262744AbULQF0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 00:26:02 -0500
Message-ID: <41C26DD1.7070006@trash.net>
Date: Fri, 17 Dec 2004 06:25:37 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Bryan Fulton <bryan@coverity.com>, netdev@oss.sgi.com,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [Coverity] Untrusted user data in kernel
References: <Xine.LNX.4.44.0412170012040.12382-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0412170012040.12382-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

>This at least needs CAP_NET_ADMIN.
>
It is already checked in do_ip6t_set_ctl(). Otherwise anyone could
replace iptables rules :)

Regards
Patrick

>
>On Thu, 16 Dec 2004, Bryan Fulton wrote:
>  
>
>>////////////////////////////////////////////////////////
>>// 3:   /net/ipv6/netfilter/ip6_tables.c::do_replace  //
>>////////////////////////////////////////////////////////
>> 
>>- tainted unsigned scalar tmp.num_counters multiplied and passed to
>>vmalloc (1161) and memset (1166) which could overflow or be too large
>>
>>Call to function "copy_from_user" TAINTS argument "tmp"
>>
>>1143            if (copy_from_user(&tmp, user, sizeof(tmp)) != 0)
>>1144                    return -EFAULT;
>>
>>...
>>
>>TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
>>sink.
>>
>>1161            counters = vmalloc(tmp.num_counters * sizeof(struct
>>ip6t_counters));
>>1162            if (!counters) {
>>1163                    ret = -ENOMEM;
>>1164                    goto free_newinfo;
>>1165            }
>>
>>TAINTED variable "((tmp).num_counters * 16)" was passed to a tainted
>>sink.
>>
>>1166            memset(counters, 0, tmp.num_counters * sizeof(struct
>>ip6t_counters));
>>
>>    
>>
>
>  
>

