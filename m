Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316885AbSEVHxS>; Wed, 22 May 2002 03:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316886AbSEVHxR>; Wed, 22 May 2002 03:53:17 -0400
Received: from [195.63.194.11] ([195.63.194.11]:26381 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316885AbSEVHxQ>; Wed, 22 May 2002 03:53:16 -0400
Message-ID: <3CEB3F93.7030508@evision-ventures.com>
Date: Wed, 22 May 2002 08:49:55 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
In-Reply-To: <Pine.LNX.4.33.0205211557410.1307-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> On Wed, 22 May 2002, Pavel Machek wrote:
> 
>>Major parts are: process stopper, S3 specific code, S4 specific
>>code. What can I do to make this applied?
> 
> 
> Applied. Nothing needed but some time for me to look through it.
> 
> It still has a few too many #ifdef CONFIG_SUSPEND, and I get this feeling 
> that the background deamons shouldn't need to do the "freeze()" by hand 
> but simply be automatically frozen and thawed when they sleep by looking 
> at the KERNTHREAD bit or something, but..

Oh and please reject the idea of compressing the pages
you are writing to disk for the following reaons:

1. compression is not deterministic in terms of the possible space
savings, you will still have to provide the required amount of space.

2. every compression algorithm has theoretical cases where the
compression mechanism is actually increasing the space requirements.

3. Compressing around 360 Mbytes of data will take quite a lot
of time.

4. Point 3 will make the CPU go high - not nice if the suspend
happens in case of battery emergency...

Anyway it's time to repartition my notebook :-).

