Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVFPXPZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVFPXPZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 19:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbVFPXMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 19:12:25 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:62656 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261877AbVFPXIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 19:08:34 -0400
From: trmcneal@comcast.net
To: linux-kernel@vger.kernel.org
Date: Thu, 16 Jun 2005 23:08:28 +0000
Message-Id: <061620052308.15335.42B2066C000DD5E200003BE72205886172040E0A020C039D9B@comcast.net>
X-Mailer: AT&T Message Center Version 1 (Dec 17 2004)
X-Authenticated-Sender: dHJtY25lYWxAY29tY2FzdC5uZXQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this on linux-net, and got only one reply, saying that they
had run into this as well.  Not much help.  I'm thinking that I need to 
tune the kernel somehow to prevent this, but I'm not sure how.  It doesn't 
happen on Solaris, and seems to be a resource issue, but its probably 
not memory. Here are the details:

> I've been working with some tcp network test programs that have
> multiple clients opening nonblocking sockets to a single server port,
> sending a short message, and then closing the socket, 100,000 times.
> Since the socket is non-blocking, it generally tries to connect and then
> does a poll since the socket is busy.  The test fails if the poll times out in
> 10 seconds.  It fails consistently on Linux servers but succeeds on Solaris
> servers; the client is a non-issue unless its loopback on the Linux server.

> This issue crops up both on 2.4 and 2.6 kernels; the main feature seen
> in tcp dumps is that the server gets inundated with retrys, and then starts
> sending RST responses to everything (labelled as ZeroWindow in a
> Ethereal dump).  One interesting feature is that many clients thinks the
> 3-way connection handshake is complete, when the server actually
> doesn't get the final ACK; The client starts sending and then retransmitting
> the data, and the server keeps sending back the SYN/ACK part of the
> handshake.  Another interesting feature is a group of retries from various
> client ports, followed by a group of ACK,RST responses from the server,
> followed by the ZeroWindow RST to everything.

> On Linux, the only way to succeed is to use remote clients - thus avoiding
> extra work on the server -and changing test parameters to put in a longer
> server delay, which is inserted between the closing of one connection and
> the opening of the next. I'm assuming that the tcp network queues are just
> getting overloaded with the data retransmissions, but I don't know enough
> about the queue management yet.  Any suggestions/pointers/fixes?

Any ideas about tuning, or what resource I'm running out of?  

Regards -

Tom McNeal

--
Tom McNeal
(650)906-0761(cell)
(650)964-8459(fax)
