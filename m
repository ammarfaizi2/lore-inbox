Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313764AbSDZKBV>; Fri, 26 Apr 2002 06:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313769AbSDZKBV>; Fri, 26 Apr 2002 06:01:21 -0400
Received: from [195.63.194.11] ([195.63.194.11]:25860 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313764AbSDZKBU>; Fri, 26 Apr 2002 06:01:20 -0400
Message-ID: <3CC916C3.7010604@evision-ventures.com>
Date: Fri, 26 Apr 2002 10:58:43 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.10 UTS_VERSION
In-Reply-To: <13641.1019814773@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Keith Owens napisa³:
> On Fri, 26 Apr 2002 09:33:44 +0200, 
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
>>Make sure UTS_VERSION is allways in "C" locale.
>>Without it you will get (please note the day of week):
>>
>>~# export LANG=en_US
>>~# uname -a
>>Linux rosomak.prv 2.5.10 #1 pi? kwi 26 09:31:52 CEST 2002 i686 unknown
>>~#
> 
> 
> Why is that a problem?  If a user wants a kernel uname in their local
> language, kbuild has no objection.  I need LC_COLLATE=C to get a
> consistent filename ordering for kbuild but everything else, including
> build messages, date and time can be local.

Please note that this is not just a compile time problem!
The UTS_STRING is hard compiled *in to* the kernel and should
be normalized for the following reasons:

1. Consistency
2. Consistency
3. Consistency
4. Giving the uname command a chance to translate it to the peculiar locale
    of the user.
5. During boot this string will be printed to the console. This is the
    time where the system doesn't know *anything* about non ASCII character sets.
    This results in the above example for me for example in printing
    of utter garbage on the screen.
6. Kernel messages are supposed to be in LOCALE="C".

