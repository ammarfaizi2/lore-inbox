Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUJISVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUJISVV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUJISVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:21:20 -0400
Received: from ts2-075.twistspace.com ([217.71.122.75]:46039 "EHLO entmoot.nl")
	by vger.kernel.org with ESMTP id S267283AbUJISVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:21:17 -0400
Message-ID: <000801c4ae35$3520ac90$161b14ac@boromir>
From: "Martijn Sipkema" <martijn@entmoot.nl>
To: <davids@webmaster.com>, <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKKEHIONAA.davids@webmaster.com>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sat, 9 Oct 2004 20:21:41 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David Schwartz" <davids@webmaster.com>
> > > POSIX does not require the kernel to predict the future. The
> > > only guarantee
> > > against having a socket operation block is found in
> > > non-blocking sockets.
> 
> > It is one thing to implement select()/recvmsg() in a non POSIX compliant
> > way; it is another thing to make false claims about that standard. POSIX
> > _does_ guarantee that a call to recvmsg() does not block after a call
> > to select().
> 
> I do not believe this.
> 
[...]
> Where, specifically, does the standard guarantee that a subsequent call to
> 'recvmsg' will not block?

When using select() on a socket for reading, select will block until
that socket is ready.

According to POSIX:

  A descriptor shall be considered ready for reading when a call to an
  input function with O_NONBLOCK clear would not block, whether or not
  the function would transfer data successfully.

and

  If a descriptor refers to a socket, the implied input function is the
  recvmsg() function with parameters requesting normal and ancillary data,
  such that the presence of either type shall cause the socket to be marked
  as readable. The presence of out-of-band data shall be checked if the
  socket option SO_OOBINLINE has been enabled, as out-of-band data is
  enqueued with normal data. If the socket is currently listening, then it
  shall be marked as readable if an incoming connection request has been
  received, and a call to the accept() function shall complete without
  blocking.

Thus recvmsg() shouldn't in any case block after a select() on a socket.


--ms



