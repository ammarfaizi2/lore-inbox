Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272345AbRH3RNx>; Thu, 30 Aug 2001 13:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272346AbRH3RNn>; Thu, 30 Aug 2001 13:13:43 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:29337 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S272345AbRH3RN3>;
	Thu, 30 Aug 2001 13:13:29 -0400
Message-ID: <3B8E7443.2A66531F@linux-m68k.org>
Date: Thu, 30 Aug 2001 19:13:39 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        David Lang <david.lang@digitalinsight.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108300909560.7973-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

>         static int unix_mkname(struct sockaddr_un * sunaddr, int len, unsigned *hashp)
>         {
>                 if (len <= sizeof(short) || len > sizeof(*sunaddr))
>                         return -EINVAL;
>                 ...
> 
> Would you agree that the above is _good_ code, and code that makes
> perfect sense, and code that does exactly the right thing in testing its
> arguments?

Where is the problem to change the type into "unsigned int"?

> Face it, you don't know what you're talking about.

Sorry, but what makes you so sure about it?
Anyway, forget -Wsign-compare, but could you _please_ give me an answer
to my other arguments? Maybe I'm a stupid idiot, but then please
enlighten me and show me the right way. So here is the important part of
my mail again:

This is my last attempt to get things IMO right. Most of the arguments
for the new macro were about bugs of the past. No question about this,
this had to be fixed, I'm not arguing about this at all.

I'm trying to get your attention to the bugs of the future. I still
don't understand why you think the new macro will be any better. Why do
you think the average kernel hacker will think about the type of the
compare and will come to the correct conclusion? It's far too easy to
use an int as type argument and forget about it. gcc won't warn about
this, so someone first has to hit this bug, before it gets fixed.

Maybe I'm too dumb, but I still fail to see, what sense it should make
to turn a signed compare into an unsigned one. Either one knows both
signed values are only positive, then the sign of the compare and the
destination doesn't matter at all. If the value could be negative,
better test it explicit:

        if (len < 0 || len > MAX)
                len = MAX;

First, it's far more readable and makes the intention so clear, that
even your average kernel hacker understands it. Second, gcc produces
exactly the same code with this, so there is no need to play type tricks
with the min macro.

Please reconsider your decision. IMVHO the new macros are a mistake and
will cause only more trouble than they are worth.

bye, Roman
