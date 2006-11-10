Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932857AbWKJQi3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932857AbWKJQi3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 11:38:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932858AbWKJQi3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 11:38:29 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:50080 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932857AbWKJQi2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 11:38:28 -0500
Message-ID: <4554ACE6.8030709@sw.ru>
Date: Fri, 10 Nov 2006 19:46:30 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Cedric Le Goater <cedric@legoater.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, xemul@openvz.org, devel@openvz.org,
       oleg@tv-sign.ru, hch@infradead.org, matthltc@us.ibm.com,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [PATCH 1/13] BC: atomic_dec_and_lock_irqsave() helper
References: <45535C18.4040000@sw.ru> <45535CFA.5080601@sw.ru> <45549889.5000300@legoater.org>
In-Reply-To: <45549889.5000300@legoater.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello Kirill, Hello Pavel,
> 
> Kirill Korotaev wrote:
> 
>>Oleg Nesterov noticed to me that the construction like
>>(used in beancounter patches and free_uid()):
>>
>>  local_irq_save(flags);
>>  if (atomic_dec_and_lock(&refcnt, &lock))
>>	  ...
>>
>>is not that good for preemtible kernels, since with preemption
>>spin_lock() can schedule() to reduce latency. However, it won't schedule
>>if interrupts are disabled.
>>
>>So this patch introduces atomic_dec_and_lock_irqsave() as a logical
>>counterpart to atomic_dec_and_lock().
> 
> 
> You should probably send that one independently from the BC 
> patchset. 
Maybe, but BCs are the only user of this so far...

Thanks,
Kirill


