Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSJNOvf>; Mon, 14 Oct 2002 10:51:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJNOve>; Mon, 14 Oct 2002 10:51:34 -0400
Received: from mail8.home.nl ([213.51.128.28]:50650 "EHLO mail8-sh.home.nl")
	by vger.kernel.org with ESMTP id <S261677AbSJNOve>;
	Mon, 14 Oct 2002 10:51:34 -0400
Content-Type: text/plain; charset=US-ASCII
X-KMail-Redirect-From: Jogchem de Groot <bighawk@kryptology.org>
Subject: poll() incompatability with POSIX.1-2001
From: Jogchem de Groot <bighawk@kryptology.org> (by way of Jogchem de
	Groot <bighawk@kryptology.org>)
Date: Mon, 14 Oct 2002 16:58:07 +0200
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021014145726.DFKF19708.mail8-sh.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

There's an incompatability with the poll() implementation in the
linux-2.4 kernel. (Tried 2.4.18).

According to the POSIX.1-2001 standard select() and poll() should
return writability (POLLOUT) when connect() initated on a non-blocking
socket asynchronously completes.

http://www.opengroup.org/onlinepubs/007904975/functions/connect.html

"If the connection cannot be established immediately and O_NONBLOCK is set
for the file descriptor for the socket, connect() shall fail and set errno to
[EINPROGRESS], but the connection request shall not be aborted, and the
connection shall be established asynchronously. Subsequent calls to connect()
for the same socket, before the connection is established, shall fail and set
errno to [EALREADY].

When the connection has been established asynchronously, select() and poll()
shall indicate that the file descriptor for the socket is ready for writing."

On linux-2.4 i noticed the following behaviour:

On connect() success select() returns writability for the socket.
On connect() failure select() returns readability and writability for the
socket.

This behaviour is according to the specification.

However with poll() (with events=POLLIN|POLLOUT) i get the following
behaviour:

On connect() success poll() returns POLLOUT in revents.
On connect() failure poll() returns POLLIN|POLLHUP|POLLERR in revents.

It does not set the POLLOUT bit here..

I hope somebody will take a closer look at this. It doesnt seem to require a
big fix at all..

Thank you,
    bighawk
