Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270748AbRHWXgA>; Thu, 23 Aug 2001 19:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270772AbRHWXfv>; Thu, 23 Aug 2001 19:35:51 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:21010 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id <S270746AbRHWXfj>;
	Thu, 23 Aug 2001 19:35:39 -0400
Message-ID: <3B859349.95F09EB1@linux-m68k.org>
Date: Fri, 24 Aug 2001 01:35:38 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Magnus Naeslund(f)" <mag@fbab.net>
CC: raybry@timesn.com, Tim Walberg <twalberg@mindspring.com>,
        linux-kernel@vger.kernel.org
Subject: Re: macro conflict
In-Reply-To: <20010823143440.G20693@mindspring.com> <3B85615A.58920036@timesn.com> <03fc01c12c10$8155b060$020a0a0a@totalmef>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

"Magnus Naeslund(f)" wrote:

> > min(x,y) = ({typeof((x)) __x=(x), __y=(y); (__x < __y) ? __x : __y})
> >
> > That gets you the correct "evaluate the args once" semantics and gives
> > you control over typing (the comparison is done in the type of the
> > first argument) and we don't have to change a zillion drivers.
> >
> > (typeof() is a gcc extension.)

({...}) is also gcc extension.

> But then again, how do you know it's the type of x we want, maybe we want
> type of y, that is and signed char (not an int like x).
> Talk about hidden buffer overflow stuff :)

That's the reason I'm using this macro for affs:

#define MIN(a, b) ({            \
        typeof(a) _a = (a);     \
        typeof(b) _b = (b);     \
        _a < _b ? _a : _b;      \
})

I need a very good reason to use something else, so far I'm unconvinced.

bye, Roman
