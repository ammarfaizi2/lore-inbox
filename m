Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280779AbRKSXwb>; Mon, 19 Nov 2001 18:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280782AbRKSXwV>; Mon, 19 Nov 2001 18:52:21 -0500
Received: from otter.mbay.net ([206.40.79.2]:24325 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S280777AbRKSXwN> convert rfc822-to-8bit;
	Mon, 19 Nov 2001 18:52:13 -0500
From: John Alvord <jalvo@mbay.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: VM-related Oops: 2.4.15pre1
Date: Mon, 19 Nov 2001 15:52:00 -0800
Message-ID: <5m6jvtklnobls7jbufe9oioja0kc88jg3c@4ax.com>
In-Reply-To: <E165lSM-000666-00@the-village.bc.nu> <Pine.LNX.4.33.0111190833440.8103-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111190833440.8103-100000@penguin.transmeta.com>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001 08:39:29 -0800 (PST), Linus Torvalds
<torvalds@transmeta.com> wrote:

>
>On Mon, 19 Nov 2001, Alan Cox wrote:
>>
>> You can in theory get even stranger effects. Consider
>>
>> 	if(!(flag&4))
>> 	{
>> 		blahblah++;
>> 		flag|=4;
>> 	}
>>
>> The compiler is completely at liberty to turn that into
>>
>> 	test bit 2
>> 	jz 1f
>> 	inc blahblah
>> 	add #4, flag
>> 1f:
>
>That's fine - if you have two threads modifying the same variable at the
>same time, you need to lock it.
>
>That's not the case under discussion.
>
>The case under discussion is gcc writing back values to a variable that
>NEVER HAD ANY VALIDITY, even in the single-threaded case. And it _is_
>single-threaded at that point, you only have other users that test the
>value, not change it.
>
>That's not an optimization, that's just plain broken. It breaks even
>user-level applications that use sigatomic_t.
>
>And note how gcc doesn't actually do it. I'm not saying that gcc is broken
>- I' saying that gcc is NOT broken, and we depend on it being not broken.

Imagine if the storage address involved was an I/O register which was
memory mapped. An arbitrary storage of data might have disasterous
effects.

john alvord
