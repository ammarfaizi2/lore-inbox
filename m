Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272519AbRIFT2R>; Thu, 6 Sep 2001 15:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272521AbRIFT2H>; Thu, 6 Sep 2001 15:28:07 -0400
Received: from hugin.diku.dk ([130.225.96.144]:25358 "HELO hugin.diku.dk")
	by vger.kernel.org with SMTP id <S272519AbRIFT16>;
	Thu, 6 Sep 2001 15:27:58 -0400
Date: 6 Sep 2001 19:28:15 -0000
Message-ID: <20010906192815.28608.qmail@ntyr.diku.dk>
From: Morten Welinder <terra@diku.dk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Type checking MIN with standard interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All the silent-cast properties of integer types do not apply to
pointers.  Therefore...

-----------------------------------------------------------------------------

cub:~> gcc -O2 -Wall min.c
min.c: In function `main':
min.c:19: warning: comparison of distinct pointer types lacks a cast


cub:~> gcc -O2 -Wall kernel-source.c 2>&1 | \
        grep "comparison of distinct pointer types lacks a cast" | \
        find-and-shoot-programmer

:-)

Morten


-----------------------------------------------------------------------------

#include <stdio.h>

#define MIN(x,y)                                \
  ({ const typeof(x) _x = x;                    \
     const typeof(y) _y = y;                    \
                                                \
     (void) (&_x == &_y);                       \
                                                \
     _x < _y ? _x : _y;                         \
  })

int
main ()
{
  /* Good: */
  printf ("%d\n", MIN((signed)1, (signed)1));

  /* Bad: */
  printf ("%d\n", MIN((signed)1, (unsigned)1));

  return 0;
}

-----------------------------------------------------------------------------
