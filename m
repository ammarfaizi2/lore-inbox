Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbTERSBV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 14:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTERSBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 14:01:21 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:41856 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262151AbTERSBU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 14:01:20 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 18 May 2003 11:13:18 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mcafeelabs.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlocks. Shoot.
In-Reply-To: <200305180921.h4I9LdD13274@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.55.0305181109540.3568@bigblue.dev.mcafeelabs.com>
References: <200305180921.h4I9LdD13274@oboe.it.uc3m.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 May 2003, Peter T. Breuer wrote:

>
> Here's a before-breakfast implementation of a recursive spinlock. That
> is, the same thread can "take" the spinlock repeatedly. This is crude -
> I just want to focus some attention on the issue (while I go out and
> have breakfast :'E).
>
> The idea is to implement trylock correctly, and then get lock and
> unlock from that via the standard algebra. lock is a loop doing
> a trylock until it succeeds. We emerge from a successful trylock
> with the lock notionally held.
>
> The "spinlock" is a register of the current pid, plus a recursion
> counter, with atomic access.  The pid is either -1 (unset, count is
> zero) or some decent value (count is positive).
>
> The trylock will succeed and set the pid if it is currently unset.  It
> will succeed if the pid matches ours, and increment the count of
> holders.
>
> Unlock just decrements the count.  When we've unlocked enough times,
> somebody else can take the lock.

A looong time ago I gave to someone a recursive spinlock implementation
that they integrated in the USB code. I don't see it in the latest
kernels, so I have to guess that they found a better solution to do their
things. I'm biased to say that it must not be necessary to have the thing
if you structure your code correctly.



- Davide

