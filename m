Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264958AbTK3RTh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbTK3RTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:19:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22194 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264958AbTK3RS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:18:58 -0500
Message-ID: <3FCA2672.8020202@pobox.com>
Date: Sun, 30 Nov 2003 12:18:42 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1220.2040508@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl> <20031130162523.GV10679@suse.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de>
In-Reply-To: <20031130165146.GY10679@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Nov 30 2003, Jeff Garzik wrote:
>>fond of partial completions, as I feel they add complexity, particularly 
>>so in my case:  I can simply use the same error paths for both the 
>>single-sector taskfile and the "everything else" taskfile, regardless of 
>>which taskfile throws the error.
> 
> 
> It's just a questions of maintaining the proper request state so you
> know how much and what part of a request is pending. Requests have been
> handled this way ever since clustered requests, that is why
> current_nr_sectors differs from nr_sectors. And with hard_* duplicates,
> it's pretty easy to extend this a bit. I don't see this as something
> complex, and if the alternative you are suggesting (your implementation
> idea is not clear to me...) is to fork another request then I think it's
> a lot better.
[snip howto]

Yeah, I know how to do partial completions.  The increased complexity 
arises in my driver.  It's simply less code in my driver to treat each 
transaction as an "all or none" affair.

For the vastly common case, it's less i-cache and less interrupts to do 
all-or-none.  In the future I'll probably want to put partial 
completions in the error path...


>>(thinking out loud)  Though best for simplicity, I am curious if a 
>>succession of "tiny/huge" transaction pairs are efficient?  I am hoping 
>>that the drive's cache, coupled with the fact that each pair of 
>>taskfiles is sequentially contiguous, will not hurt speed too much over 
>>a non-errata configuration...
> 
> 
> My gut would say rather two 64kb than a 124 and 4kb. But you should do
> the numbers, of course :). I'd be surprised if the former wouldn't be
> more efficient.

That's why I was thinking out loud, and also why I CC'd Eric :)  We'll 
see.  I'll implement whichever is easier first, which will certainly be 
better than the current sledgehammer limit.  Any improvement over the 
current code will provide dramatic performance increases, and we can 
tune after that...

	Jeff



