Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316970AbSFQUKr>; Mon, 17 Jun 2002 16:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316971AbSFQUKq>; Mon, 17 Jun 2002 16:10:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:53519 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316970AbSFQUKp>; Mon, 17 Jun 2002 16:10:45 -0400
Date: Mon, 17 Jun 2002 13:11:04 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.22 add __fput for aio
In-Reply-To: <20020617154738.B1457@redhat.com>
Message-ID: <Pine.LNX.4.44.0206171307180.2949-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Jun 2002, Benjamin LaHaise wrote:
>
> This patch splits fput into fput and __fput.  __fput is needed by aio
> to construct a mechanism for performing fput during io completion,
> which typically occurs during interrupt context.

Ehh. Since you _cannot_ do __fput() from an interrupt context, something
is broken.

Possibly the comments.

If aio calls down to __fput() from an interrupt context, then aio is
clearly broken. Yet that's what the comments seem to imply.

The other alternative is that aio only does the book-keeping from
interrupt context, adds the "struct file * to be freed" to some list of
freeable files, and then does __fput() from _non_interrupt_ context on
those files.

Is that was aio actually _does_?

If so, the code may be fine, but the comments are misleading crap and
should be fixed asap.

		Linus

