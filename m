Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130420AbRARCfT>; Wed, 17 Jan 2001 21:35:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130802AbRARCfI>; Wed, 17 Jan 2001 21:35:08 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:49293 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S130420AbRARCfB>;
	Wed, 17 Jan 2001 21:35:01 -0500
Date: Wed, 17 Jan 2001 21:34:59 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Is sendfile all that sexy?
Message-ID: <20010117213459.A14450@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0101171454340.29536-100000@baphomet.bogo.bogus> <944s0j$9lt$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <944s0j$9lt$1@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Jan 17, 2001 at 11:32:35AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 11:32:35AM -0800, Linus Torvalds wrote:
> However, for socket->socket, we would not have such an advantage.  A
> socket->socket sendfile() would not avoid any copies the way the
> networking is done today.  That _may_ change, of course.  But it might
> not.  And I'd rather tell people using sendfile() that you get EINVAL if
> it isn't able to optimize the transfer.. 

On the other hand you could consider sendfile to be a concept rather
than an optimization.  That is, "move n bytes from this fd to that
one".  That would be very nice for this like tar (file <-> file or
tty), cp (file <-> file), application-level routing (socket <->
socket).  Hey, even cat(1) would be simplified.

Whether the kernel can optimize it in zero-copy mode is another
problem that will change with time anyway.  But the "I want to move x
amount of data from here to there, and I don't need to see the actual
contents" is something that happens quite often, and to be able to do
it with one syscall that does not muck with page tables (aka no mmap
nor malloc) would be both more readable and scale better on smp.

  OG.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
