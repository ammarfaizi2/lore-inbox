Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316361AbSEOKu3>; Wed, 15 May 2002 06:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316374AbSEOKu2>; Wed, 15 May 2002 06:50:28 -0400
Received: from [195.63.194.11] ([195.63.194.11]:47623 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316361AbSEOKu1>; Wed, 15 May 2002 06:50:27 -0400
Message-ID: <3CE22EA8.60905@evision-ventures.com>
Date: Wed, 15 May 2002 11:47:20 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE PIO write Fix #2
In-Reply-To: <3CE0795B.62C956F0@cinet.co.jp> <3CE0D6DE.8090407@evision-ventures.com> <abroiv$ifs$1@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Linus Torvalds napisa³:
> In article <3CE0D6DE.8090407@evision-ventures.com>,
> Martin Dalecki  <dalecki@evision-ventures.com> wrote:
> 
>>>--- linux-2.5.15/drivers/ide/ide-taskfile.c.orig	Fri May 10 11:49:35 2002
>>>+++ linux-2.5.15/drivers/ide/ide-taskfile.c	Tue May 14 10:40:43 2002
>>>@@ -606,7 +606,7 @@
>>> 		if (!ide_end_request(drive, rq, 1))
>>> 			return ide_stopped;
>>> 
>>>-	if ((rq->current_nr_sectors==1) ^ (stat & DRQ_STAT)) {
>>>+	if ((rq->nr_sectors == 1) ^ ((stat & DRQ_STAT) != 0)) {
>>
> 
> Well, that's definitely an improvement - the original code makes no
> sense at all, since it's doing a bitwise xor on two bits that are not
> the same, and then uses that as a boolean value.
> 
> Your change at least makes it use the bitwise xor on properly logical
> values, making the bitwise xor work as a _logical_ xor. 
> 
> Although at that point I'd just get rid of the xor, and replace it by
> the "!=" operation - which is equivalent on logical ops.
> 
> 
>>> 		pBuf = ide_map_rq(rq, &flags);
>>> 		DTF("write: %p, rq->current_nr_sectors: %d\n", pBuf, (int) rq->current_nr_sectors);
>>
>>
>>Hmm. There is something else that smells in the above, since the XOR operator
>>doesn't seem to be proper. Why shouldn't we get DRQ_STAT at all on short
>>request? Could you perhaps just try to replace it with an OR?
> 
> 
> The XOR operation is a valid op, if you just use it on valid values,
> which the patch does seem to make it do.
> 
> I don't know whether the logic is _correct_ after that, but at least
> there is some remote chance that it might make sense.
> 
> 		Linus

As far as I can see the patch makes sense. It is just exposing a problem
which was hidden before.

