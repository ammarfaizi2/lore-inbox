Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317078AbSFQWT5>; Mon, 17 Jun 2002 18:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317081AbSFQWT4>; Mon, 17 Jun 2002 18:19:56 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62727 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317078AbSFQWTz>; Mon, 17 Jun 2002 18:19:55 -0400
Date: Mon, 17 Jun 2002 15:20:08 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
In-Reply-To: <20020617180913.I1457@redhat.com>
Message-ID: <Pine.LNX.4.44.0206171517530.6257-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, Benjamin LaHaise wrote:
>
> How's the patch below?  The main reason for passing in the pointer to
> the wait queue structure is that the aio functions need to remove
> themselves from the wait list if the event they were waiting for occurs.
> It seems to boot for me, how about others?

Looks ok at first glance, although I haven't booted yet.

One thing strikes me: we could move the "flags & WQ_FLAGS_EXCLUSIVE" test
also into the wakeup function - making the "exclusivity" depend on which
wakeup function you use. Does that make any sense? I'm not 100% convinced,
but it would mean that the normal non-exclusive stuff would never even
have to test the thing at run-time.

		Linus

