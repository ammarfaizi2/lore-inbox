Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319263AbSHNSPL>; Wed, 14 Aug 2002 14:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319264AbSHNSPL>; Wed, 14 Aug 2002 14:15:11 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:5599 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S319263AbSHNSPK>;
	Wed, 14 Aug 2002 14:15:10 -0400
Date: Wed, 14 Aug 2002 11:19:03 -0700
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Problem : can't make pipe non-blocking on 2.5.X
Message-ID: <20020814181902.GA24047@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi,

	I've got the following problem : I can't make a pipe
non-blocking with 2.5.25.
	The various man pages don't mention anything
about it (actually, the "fifo" man page say that non-blocking mode
should succeed). And it seems to work fine on 2.4.20.
	Sorry if this has already been reported and fixed, but I
quicly searched the changelog and archive and found nothing.

	So, who should I complain to ?

------------- Setup ------------------------
	Kernel : 2.5.25 fails (but 2.4.20-pre2 works)
	Distrib : Debian 3.0
	libc : 2.2.5
------------- Test program -----------------
#include <unistd.h>
#include <fcntl.h>
#include <errno.h>
#include <stdio.h>

int main()
{
  int trigger_pipe[2];
  int err;
  int flags;

  pipe(trigger_pipe);

  err = fcntl(trigger_pipe[0], F_GETFL, &flags);
  fprintf(stderr, "GET FLAGS : %d - %X\n", err, flags);
  if(err >= 0)
    {
      flags |= O_NONBLOCK;
      err = fcntl(trigger_pipe[0], F_SETFL, flags);
      fprintf(stderr, "SET FLAGS : %d - %d\n", err, errno);
    }
  return(0);
}
------------- Output 2.5.25 ----------------
GET FLAGS : 0 - 40045F18
SET FLAGS : -1 - 22
------------- Output 2.4.20-pre2 -----------
GET FLAGS : 0 - 40043F18
SET FLAGS : 0 - 0
--------------------------------------------

	Have fun...

	Jean
