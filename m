Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268813AbRHWXPS>; Thu, 23 Aug 2001 19:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270705AbRHWXPJ>; Thu, 23 Aug 2001 19:15:09 -0400
Received: from smtp-out.hamburg.pop.de ([195.222.210.86]:18449 "EHLO
	smtp-out.hamburg.pop.de") by vger.kernel.org with ESMTP
	id <S268813AbRHWXOx>; Thu, 23 Aug 2001 19:14:53 -0400
Message-ID: <3B858F62.AD7CED14@gmx.net>
Date: Fri, 24 Aug 2001 01:18:58 +0200
From: Andrew Cannon <ajc@gmx.net>
Organization: Fairlight ESP R&D Europe
X-Mailer: Mozilla 4.75 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: "Magnus Naeslund(f)" <mag@fbab.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: macro conflict
In-Reply-To: <20010823143440.G20693@mindspring.com> <3B85615A.58920036@timesn.com> <03fc01c12c10$8155b060$020a0a0a@totalmef>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



"Magnus Naeslund(f)" wrote:
> 
> From: <raybry@timesn.com>
> > Without digging through the archives to see if this has already
> > been suggested (if so, I apologize), why can't the following be done:
> >
> > min(x,y) = ({typeof((x)) __x=(x), __y=(y); (__x < __y) ? __x : __y})
> >
> > That gets you the correct "evaluate the args once" semantics and gives
> > you control over typing (the comparison is done in the type of the
> > first argument) and we don't have to change a zillion drivers.
> >
> > (typeof() is a gcc extension.)
> >
> 
> But then again, how do you know it's the type of x we want, maybe we want
> type of y, that is and signed char (not an int like x).
> Talk about hidden buffer overflow stuff :)


What about this then:

#define min(x,y) ({typeof(x) __x=(x); typeof(y) __y=(y); (__x < __y) ?
__x : __y})

This is guaranteed to work the same as the old min/max in all cases but
without side effects. You can still force the comparison to be done with
a certain type by casting the arguments first:

#define typed_min(type, x, y) (min((type)(x), (type)(y)))

...although, if the type used for the comparison is so critical you
maybe shouldn't be hiding it in a macro anyway.

Andrew
