Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129180AbQKDULk>; Sat, 4 Nov 2000 15:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129215AbQKDULT>; Sat, 4 Nov 2000 15:11:19 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:60934 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129180AbQKDULM>; Sat, 4 Nov 2000 15:11:12 -0500
Date: Sat, 4 Nov 2000 12:11:11 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Andrew Morton <andrewm@uow.edu.au>
cc: kumon@flab.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Negative scalability by removal of  lock_kernel()?(Was:Strange
 performance behavior of 2.4.0-test9)
In-Reply-To: <3A0399CD.8B080698@uow.edu.au>
Message-ID: <Pine.LNX.4.21.0011041203300.22526-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Nov 2000, Andrew Morton wrote:

> Dean,
> 
> neither flock() nor fcntl() serialisation are effective
> on linux 2.2 or linux 2.4.

i have to admit the last time i timed any of the methods on linux was in
2.0.x days.  thanks for the updated data!

> For kernel 2.2 I recommend that Apache consider using
> sysv semaphores for serialisation. They use wake-one. 

sysv semaphores have a very unfortunate negative feature -- if the admin
kill -9's the server (impatient admins do this all the time) then you end
up leaving a semaphore lying around.  sysvsem don't have the usual unix
unlink semantics.  actually flock has the same problem... which is why i
generally preferred fcntl whenever it was a performance wash, as it was
back in 2.0.x days.

however given the vast performance difference i think it warrants the
change.  i'll include your results with the commit.

> For kernel 2.4 I recommend that Apache use unserialised
> accept.

per linus' request i'll unserialise 2.2 as well.

i'll leave 2.0.x settings alone.

(oh yeah, and compile-time only detection.)

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
