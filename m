Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270490AbTGXFNJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 01:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270492AbTGXFNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 01:13:09 -0400
Received: from exchfe1.cs.cornell.edu ([128.84.97.27]:559 "EHLO
	exchfe1.cs.cornell.edu") by vger.kernel.org with ESMTP
	id S270490AbTGXFNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 01:13:06 -0400
From: Eli Barzilay <eli@barzilay.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16159.28266.868297.372200@mojave.cs.cornell.edu>
Date: Thu, 24 Jul 2003 01:28:10 -0400
To: linux-kernel@vger.kernel.org
Subject: Repost: Bug with select?
In-Reply-To: <16112.10166.989608.288954@mojave.cs.cornell.edu>
References: <16112.10166.989608.288954@mojave.cs.cornell.edu>
X-Mailer: VM 7.15 under Emacs 21.1.1
X-OriginalArrivalTime: 24 Jul 2003 05:28:07.0708 (UTC) FILETIME=[5D3A15C0:01C351A4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[This is a second post, since I didn't get any replies the first time.
It looks more like a bug now, which sounds strange for something that
common...]

When I run the following program, and block the terminal's output
(C-s), the `select' doesn't seem to have any effect, resulting in a
100% cpu usage (this is on a RH8, with 2.4.18).  I wouldn't be
surprised if I'm doing something stupid, but it does seem to work fine
on Solaris.

Is there anything wrong with this, or is this some bug?

======================================================================
#include <unistd.h>
#include <fcntl.h>
int main() {
  int flags, fd, len; fd_set writefds;
  fd = 1;
  flags = fcntl(fd, F_GETFL, 0);
  fcntl(fd, F_SETFL, flags | O_NONBLOCK);
  while (1) {
    FD_ZERO(&writefds);
    FD_SET(fd, &writefds);
    len = select(fd + 1, NULL, &writefds, NULL, NULL);
    if (!FD_ISSET(fd,&writefds)) exit(0);
    len = write(fd, "hi\n", 3);
  }
  fcntl(fd, F_SETFL, flags);
}
======================================================================

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                  http://www.barzilay.org/                 Maze is Life!
