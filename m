Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRGWWYu>; Mon, 23 Jul 2001 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRGWWYk>; Mon, 23 Jul 2001 18:24:40 -0400
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:58378 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S262355AbRGWWYZ>; Mon, 23 Jul 2001 18:24:25 -0400
Date: Mon, 23 Jul 2001 23:24:19 +0100 (BST)
From: Chris Evans <chris@scary.beasts.org>
X-X-Sender: <chris@ferret.lmh.ox.ac.uk>
To: <linux-kernel@vger.kernel.org>
cc: <davem@redhat.com>
Subject: Minor net/core/sock.c security issue?
Message-ID: <Pine.LNX.4.33.0107232321120.19755-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

May be nothing, but it looks like SO_*BUF may have signedness issues (have
these been picked up by the Stanford tools and fixed in recent 2.4.x?)

    int val;
...
    case SO_SNDBUF:
      if (val > sysctl_wmem_max)
        val = sysctl_wmem_max;
      sk->sndbuf = max(val*2,2048);

If val is negative, then sk->sndbuf ends up negative. This is because the
arguments to max are passed as _unsigned_ ints. SO_RCVBUF has similar
issues. Maybe a nasty local user could use this to chew up memory?

Cheers
Chris

