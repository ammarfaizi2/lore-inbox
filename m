Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310206AbSFYJR5>; Tue, 25 Jun 2002 05:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313070AbSFYJR4>; Tue, 25 Jun 2002 05:17:56 -0400
Received: from tomts19-srv.bellnexxia.net ([209.226.175.73]:25005 "EHLO
	tomts19-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S310206AbSFYJR4>; Tue, 25 Jun 2002 05:17:56 -0400
Message-ID: <3D183540.6CA7CB00@sympatico.ca>
Date: Tue, 25 Jun 2002 05:17:52 -0400
From: Christian Robert <christian.robert@polymtl.ca>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en, fr-CA
MIME-Version: 1.0
To: John Alvord <jalvo@mbay.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
References: <3D17BB4B.F5E2571F@sympatico.ca> <200206251043.28051.bhards@bigpond.net.au> <3D17CF60.1DD1B82D@sympatico.ca> <ecmfhuopshut8luclo6asqorsj4b1sa13q@4ax.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Alvord wrote:
> 
> Maybe this is the result of floating point rounding errors. Floating
> point is notorious for occaisional strange results. I suggest redoing
> the test program to keep all results in integer and seeing what
> happens...
> 
> john

You were close. 

Programming error on my part.

This modified subroutine does correct my test.
Notice the (LL) cast on 1000000

Computation was done on 32 bits integer then assign on the 64 bits integer.

sorry. 

ps: It may help explain the other > 1 hour time jump I've seen in an
    other thread.
 

LL GetTime (void)
{
  struct timeval tv;
  LL     retval;
  int    rc;

  while (0 != (rc = gettimeofday (&tv, NULL)))
    printf ("Wow! gettimeofday () returned %d\n", rc);

  retval = (tv.tv_sec * (LL)1000000) + (tv.tv_usec);

  return retval;
}
