Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbUCVTe3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbUCVTe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:34:29 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:44687 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262325AbUCVTe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:34:26 -0500
Message-ID: <405F3FB5.4020001@colorfullife.com>
Date: Mon, 22 Mar 2004 20:34:13 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eli Cohen <mlxk@mellanox.co.il>
CC: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <405D7D2F.9050507@colorfullife.com> <52u10i2lx6.fsf@topspin.com>	<405DCDA1.3080008@colorfullife.com> <52ptb62hdt.fsf@topspin.com> <405F04B5.2090609@mellanox.co.il>
In-Reply-To: <405F04B5.2090609@mellanox.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eli Cohen wrote:

> Roland Dreier wrote:
>
>> I don't think copying all the registered memory on fork() is feasible,
>> because it's going to kill performance (especially since exec() is
>> likely to immediately follow the fork() in the child).  Also, there
>> may not be enough memory around to copy everything.
>>
>>  
>>
> Suppose a new vma flag is introduced, VM_NOCOW and an API to apply 
> this flag on a range of addreses, splitting or unifying vmas as necessary.

Something like that. But it should be hidden within a suitable 
abstraction. get_user_pages and then put_page is not stateful enough. 
Actually it's fundamentally broken for platform that need cache flush 
calls. create_page_mapping/free_page_mapping, or something like that.

And I still think that the initial implementation should copy the 
affected pages within fork() - it might be slow, but at least it's 
simple and correct. _If_ it's too slow, then it can be fixed later.

--
    Manfred



