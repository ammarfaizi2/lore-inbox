Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbRAOQFu>; Mon, 15 Jan 2001 11:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbRAOQFk>; Mon, 15 Jan 2001 11:05:40 -0500
Received: from twinlark.arctic.org ([204.107.140.52]:10505 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S129431AbRAOQFd>; Mon, 15 Jan 2001 11:05:33 -0500
Date: Mon, 15 Jan 2001 08:05:32 -0800 (PST)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: Jonathan Thackray <jthackray@zeus.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <14947.5703.60574.309140@leda.cam.zeus.com>
Message-ID: <Pine.LNX.4.30.0101150753010.30402-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jan 2001, Jonathan Thackray wrote:

> (Linux, FreeBSD, HP-UX, AIX, Tru64). The next cool feature to add to
> Linux is sendpath(), which does the open() before the sendfile()
> all combined into one system call.

how would sendpath() construct the Content-Length in the HTTP header?

it's totally unfortunate that the other unixes chose to combine writev()
into sendfile() rather than implementing TCP_CORK.  TCP_CORK is useful for
FAR more than just sendfile() headers and footers.  it's arguably the most
correct way to write server code.  nagle/no-nagle in the default BSD API
both suck -- nagle because it delays packets which need to be sent;
no-nagle because it can send incomplete packets.

i'm completely happy that linus, davem and ingo refused to combine
writev() into sendfile() and suggested CORK when i pointed out the
header/trailer problem.

imnsho if you want to optimise static file serving then it's pretty
pointless to continue working in userland.  nobody is going to catch up
with all the kernel-side implementations in linux, NT, and solaris.

-dean

p.s. linus, apache-1.3 does *not* use sendfile().  it's in apache-2.0,
which unfortunately is now performing like crap because they didn't listen
to some of my advice well over a year ago.  a case of "let's make a pretty
API and hope performance works out"... where i told them "i've already
written code using the API you suggest, and it *doesn't* work."  </rant>
thankfully linux now has TUX.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
