Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLHAxp>; Thu, 7 Dec 2000 19:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129450AbQLHAxf>; Thu, 7 Dec 2000 19:53:35 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13321 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129314AbQLHAx0>; Thu, 7 Dec 2000 19:53:26 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: kernel BUG at buffer.c:827 in test12-pre6 and 7
Date: 7 Dec 2000 16:22:39 -0800
Organization: Transmeta Corporation
Message-ID: <90p9kf$5p3$1@penguin.transmeta.com>
In-Reply-To: <3A30125D.5F71110D@cheek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A30125D.5F71110D@cheek.com>,
Joseph Cheek  <joseph@cheek.com> wrote:
>copying files off a loopback-mounted vfat filesystem exposes this bug.
>test11 worked fine.

It's not a new bug - it's an old bug that apparently is uncovered by a
new stricter test.

Apparently loopback unlocks an already unlocked page - which has always
been a serious offense, but has never been detected before.

test12-pre6+ detects it, and thus the BUG().

Your stack trace isn't symbolic (see Documentation/oops-tracing.txt), so
it's impossible to debug, but it's already interesting information to
see that it seems to be either loopback of vfat.

Can you test some more? In particular, I'd love to hear if this happens
with vfat even without loopback, or with loopback even without vfat
(make an ext2 filesystem or similar instead). That woul dnarrow down the
bug further.

		Thanks,
				Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
