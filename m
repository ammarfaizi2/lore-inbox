Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRART75>; Thu, 18 Jan 2001 14:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131427AbRART7q>; Thu, 18 Jan 2001 14:59:46 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:50962 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S131270AbRART7a>;
	Thu, 18 Jan 2001 14:59:30 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200101181959.WAA08376@ms2.inr.ac.ru>
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
To: andrea@suse.DE (Andrea Arcangeli)
Date: Thu, 18 Jan 2001 22:59:11 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010118203802.D28276@athlon.random> from "Andrea Arcangeli" at Jan 18, 1 10:45:00 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I'm all for TCP_CORK but it has the disavantage of two syscalls for doing the

MSG_MORE was invented to allow to collapse this to 0 of syscalls. 8)


> A new ioctl on the socket should be able to do that (and ioctl looks ligther
> than a setsockopt, ok ignoring actually the VFS is grabbing the big lock
> until we relase it in sock_ioctl, ugly, but I feel good ignoring this fact as
> it will gets fixed eventually and this is userspace API that will stay longer).

setsockopt() exists, which does not have the flaw. (SOL_SOCKET, TCP_DOPUSH)
or something like this. Actually, I would convert TCP_CORK to set of flags
(1 is reserved for current corking), but I feel this operation is more generic
and should be moved to SOL_SOCKET level.

BTW I see no reasons not to move BKL down for ioctl().
It is not a rocket science, plain dumb edit.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
