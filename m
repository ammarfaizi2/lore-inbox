Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261591AbVC2WQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261591AbVC2WQH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVC2WPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:15:30 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:36741 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261558AbVC2WOn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:14:43 -0500
Message-ID: <4249D4C7.90808@tmr.com>
Date: Tue, 29 Mar 2005 17:20:55 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: "Chen, Kenneth W" <kenneth.w.chen@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] new fifo I/O elevator that really does nothing at all
References: <200503290148.j2T1mOg25279@unix-os.sc.intel.com><200503290148.j2T1mOg25279@unix-os.sc.intel.com> <20050329080559.GD16636@suse.de>
In-Reply-To: <20050329080559.GD16636@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Mar 28 2005, Chen, Kenneth W wrote:
> 
>>The noop elevator is still too fat for db transaction processing
>>workload.  Since the db application already merged all blocks before
>>sending it down, the I/O presented to the elevator are actually not
>>merge-able anymore. Since I/O are also random, we don't want to sort
>>them either.  However the noop elevator is still doing a linear search
>>on the entire list of requests in the queue.  A noop elevator after
>>all isn't really noop.
>>
>>We are proposing a true no-op elevator algorithm, no merge, no
>>nothing. Just do first in and first out list management for the I/O
>>request.  The best name I can come up with is "FIFO".  I also piggy
>>backed the code onto noop-iosched.c.  I can easily pull those code
>>into a separate file if people object.  Though, I hope Jens is OK with
>>it.
> 
> 
> It's not quite ok, because you don't honor the insertion point in
> fifo_add_request. The only 'fat' part of the noop io scheduler is the
> merge stuff, the original plan was to move that to a hash table lookup
> instead like the other io schedulers do. So I would suggest just
> changing noop to hash the request on the end point for back merges and
> forget about front merges, since they are rare anyways. Hmm actually,
> the last merge hint should catch most of the merges at almost zero cost.

Making the noop faster is clearly a good thing, but some database 
software may depend on transaction order as provided by a true fifo 
process. It would be nice to have both.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
