Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131080AbQKGErP>; Mon, 6 Nov 2000 23:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131071AbQKGEq7>; Mon, 6 Nov 2000 23:46:59 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:31492 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S131041AbQKGEqj>; Mon, 6 Nov 2000 23:46:39 -0500
Date: Mon, 6 Nov 2000 20:46:38 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: George Talbot <george@brain.moberg.com>
cc: Marc Lehmann <pcg@goof.com>, linux-kernel@vger.kernel.org
Subject: Re: Can EINTR be handled the way BSD handles it? -- a plea from a
 user-land  programmer...
In-Reply-To: <Pine.LNX.4.21.0011060906280.4984-100000@brain.moberg.com>
Message-ID: <Pine.LNX.4.21.0011062042170.26647-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, George Talbot wrote:

> I respectfully disagree that programs which don't surround some of the
> most common system calls with
> 
> 	do
> 	{
> 		rv = __some_system_call__(...);
> 	} while (rv == -1 && errno == EINTR);

welcome to Unix.  this is how it is, and it's not just linux.  and it's
not just glibc/linuxthreads.  in your code do you go about setting all
signals to SA_RESTART?  if not then you're subject to the vagaries of
whatever the default signal settings are.

ted mentioned ^Z... there's also strace/truss/ktrace (depending on your
flavour of unix).  there's also page-out/in (and on some unixes there's
swap-out/in).

it's something which bites lots of folks.  gnu tar had this bug for at
least 5 years, and may still have it -- i got tired of submitting the bug
fix.

-dean

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
