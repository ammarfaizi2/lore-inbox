Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbRFGE5A>; Thu, 7 Jun 2001 00:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261759AbRFGE4v>; Thu, 7 Jun 2001 00:56:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:56226 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261289AbRFGE4c>;
	Thu, 7 Jun 2001 00:56:32 -0400
Date: Thu, 7 Jun 2001 00:56:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthias Urlichs <smurf@noris.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, thierry.lelegard@canal-plus.fr,
        linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: I/O system call never returns if file desc is closed
 in the
In-Reply-To: <p05100310b744a22f02a6@[192.109.102.42]>
Message-ID: <Pine.GSO.4.21.0106070043530.11086-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Jun 2001, Matthias Urlichs wrote:

> Select is defined as to return, with the appropriate bit set, if/when 
> a nonblocking read/write on the file descriptor won't block. You'd 
> get EBADF in this case, therefore causing the select to return would 
> be a Good Thing.

Bzzert. Wrong. It may easily block. open() from another thread might
grab that descriptor just fine.

If you close descriptors being polled - don't try IO on them once
select()/poll() returns. Regardless of aborting select().

> A related problem is that the second thread my be inside a blocking 
> read() instead of a select() call. It'd never continue.  :-(

Yes. So close() doesn't abort read(). Why would it?

Operations like read, select, etc. act of files. Not on descriptors.

