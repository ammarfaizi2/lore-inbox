Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbSJNPGL>; Mon, 14 Oct 2002 11:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261707AbSJNPGL>; Mon, 14 Oct 2002 11:06:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2435 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261701AbSJNPGG>; Mon, 14 Oct 2002 11:06:06 -0400
Date: Mon, 14 Oct 2002 11:14:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jogchem de Groot <bighawk@kryptology.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: poll() incompatability with POSIX.1-2001
In-Reply-To: <20021014145726.DFKF19708.mail8-sh.home.nl@there>
Message-ID: <Pine.LNX.3.95.1021014110505.12302A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Oct 2002, Jogchem de Groot wrote:

> Hello,
> 
> There's an incompatability with the poll() implementation in the
> linux-2.4 kernel. (Tried 2.4.18).
> 
> According to the POSIX.1-2001 standard select() and poll() should
> return writability (POLLOUT) when connect() initated on a non-blocking
> socket asynchronously completes.
> 
> http://www.opengroup.org/onlinepubs/007904975/functions/connect.html
> 
> "If the connection cannot be established immediately and O_NONBLOCK is set
> for the file descriptor for the socket, connect() shall fail and set errno to
> [EINPROGRESS], but the connection request shall not be aborted, and the
> connection shall be established asynchronously. Subsequent calls to connect()
> for the same socket, before the connection is established, shall fail and set
> errno to [EALREADY].
> 
> When the connection has been established asynchronously, select() and poll()
> shall indicate that the file descriptor for the socket is ready for writing."
> 
> On linux-2.4 i noticed the following behaviour:
> 
> On connect() success select() returns writability for the socket.
> On connect() failure select() returns readability and writability for the
> socket.
> 
> This behaviour is according to the specification.
> 
> However with poll() (with events=POLLIN|POLLOUT) i get the following
> behaviour:
> 
> On connect() success poll() returns POLLOUT in revents.
> On connect() failure poll() returns POLLIN|POLLHUP|POLLERR in revents.
> 
> It does not set the POLLOUT bit here..

This is a failure to connect! The socket is therefore not ready for
writing  or reading -ever. This behavior may not be correct, not
because of a failure to set the POLLOUT bit, but because the POLLIN
bit is set. Check if this is really true. I can't duplicate this
on 2.4.18 here because it's hard to get a deferred connect with my
setup.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

