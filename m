Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315287AbSE2N6U>; Wed, 29 May 2002 09:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSE2N6T>; Wed, 29 May 2002 09:58:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:32773 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315282AbSE2N4s>; Wed, 29 May 2002 09:56:48 -0400
Message-ID: <3CF4CF0B.7010008@evision-ventures.com>
Date: Wed, 29 May 2002 14:52:27 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <Pine.LNX.4.44.0205291453230.19359-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Hi Marcin,
> 	Just a few comments, please don't mistake it for nitpicking, but 
> perhaps a request for clarification.

No problem at all.

> 
> On Wed, 29 May 2002, Martin Dalecki wrote:
> 
> 
>>- Don't allow check_partition to be more clever then the writer of a driver.
>>   It was interfering with drivers which check partitions as they go and
>>   finally if we want to spew something about it - we can do it ourself.
> 
> 
> Should this really be the case? Isn't the driver the one that is 
> interfering in this case?

No please have a close look at the boot sequence of
the 2.5.18 kernel without the above patch applied.
It will:

1. Spew the "Paritition checks" message ony once directly after the
    detection of the drive /dev/hda geometry and then never again.

2. It will check the partitions twice, without the above message.

After hot plugging some device the above message should be
perhaps reintroduced, but right now it won't appear at all.

The ideal thing we should do would be:

Detect a channel, detect a disk on a channel, detect partitions on it.

Right now we where doing:
Look for disks, where there are disks, assume there is a channel too.
Look for all disks goemetries.
Look for all disks partitions.

Wuite worng in the context of  aproper support for hot
plugging stuff.

So I'm *very* confident about the above change.

>>   Anyway we grok the partitions now one by one as we detect the channels.
> 
> 
> Same as above.

What's your problem here - that's the proper thing to do.

