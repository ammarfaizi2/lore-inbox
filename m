Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161459AbWJaHlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161459AbWJaHlw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 02:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161571AbWJaHlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 02:41:52 -0500
Received: from sp604005mt.neufgp.fr ([84.96.92.11]:9426 "EHLO smtp.Neuf.fr")
	by vger.kernel.org with ESMTP id S1161459AbWJaHlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 02:41:51 -0500
Date: Tue, 31 Oct 2006 08:41:45 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [PATCH] splice : two smp_mb() can be omitted
In-reply-to: <20061031073212.GW14055@kernel.dk>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Message-id: <4546FE39.8000201@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <1162199005.24143.169.camel@taijtu>
 <20061030224802.f73842b8.akpm@osdl.org> <4546FA81.1020804@cosmosbay.com>
 <20061031073212.GW14055@kernel.dk>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe a écrit :
> On Tue, Oct 31 2006, Eric Dumazet wrote:
>> This patch deletes two calls to smp_mb() that were done after 
>> mutex_unlock() that contains an implicit memory barrier.
>>
>> The first one in splice_to_pipe(), where 'do_wakeup' is set to true only if 
>> pipe->inode is set (and in this case the
>> if (pipe->inode)
>>    mutex_unlock(&pipe->inode->i_mutex);
>> is done too)
>>
>> The second one in link_pipe(), following inode_double_unlock() that 
>> contains calls to mutex_unlock() too.
> 
> NAK on that patch, the smp_mb() follows the waitqueue_active(). If you
> later change the code and move the locks or whatnot, you have lost that
> connection.
> 
> If you change the patch to insert a comment, then it may be more
> applicable.
> 

Hum... I read fs/pipe.c and see no smp_mb() there, but I suspect same 
semantics are/were used.

Should we add comments on fs/pipe.c too ?

Eric
