Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293437AbSB1RGp>; Thu, 28 Feb 2002 12:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293445AbSB1RDm>; Thu, 28 Feb 2002 12:03:42 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:13072 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S293489AbSB1RBp>; Thu, 28 Feb 2002 12:01:45 -0500
Date: Thu, 28 Feb 2002 08:59:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Woodhouse <dwmw2@infradead.org>
cc: <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: recalc_sigpending() / recalc_sigpending_tsk() ?
In-Reply-To: <22659.1014913885@redhat.com>
Message-ID: <Pine.LNX.4.33.0202280854250.15607-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Feb 2002, David Woodhouse wrote:
>
> It seems that the name of the function was changed to recalc_sigpending_tsk()
> and a new function called recalc_sigpending() was added.

Yes.

> Was there a reason for doing this, rather than just introducing the new
> function with a different name, such as recalc_sigpending_cur()? It breaks
> 2.4 source compatibility in a way that seems entirely gratuitous.

I don't care. I care 1000% more about clean code than about backwards
source level compatibility.

99% of all users did it for the current task, and for the current task
only. And the non-local users were all in low-level core code (and should
_not_ exist anywhere else - if some driver is playing around with another
tasks signal state, that driver is so incredibly fundamentally broken that
I don't even want to hear about it)

In short, the 2.5.x interface is the correct one.

> Before I have to go and do something evil in my compatmac.h to work round
> this, is there any chance of putting the original recalc_sigpending() back?

Not a chance in hell. The backwards compatibility looks like a trivial
one-liner:

   compat-2.4.h:
	#define recalc_sigpending() recalc_sigpending(current)

so what are you complaining about?

		Linus

