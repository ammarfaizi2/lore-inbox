Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRAEWQK>; Fri, 5 Jan 2001 17:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAEWQB>; Fri, 5 Jan 2001 17:16:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56068 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129183AbRAEWPt>;
	Fri, 5 Jan 2001 17:15:49 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200101052216.f05MGtJ17781@flint.arm.linux.org.uk>
Subject: Re: /proc/sys/net/unix
To: mistral@stev.org (James Stevenson)
Date: Fri, 5 Jan 2001 22:16:54 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0101052107430.11582-100000@linux.home> from "James Stevenson" at Jan 05, 2001 09:09:24 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson writes:
> should there be 2 files in that diretory with the same name ?

No.

> mistral@sx:/proc/sys/net/unix$ ls -la
> total 0
> dr-xr-xr-x   2 root     root            0 Jan  5 21:09 ./
> dr-xr-xr-x   8 root     root            0 Jan  5 21:09 ../
> -rw-------   1 root     root            0 Jan  5 21:09 max_dgram_qlen
> -rw-------   1 root     root            0 Jan  5 21:09 max_dgram_qlen
> mistral@sx:/proc/sys/net/unix$ 
> 
> thats under 2.4.0

Both net/sysctl_net.c and net/unix/sysctl_net_unix.c register the
unix_table[] structure which contains the "max_dgram_qlen" file.
It should only be registered once.

Since Unix sockets can be modular, I'm guessing that the one in
net/sysctl_net.c is wrong.  The easy way to get rid of it is to
remove the code between #ifdef CONFIG_UNIX and #endif in that file.

However, I leave it up to DaveM to supply the official patch since
this may not be his preferred method of fixing the problem.
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
