Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129104AbQJ3XYx>; Mon, 30 Oct 2000 18:24:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129199AbQJ3XYo>; Mon, 30 Oct 2000 18:24:44 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:24583 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129104AbQJ3XYi>; Mon, 30 Oct 2000 18:24:38 -0500
Date: Mon, 30 Oct 2000 15:24:34 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of lock_kernel()?(Was:
  Strange performance behavior of 2.4.0-test9)
In-Reply-To: <39FD8D0B.B6C0C772@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0010301518290.18636-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Andrew Morton wrote:

> Dean,  it looks like the same problem will occur with flock()-based
> serialisation.  Does Apache/Linux ever use that option?

from apache/src/include/ap_config.h in the linux section there's
this:

/* flock is faster ... but hasn't been tested on 1.x systems */
/* PR#3531 indicates flock() may not be stable, probably depends on
 * kernel version.  Go back to using fcntl, but provide a way for
 * folks to tweak their Configuration to get flock.
 */
#ifndef USE_FLOCK_SERIALIZED_ACCEPT
#define USE_FCNTL_SERIALIZED_ACCEPT
#endif

so you should be able to -DUSE_FLOCK_SERIALIZED_ACCEPT to try it.

(flock is less desirable than fcntl in general because it requires the
lock file to be kept around for the duration of the server, you can't
unlock() it immediately after creat().)

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
