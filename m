Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbTFRIgL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbTFRIgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:36:11 -0400
Received: from exchfe1.cs.cornell.edu ([128.84.97.27]:25 "EHLO
	exchfe1.cs.cornell.edu") by vger.kernel.org with ESMTP
	id S265109AbTFRIgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:36:08 -0400
From: Eli Barzilay <eli@barzilay.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16112.10166.989608.288954@mojave.cs.cornell.edu>
Date: Wed, 18 Jun 2003 04:49:58 -0400
To: linux-kernel@vger.kernel.org
Subject: Problem with select?
X-Mailer: VM 7.15 under Emacs 21.2.1
X-OriginalArrivalTime: 18 Jun 2003 08:49:28.0755 (UTC) FILETIME=[87389030:01C33576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

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
