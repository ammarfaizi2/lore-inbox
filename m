Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317230AbSG2NwE>; Mon, 29 Jul 2002 09:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317251AbSG2NwE>; Mon, 29 Jul 2002 09:52:04 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25872 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317230AbSG2NwE>; Mon, 29 Jul 2002 09:52:04 -0400
Message-ID: <3D454823.4010204@evision.ag>
Date: Mon, 29 Jul 2002 15:50:27 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction
References: <200207291344.g6TDiCR11064@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> axboe@suse.de said:
> 
>>Ok... I had two issues with the patch. 1) it did
>>	rq->flags &= REQ_QUEUED; 
> 
> 
> Yes, that was inherited from SCSI.  Previously it just cleared flags and then 
> set REQ_BARRIER|REQ_SPECIAL.  Now I needed to clear flags but preserve the 
> state of REQ_QUEUED, which is what that code is doing, otherwise the 
> blk_rq_tagged() would always fail lower down.
> 
> 
>>I'll back down, it's not a matter of life and death after all. Here's
>>the minimal patch that corrects the flag thing, and also makes
>>blk_insert_request() conform to kernel style. Are we all happy? 
> 
> 
> I'm happy (as long as it works on my SCSI card).
> 
> James


BTW.> I just noticed quite a "bunch" of single line functions in the
SCIS code. Sort of like:

int scsi_warp_foo(xxx)
{
      foor(whis and that);
}.

EXPORT_SYMBOL(scsi_wrap_foo);

All of them just eat space on the stack during execution.
Would you mind moving them over to scsi.h and making them static inline?

We all know that SCSI has sometimes problems with the limited stack 
depth during kernel code execution time, esp on "Black Big Boxen"...
Well the above "tactics" doesn't hlep buch, but a bit is a bit is a bit 
and "a man/farmer doesn't foregive someone still alive"... :-).


