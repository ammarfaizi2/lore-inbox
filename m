Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267259AbUJIS2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267259AbUJIS2f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 14:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUJIS2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 14:28:35 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:51207 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S267259AbUJIS2c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 14:28:32 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <martijn@entmoot.nl>, <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Sat, 9 Oct 2004 11:28:28 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKEEAPOOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <000801c4ae35$3520ac90$161b14ac@boromir>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Sat, 09 Oct 2004 11:05:13 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Sat, 09 Oct 2004 11:05:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> [...]
> > Where, specifically, does the standard guarantee that a
> > subsequent call to
> > 'recvmsg' will not block?
>
> When using select() on a socket for reading, select will block until
> that socket is ready.
>
> According to POSIX:
>
>   A descriptor shall be considered ready for reading when a call to an
>   input function with O_NONBLOCK clear would not block, whether or not
>   the function would transfer data successfully.

	Note that it says *would* not block, not *will* not block. The definition
of the word "would" is "an expression of probability or likelihood" (or a
"presumption or expectation"). This is *not* a guarantee.

> and
>
>   If a descriptor refers to a socket, the implied input function is the
>   recvmsg() function with parameters requesting normal and ancillary data,
>   such that the presence of either type shall cause the socket to
>   be marked
>   as readable. The presence of out-of-band data shall be checked if the
>   socket option SO_OOBINLINE has been enabled, as out-of-band data is
>   enqueued with normal data. If the socket is currently listening, then it
>   shall be marked as readable if an incoming connection request has been
>   received, and a call to the accept() function shall complete without
>   blocking.
>
> Thus recvmsg() shouldn't in any case block after a select() on a socket.

	I don't draw that conclusion from that paragraph. It does say the presence
of normal data shall mark the socket readable, but it doesn't require the
kernel to keep that data available, at least not as far as I can see.

	As far as I can tell, neither of these two excerpts prohibit an
implementation from, for example, discarding UDP data (say, to save memory)
after it triggered a read hit on a 'select' call. Yes, the 'recvmsg' call
would not have blocked, had it been made at the time the data was available.

	DS


