Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTLTVfW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 16:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTLTVfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 16:35:22 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:64735 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261605AbTLTVfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 16:35:16 -0500
Message-ID: <3FE4C084.9030807@colorfullife.com>
Date: Sat, 20 Dec 2003 22:35:00 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] [RFC,PATCH] use rcu for fasync_lock
References: <3FE492EF.2090202@colorfullife.com> <3FE4BAE3.5000609@osdl.org>
In-Reply-To: <3FE4BAE3.5000609@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

>>
>> +struct fasync_rcu_struct {
>> +    struct fasync_struct data;
>> +    struct rcu_head rcu;
>> +};
>>  
>>
> Why do needless wrapping of existing structure? Just add and rcu 
> element to it!
>
There are two independant users of fasync_struct
- networking does it's own locking and allocation and uses __kill_fasync 
directly.
- everyone else uses fasync_helper and calls kill_fasync, with the 
locking logic in fcntl.c.

I didn't convert the network code, thus I couldn't add the rcu member 
into fasync_struct.

--
    Manfred

