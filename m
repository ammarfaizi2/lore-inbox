Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSG3UHx>; Tue, 30 Jul 2002 16:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316532AbSG3UHx>; Tue, 30 Jul 2002 16:07:53 -0400
Received: from [64.105.35.245] ([64.105.35.245]:25770 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S316465AbSG3UHw>; Tue, 30 Jul 2002 16:07:52 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 30 Jul 2002 13:10:47 -0700
Message-Id: <200207302010.NAA04198@baldur.yggdrasil.com>
To: martin@dalecki.de
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
>Adam J. Richter wrote:

>> 	That said, I think all the "lock group" logic in drivers/ide
>> may be useless, and it would be pretty straightforward to delete all
>> that code, have ata_channel->lock be a lock rather than a pointer to one,
>> and have it be initialized before that first call to ch->tuneproc, in
>> which case we could just have interrupts off and ch->lock held in all
>> cases when ch->tuneproc is called.  I did not want to do this in my patch,
>> because I wanted to keep my patch as small as possible, but perhaps it
>> would be worth doing now just to simplify the rules for calling ch->tuneproc.

>Not quite. It's not that easy becouse the same lock is used by the BIO
>layer to synchronize between for example master and slave devices.

	Master and slave devices share the same channel, so

		master->channel		== slave->channel
		&master->channel->lock	== &slave->channel->lock

	So their queue->lock pointer would continue to point to
the same lock: &channel->lock.

>There are other problems with this but right now you can hardly do 
>something about it.

	I'd be intersted in knowing what one of those other problems
is.  Otherwise, I don't understand why I can't eliminate the "lock
group" stuff.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
