Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130205AbQKALQx>; Wed, 1 Nov 2000 06:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130236AbQKALQn>; Wed, 1 Nov 2000 06:16:43 -0500
Received: from ns.caldera.de ([212.34.180.1]:3087 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S130205AbQKALQf>;
	Wed, 1 Nov 2000 06:16:35 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Christoph Hellwig <hch@ns.caldera.de>
Newsgroups: caldera.lists.linux.kernel
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Date: 1 Nov 2000 11:16:28 GMT
Organization: Caldera (Deutschland) GmbH
Message-ID: <8tou2c$qr3$1@ns.caldera.de>
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <20001031030838.A30461@athlon.random>
NNTP-Posting-Host: ns.caldera.de
X-Trace: ns.caldera.de 973077388 27491 212.34.180.1 (1 Nov 2000 11:16:28 GMT)
X-Complaints-To: usenet@ns.caldera.de
NNTP-Posting-Date: 1 Nov 2000 11:16:28 GMT
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>> +		map = follow_page(ptr, datain, &failed);
>> +		if (failed) {
>> +			/*
>> +			 * Page got stolen before we could lock it down.
>> +			 * Retry.
>> +			 */
>>  			spin_unlock(&mm->page_table_lock);
>> -			dprintk (KERN_ERR "Missing page in map_user_kiobuf\n");
>> -			goto out_unlock;
>> +			goto faultin;

> This is suboptimal (walks the pagetables twice if the page is just mapped). It
> should be a follow page first and handle_mm_fault only if follow page failed.

I did only forward-port the fixes from Stpehen's 2.3.99pre2 patchset
because no one else seemed to be interested. If someone with more
vm-experience (e.g. you) gets interested because of this patch: fine.

	Christoph


-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
