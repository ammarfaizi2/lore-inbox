Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265524AbSJXM3p>; Thu, 24 Oct 2002 08:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265531AbSJXM3p>; Thu, 24 Oct 2002 08:29:45 -0400
Received: from mout1.freenet.de ([194.97.50.132]:35805 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S265524AbSJXM3n>;
	Thu, 24 Oct 2002 08:29:43 -0400
Message-ID: <000301c27b59$f22964a0$0200a8c0@MichaelKerrisk>
From: "Michael Kerrisk" <m.kerrisk@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: shutdown() and SHUT_RD on TCP sockets - anomalous behaviour?
Date: Thu, 24 Oct 2002 14:21:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3110.1
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3110.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I did an archive search and found a post that indicated that what I describe
below is known behaviour.  The question is: why does this occur on Linux?

According to SUSv3, if we perform a shutdown(fd, SHUT_RD) on a socket, then
further reads on that socket should be disabled.  In the AF_UNIX domain, all
is fine - things operate as expected.  However, for stream sockets, things
are different (tested on 2.2.14, and 2.4.19):

1. If we perform a read() on the socket and there is no data, then 0 (EOF)
is (immediately) returned.  (This is expected.)

2. However, the peer can still write() to the socket, and afterwards we can
read() that data from the socket, even though the reading half of the socket
should be shutdown.  Instead of this behaviour, I expected the data to be
discarded, and the read() to return 0 as in point 1.

I've read the relevant source code to confirm the anomalous behaviour in
point 2.  The question is: why do things happen in this way on Linux?

Thansk

Michael

