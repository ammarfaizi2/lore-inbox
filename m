Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbTKZTOf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 14:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbTKZTOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 14:14:35 -0500
Received: from fw.osdl.org ([65.172.181.6]:60908 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264305AbTKZTOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 14:14:34 -0500
Date: Wed, 26 Nov 2003 11:14:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Bruce Perens <bruce@perens.com>
cc: Ulrich Drepper <drepper@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
In-Reply-To: <3FC4F94F.6030801@perens.com>
Message-ID: <Pine.LNX.4.58.0311261108350.1524@home.osdl.org>
References: <20031126173953.GA3534@perens.com> <Pine.LNX.4.58.0311260945030.1524@home.osdl.org>
 <3FC4ED5F.4090901@perens.com> <3FC4EF24.9040307@perens.com>
 <3FC4F248.8060307@perens.com> <Pine.LNX.4.58.0311261037370.1524@home.osdl.org>
 <3FC4F94F.6030801@perens.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 Nov 2003, Bruce Perens wrote:
>
> The behavior of 2.4 seems to be the same used by some dozens of Unix
> systems upon which my confidence test passed.

Interesting. I know the 2.4.x behaviour wasn't arrived at due to any
"compatibility testing" - it was purely a matter of "minimal code". The
fact that other unixes did the same despite no other commonalities is
interesting in itself ;)

But we actually had another unrelated thread about this last week, where
SIGTRAP on x86 worked differently under Linux and FreeBSD (both 2.4.x and
2.6.x behaviour differed from BSD behaviour), so clearly it's _not_ a 100%
correlation.

> I agree that we should not be wrong in the same way as everyone else,
> and wonder if POSIX says anything about this. I could have been the only
> one using this "feature".

I can't say that I'd ever seen this documented anywhere.

I personally think it is "good taste" to actually set the SA_NODEFER flag
if you know you depend on the behaviour, but if there are lots of existing
applications that actually depend on the "forced punch-through" behaviour,
then I'll obviously have to change the 2.6.x behaviour (a stable
user-level ABI is a lot more important than my personal preferences).

But if ElectricFence is the only thing that cares, I'd rather just EF
added a SA_NODEFER..

		Linus
