Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTFIQ30 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 12:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTFIQ3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 12:29:25 -0400
Received: from smtp.wp.pl ([212.77.101.161]:3767 "EHLO smtp.wp.pl")
	by vger.kernel.org with ESMTP id S264531AbTFIQ3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 12:29:23 -0400
Message-ID: <000c01c32ea6$b3c88e60$010110ac@uran238>
From: "MarKol" <markol4@wp.pl>
To: <linux-kernel@vger.kernel.org>
References: <MDEHLPKNGKAHNMBLJOLKMEOBDHAA.davids@webmaster.com>
Subject: Re: select for UNIX sockets?
Date: Mon, 9 Jun 2003 18:46:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-AntiVirus: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-ChangeAV: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

----- Original Message -----
From: "David Schwartz" <davids@webmaster.com>
> Suppose, for example, a machine has two network interfaces. One is
very
> busy, queue full, and one is totally idle, queue empty. What do you
think
> 'select' for write on an unconnected UDP socket should do?

There is an internal buffer for this UDP socket. Select() should depend
on it's state.
I heard that SO_SNDLOWAT i SO_RCVLOWAT might be useful in this approach,
but it is not implemented in Linux.

Moreover my example uses AF_UNIX socket and AFAIK this should be
reliable communication.
I don't know why are you taking about network interfaces in this
context?

This quotation is taken from man select:
"
       Three independent sets of descriptors are watched.   Those
       listed  in  readfds  will  be watched to see if characters
       become available for reading (more precisely, to see if  a
       read  will not block - in particular, a file descriptor is
       also ready on end-of-file),  those  in  writefds  will  be
       watched  to  see  if  a write will not block, and those in
       exceptfds will be watched for exceptions."

and this from man socket:
"       Socket creates an endpoint for communication and returns a
       descriptor. "

I'm aware of the fact that my english is rather poor, but I see that
socket returns a descriptor, and select is watching descriptors and
returns descriptors ready for writing if a write operation will not
block.

I would agree with you if my program wouldn't work on Solaris or QNX.
But it works on both and it looks consistent with man!

Regards
--
Marek Kolacz

