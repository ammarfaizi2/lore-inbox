Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261986AbSJNRHM>; Mon, 14 Oct 2002 13:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262007AbSJNRHM>; Mon, 14 Oct 2002 13:07:12 -0400
Received: from mail6.home.nl ([213.51.128.20]:26583 "EHLO mail6-sh.home.nl")
	by vger.kernel.org with ESMTP id <S261986AbSJNRHL>;
	Mon, 14 Oct 2002 13:07:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jogchem de Groot <bighawk@kryptology.org>
To: linux-kernel@vger.kernel.org
Subject: Re: poll() incompatability with POSIX.1-2001
Date: Mon, 14 Oct 2002 19:13:43 +0200
X-Mailer: KMail [version 1.3.2]
References: <Pine.LNX.3.95.1021014110505.12302A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1021014110505.12302A-100000@chaos.analogic.com>
Cc: root@chaos.analogic.com
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20021014171302.ERYV394.mail6-sh.home.nl@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

This is a failure to connect! The socket is therefore not ready for
writing  or reading -ever. This behavior may not be correct, not
because of a failure to set the POLLOUT bit, but because the POLLIN
bit is set. Check if this is really true. I can't duplicate this
on 2.4.18 here because it's hard to get a deferred connect with my
setup.

It's really true:..

Here is some strace output:

Case where connect() succeeds:

connect(3, {sin_family=AF_INET, sin_port=htons(111), 
sin_addr=inet_addr("127.0.0.1")}}, 16) = -1 EINPROGRESS (Operation now in 
progress)
poll([{fd=3, events=POLLIN|POLLOUT, revents=POLLOUT}], 1, -1) = 1
getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0

As you can see SO_ERROR returns '0', connection succeeded.

Case where connect() fails:

connect(3, {sin_family=AF_INET, sin_port=htons(110), 
sin_addr=inet_addr("127.0.0.1")}}, 16) = -1 EINPROGRESS (Operation now in 
progress)
poll([{fd=3, events=POLLIN|POLLOUT, revents=POLLIN|POLLERR|POLLHUP}], 1, -1) 
= 1
getsockopt(3, SOL_SOCKET, SO_ERROR, [111], [4]) = 0

As you can see SO_ERROR returns '111', connection failed.

   bighawk
