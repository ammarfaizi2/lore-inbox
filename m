Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264332AbRFGGHW>; Thu, 7 Jun 2001 02:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264333AbRFGGHM>; Thu, 7 Jun 2001 02:07:12 -0400
Received: from mail3.noris.net ([62.128.1.28]:15747 "EHLO mail3.noris.net")
	by vger.kernel.org with ESMTP id <S264332AbRFGGHG>;
	Thu, 7 Jun 2001 02:07:06 -0400
From: "Matthias Urlichs" <smurf@noris.de>
Date: Thu, 7 Jun 2001 08:06:27 +0200
To: Alexander Viro <viro@math.psu.edu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, thierry.lelegard@canal-plus.fr,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed in the
Message-ID: <20010607080626.S21844@noris.de>
In-Reply-To: <p05100310b744a22f02a6@[192.109.102.42]> <Pine.GSO.4.21.0106070043530.11086-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0106070043530.11086-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Jun 07, 2001 at 12:56:29AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Alexander Viro:
> > Select is defined as to return, with the appropriate bit set, if/when 
> > a nonblocking read/write on the file descriptor won't block. You'd 
> > get EBADF in this case, therefore causing the select to return would 
> > be a Good Thing.
> 
> Bzzert. Wrong. It may easily block. open() from another thread might
> grab that descriptor just fine.
> 
Sorry, s/file descriptor/file-or-socket-or-whatever.

Actually trying to read from this descriptor is of course a Bad Thing, but
that just means that the programmer forgot to record the file closing in
the program's global state.

> > A related problem is that the second thread my be inside a blocking 
> > read() instead of a select() call. It'd never continue.  :-(
> 
> Yes. So close() doesn't abort read(). Why would it?
> 
Well, if it triggers a return from select(), which it currently doesn't
do under Linux, then it should also trigger a return from read() (with
either zero or -EBADF).

I wonder whether any other Unixes do that..?

> Operations like read, select, etc. act of files. Not on descriptors.
> 
Right -- I sort-of implied that. My fault.

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
