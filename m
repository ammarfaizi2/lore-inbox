Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264329AbRFGGOe>; Thu, 7 Jun 2001 02:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264335AbRFGGOY>; Thu, 7 Jun 2001 02:14:24 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:28555 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264329AbRFGGOQ>;
	Thu, 7 Jun 2001 02:14:16 -0400
Date: Thu, 7 Jun 2001 02:14:14 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthias Urlichs <smurf@noris.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, thierry.lelegard@canal-plus.fr,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed
 in the
In-Reply-To: <20010607080626.S21844@noris.de>
Message-ID: <Pine.GSO.4.21.0106070208500.11086-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Matthias Urlichs wrote:

> > > a nonblocking read/write on the file descriptor won't block. You'd 
> > > get EBADF in this case, therefore causing the select to return would 
> > > be a Good Thing.
> > 
> > Bzzert. Wrong. It may easily block. open() from another thread might
> > grab that descriptor just fine.
> > 
> Sorry, s/file descriptor/file-or-socket-or-whatever.

Then what EBADF are you talking about?
 
> Well, if it triggers a return from select(), which it currently doesn't
> do under Linux, then it should also trigger a return from read() (with
> either zero or -EBADF).
> 
> I wonder whether any other Unixes do that..?

FreeBSD, Plan 9: same as Linux (get file by descriptor, forget about
descriptor you've used for that)
OpenBSD, NetBSD: good chance of kernel panic (the whole handling of shared
descriptor tables is broken)

the rest: entirely different threads model.

> > Operations like read, select, etc. act of files. Not on descriptors.
> > 
> Right -- I sort-of implied that. My fault.

So why would closing a descriptor have any effect on them? struct file
is alive and well, held by the operation we are doing.

