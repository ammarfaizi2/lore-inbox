Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262825AbRFCHw7>; Sun, 3 Jun 2001 03:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbRFCHwt>; Sun, 3 Jun 2001 03:52:49 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:50159 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S262825AbRFCHwi>; Sun, 3 Jun 2001 03:52:38 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <jcwren@jcwren.com>, <linux-kernel@vger.kernel.org>
Subject: RE: select() - Linux vs. BSD
Date: Sun, 3 Jun 2001 00:52:36 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKMEKIPHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGIEBCCIAA.jcwren@jcwren.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would have said just the opposite.  That if it you have a large
> number of
> handles you're waiting on, and you have to go back through and
> set the bits
> everytime you timeout that you would incur a larger overhead.  From the
> perspective of my application, it would have been more efficient
> to not zero
> them (I was waiting on a number of serial channels, and the
> timeout was used
> to periodically pump more data to the serial channel.  When I
> received data,
> I buffered it, and another thread took care of processing it).

	The usual implementation is you have a 'permanent' fd_set and a 'temporary'
fd_set. Before each call to select, you memcpy the permanent fd_set into the
temporary and pass the temporary to select. If you wish to stop selecting
for read or write on a given socket, you remove it from the appropriate
permanent set. This way you don't have to twiddle too many bits.

	DS

