Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUK2W4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUK2W4Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:56:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbUK2WyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:54:21 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:1966 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261866AbUK2Wva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:51:30 -0500
Message-ID: <41ABA6EE.6080502@tmr.com>
Date: Mon, 29 Nov 2004 17:47:10 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jesper Juhl <juhl-lkml@dif.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2/2] ide-tape: small cleanups - handle   copy_to|from_user()
 failures
References: <Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost><Pine.LNX.4.61.0411281731050.3389@dragon.hygekrogen.localhost> <1101663266.16761.43.camel@localhost.localdomain>
In-Reply-To: <1101663266.16761.43.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sul, 2004-11-28 at 16:32, Jesper Juhl wrote:
> 
>> #endif /* IDETAPE_DEBUG_BUGS */
>> 		count = min((unsigned int)(bh->b_size - atomic_read(&bh->b_count)), (unsigned int)n);
>>-		copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count);
>>+		if (copy_from_user(bh->b_data + atomic_read(&bh->b_count), buf, count))
>>+			return -EFAULT;
>> 		n -= count;
>> 		atomic_add(count, &bh->b_count);
>> 		buf += count;
> 
> 
> If you do this then you don't fix up tape->bh for further operations.
> Have you tested these changes including the I/O errors ?

But (a) do you have enough information to backout or fixup correctly? 
And (b) won't this result in the whole i/o being treated as invalid?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

