Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135988AbRDTTCf>; Fri, 20 Apr 2001 15:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135978AbRDTTCX>; Fri, 20 Apr 2001 15:02:23 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:41743 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135993AbRDTTCD>; Fri, 20 Apr 2001 15:02:03 -0400
Date: Fri, 20 Apr 2001 12:01:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, <autofs@linux.kernel.org>
Subject: Re: Fix for SMP deadlock in autofs4
In-Reply-To: <20010420014940.F8578@goop.org>
Message-ID: <Pine.LNX.4.31.0104201158290.5632-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 20 Apr 2001, Jeremy Fitzhardinge wrote:
>
> This is a fix for a potential deadlock in autofs4's expire routine.

It's wrong.

I don't think we should be able to do a mntput() _either_ inside the
spinlock. The filesystem should not "know" that mntput is safe.

For this reason I don't think "dput_locked()" is the right answer either.

Why are we doing the mntget/dget at all? We hold the spinlock, so we know
they are not going away. Not doing the mntget/dget means that we (a) run
faster and (b) don't have the bug, because we don't need to put the damn
things.

Comments?

		Linus

