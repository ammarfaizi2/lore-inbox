Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315760AbSHIUhV>; Fri, 9 Aug 2002 16:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315762AbSHIUhV>; Fri, 9 Aug 2002 16:37:21 -0400
Received: from [195.63.194.11] ([195.63.194.11]:57861 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315760AbSHIUhT>; Fri, 9 Aug 2002 16:37:19 -0400
Message-ID: <3D54279B.2050500@evision.ag>
Date: Fri, 09 Aug 2002 22:35:39 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.1) Gecko/20020724
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: martin@dalecki.de, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.30 IDE 115
References: <3D53AE13.7060907@evision.ag> <20020809134839.GO2243@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Fri, Aug 09 2002, Marcin Dalecki wrote:
> 
>>- Fix small typo introduced in 113, which prevented CD-ROMs from
>>  working altogether.
> 
> 
> Have you fixed the sense reporting issue I told you about months ago?

Well at least ide-116 will start to unify the corresponding code.
But please don't expecty anything "revolutionary" yet... Just for
example using GPCMD_ constants throughout the code and a unified error
dissection function. One of the issues involved is rq->buffer in
ide-floppy versus rq->special in ide-cd.c


>>- Eliminate block_ioctl(). This code can't be shared in the way
>>  proposed by this file. We will port it to the proper
>>  blk_insert_request() soon. This will eliminate the _elv_add_request()
>>  "layering violation".
> 
> 
> What are you talking about?

Hmm, so apparently you where not the one who "inventid" it?

Anyway I talk about the block_ioctl.c file, which was supposed
to contain the two eject ioctl functions for "generic" packet code.
But since we don't have any kind of "generic" packet commands this
didn't make much sense.

It was inventing a function called blk_do_rq(), which was using
elv_add_request(). You called this not a long time ago a "layering
violation" yourself. And I simply intend to replace it in one of the
forthcomming patches  with the recently inventid blk_insert_request() 
function.

Oh, I realize I didn't express myself properly. I certinaly don't intend
to eliminate elv_add_request() itself any time soon ;-).

