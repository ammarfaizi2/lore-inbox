Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272939AbTHEWsj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 18:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272944AbTHEWsj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 18:48:39 -0400
Received: from dm4-153.slc.aros.net ([66.219.220.153]:28396 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S272939AbTHEWsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 18:48:20 -0400
Message-ID: <3F303430.1080908@aros.net>
Date: Tue, 05 Aug 2003 16:48:16 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Clements <Paul.Clements@SteelEye.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
References: <3F2FE078.6020305@aros.net> <3F300760.8F703814@SteelEye.com>
In-Reply-To: <3F300760.8F703814@SteelEye.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements wrote:

>Lou Langholtz wrote:
>  
>
>>The following patch removes a race condition in the network block device
>>driver in 2.6.0*. Without this patch, the reply receiving thread could
>>end (and free up the memory for) the request structure before the
>>request sending thread is completely done accessing it and would then
>>access invalid memory.
>>    
>>
>
>Indeed, there is a race condition here. It's a very small window, but it
>looks like it could possibly be trouble on SMP/preempt kernels.
>
>This patch looks OK, but it appears to still leave the race window open
>in the error case (it seems to fix the non-error case, though). We
>probably could actually use the ref_count field of struct request to
>better fix this problem. I'll take a look at doing this, and send a
>patch out in a while.
>
>Thanks,
>Paul
>  
>
Except that in the error case, the send basically didn't succeed. So no 
need to worry about recieving a reply and no race possibility in that case.

