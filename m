Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbQKOXyg>; Wed, 15 Nov 2000 18:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129366AbQKOXyR>; Wed, 15 Nov 2000 18:54:17 -0500
Received: from bgnet.bg ([212.56.2.2]:34823 "EHLO bgnet.bg")
	by vger.kernel.org with ESMTP id <S129130AbQKOXyG>;
	Wed, 15 Nov 2000 18:54:06 -0500
Date: Thu, 16 Nov 2000 01:29:50 +0000 (UTC)
From: Vesselin Atanasov <vesselin@bgnet.bg>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: A question about capabilities. fI and fE
Message-ID: <Pine.LNX.4.10.10011160125170.23612-100000@bgnet.bg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
I read the Linux Capabilities FAQ 2.0 and looked at the source in
/usr/src/linux/fs/exec.c. In function prepare_binprm() I see that fE is
always cleared and set only if EUID == 0 and fI is always cleared
and set only if UID == 0 or EUID == 0. Is there a reason for this
behaviour? I think that the default value for fE should always be ~0,
because every program should be assumed to be capability dumb and fI by
default should be ~0 because every capability dump program must be able to
run with all capabilities it inherits from user that exec's it.

The reason for this question is that I want to run apache in a chrooted
environment. I want to run it as some user != root, so he cannot break out
of chroot jail, but I must give apache CAP_NET_BIND_SERVICE. I have
written a simple wrapper that optionally chroots, optinally sets its
privileges, optionally sets its UID and GID and then executes a specified
program, but the privileges that I set cannot survive the execve() call
because of the default fE = 0 and fI = 0.

So I want to know if I modify my kernel and make fE = 0~ and fI = ~0 by
default, will this damage the security of my system?

vesselin

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
