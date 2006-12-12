Return-Path: <linux-kernel-owner+w=401wt.eu-S1751131AbWLLEJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbWLLEJJ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 23:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWLLEJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 23:09:09 -0500
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:37820 "EHLO sMtp.neuf.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751133AbWLLEJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 23:09:08 -0500
Date: Tue, 12 Dec 2006 05:09:23 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] Introduce jiffies_32 and related compare functions
In-reply-to: <20061211.195737.71090466.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Message-id: <457E2B73.9040307@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <457DE27E.5000100@cosmosbay.com>
 <20061211.173100.74720551.davem@davemloft.net>
 <457E2642.2000103@cosmosbay.com> <20061211.195737.71090466.davem@davemloft.net>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller a écrit :
> From: Eric Dumazet <dada1@cosmosbay.com>
> Date: Tue, 12 Dec 2006 04:47:14 +0100
> 
>> I doubt being able to extend the expiration of a dst above 2^32
>> ticks (49 days if HZ=1000, 198 days if HZ=250) is worth the ram
>> wastage.
> 
> And this doesn't apply for all jiffies uses because? :-)
> 
> That's the point I'm trying to make and get a discussion on.
> 
> 

Ah ok :)

Maybe my intentions were not clear :

I am not suggesting replacing all jiffies to jiffies_32. Just *selected* ones :)

BTW, the real limit is 2^31 ticks, so its 24 days.

We definitly *like* being able to use bigger timeouts on 64bits platforms.

Not that they are mandatory since the same application should run fine on 
32bits kernel. But as the standard type for 'tick timestamps' is 'unsigned 
long', a change would be invasive.

Maybe some applications are now relying on being able to 
sleep()/select()/poll() for periods > 30 days and only run on 64 bits kernels.

Eric
