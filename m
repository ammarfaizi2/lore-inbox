Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268163AbTCFR1k>; Thu, 6 Mar 2003 12:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268168AbTCFR1k>; Thu, 6 Mar 2003 12:27:40 -0500
Received: from ns.xdr.com ([209.48.37.1]:33410 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id <S268163AbTCFR1i>;
	Thu, 6 Mar 2003 12:27:38 -0500
Date: Thu, 6 Mar 2003 09:38:14 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200303061738.h26HcEF1021753@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Possible socket problem?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing some strange behaviour with sockets under 2.4.20, and the
same thing on 2.4.18. I haven't tried any other kernel versions though or
done any more investigation, but all signs seem to point to a socket problem
in the kernel.

My program is reading from a socket produced like this:
        sock=socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
I connect() the socket to an external server (an IMAP mail server). The server
throws lots of data down the line. The indication is that if the socket's
receive buffer fills up, I can no longer read from the socket, the read
just blocks forever. Same if I select() on the socket, it never reports data
is ready. I can tcpdump and see plenty of data having arrived after
the point where the last read succeeded.

The problem goes away if I do this:
        i=4096;
        j=setsockopt(sock,SOL_SOCKET,SO_RCVBUF,&i,sizeof(i));

It still occured when I set the RCVBUF size to 50000.

When the freeze happens I can find the last data received from the socket
in the tcpdump log, and it always is the last bytes in a single tcp packet.
More tcp packets follow, but they don't cause the read() to return.

I'm not doing any ioctl's or weird stuff, and I only read() or write() to the
socket.

-Dave

