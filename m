Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289115AbSAJBVa>; Wed, 9 Jan 2002 20:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289112AbSAJBVU>; Wed, 9 Jan 2002 20:21:20 -0500
Received: from nile.gnat.com ([205.232.38.5]:33427 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S289111AbSAJBVL>;
	Wed, 9 Jan 2002 20:21:11 -0500
From: dewar@gnat.com
To: groudier@free.fr, jamagallon@able.es
Subject: Re: [PATCH] C undefined behavior fix
Cc: Dautrevaux@microprocess.com, dewar@gnat.com, gcc@gcc.gnu.org,
        jtv@xs4all.nl, linux-kernel@vger.kernel.org, paulus@samba.org,
        tim@hollebeek.com, trini@kernel.crashing.org, velco@fadata.bg
Message-Id: <20020110012109.E80C0F2FEB@nile.gnat.com>
Date: Wed,  9 Jan 2002 20:21:09 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<Grrr. I really do not know why people is making so noise about volatile.
Don't look for esoteric meanings, it is just 'don't suppose ANYTHING
about this memory location, it CAN CNAHGE apart from anything you can
see or guess'.
>>

Nope, that's not enough, it's not that simple. Yes your
example of a-a is of course straightforward but what about

    b = (a & 1) | (b & 1);

if a is volatile and b is known to be odd, can the read of a be eliminated?
The answer should be no (and I think the standard guarantees this), but the
reasoning is completely different from thinking about the fact that a may
change unexpectedly, since obviously no matter what value comes from
reading a, b will be set to 1 if b is known to be odd.

Of course you can provide a pragmatic justification, think of a as a hardware
counter that counts the number of times it is referenced, then this should
count as a reference, even though on an as-if basis b would have the same
value.

The Ada standard says it clearly: a read or write of a volatile variable
is an external effect. period.
