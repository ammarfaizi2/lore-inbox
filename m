Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269931AbUJHA0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269931AbUJHA0Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:26:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269894AbUJHAYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:24:09 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:27915 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP id S269941AbUJHAUE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:20:04 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <martijn@entmoot.nl>, <linux-kernel@vger.kernel.org>
Subject: RE: UDP recvmsg blocks after select(), 2.6 bug?
Date: Thu, 7 Oct 2004 17:19:20 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKKEHIONAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <015a01c4acbe$2425b070$161b14ac@boromir>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Thu, 07 Oct 2004 16:56:04 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Thu, 07 Oct 2004 16:56:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > POSIX does not require the kernel to predict the future. The
> > only guarantee
> > against having a socket operation block is found in
> > non-blocking sockets.

> It is one thing to implement select()/recvmsg() in a non POSIX compliant
> way; it is another thing to make false claims about that standard. POSIX
> _does_ guarantee that a call to recvmsg() does not block after a call
> to select().

	I do not believe this.

> > Suppose, for example, that instead of using 'read' you used
> > 'recvmsg', and
> > we add an option to 'recvmsg' to allow you to read datagrams with bad
> > checksums. What should 'select' do if a datagram is received with a bad
> > checksum? It has no idea what flavor of 'recvmsg' you're going
> > to call, so
> > it can't know if your operation is going to block or not.

> This is all described in detail in the standard.

	Where, specifically, does the standard guarantee that a subsequent call to
'recvmsg' will not block?

> > No, you are incorrect. Consider, again, a 'recvmsg' flag to allow you to
> > receive messages even if they have bad checksums versus one that blocks
> > until a message with a valid checksum is received. The 'select' function
> > just isn't smart enough.
> >
> > Consider a 'select' for write on a TCP socket. How does
> > 'select' know how
> > many bytes you're going to write? Again, a 'select' hit just indicates
> > something relevant has happened, it *cannot* guarantee that a future
> > operation won't block both because 'select' has no idea what
> > operation is
> > going to take place in the future and because things can change
> > between now
> > and then.

> You really should read the standard on this..

	I have. We obviously disagree on what it says. Since you're the one
claiming a guarantee that I claim does not exist, perhaps you could cite
where you think this guarantee appears.

	DS


