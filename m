Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSGVKeG>; Mon, 22 Jul 2002 06:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316666AbSGVKeG>; Mon, 22 Jul 2002 06:34:06 -0400
Received: from [213.225.90.118] ([213.225.90.118]:21254 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id <S316649AbSGVKeG>;
	Mon, 22 Jul 2002 06:34:06 -0400
Date: Mon, 22 Jul 2002 12:38:18 +0200 (CEST)
From: Ketil Froyn <ketil-kernel@froyn.net>
X-X-Sender: ketil@ketil.np
To: linux-kernel@vger.kernel.org
Subject: EINTR on close() in Linux?
Message-ID: <Pine.LNX.4.40L0.0207221221580.1417-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

After looking at the discussion on errors during close(), I'd like a
clarification. Linus said that Linux ALWAYS tears down the fd when close()
is called, and it returns the error just to notify the application. What
happens if the close() call is interrupted by a signal? Does Linux say
EINTR and close the FD, or will Linux just never say EINTR? To close a fd
a portable program might do something like this:

while (1) {
	if (close(fd) == -1) {
		if (errno == EINTR) continue;
		printf("Barf\n");
		exit(1);
	}
	break;
}

If Linux returns EINTR and tears down the fd, this code is bad because
1) It will die with EBADF the second try, or
2) In a multithreaded app, it might close something it shouldn't

Thanks,
Ketil

