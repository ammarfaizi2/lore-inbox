Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTFKWhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 18:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263665AbTFKWhQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 18:37:16 -0400
Received: from mail.webmaster.com ([216.152.64.131]:20657 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262861AbTFKWhN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 18:37:13 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: select for UNIX sockets?
Date: Wed, 11 Jun 2003 15:50:55 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKIELADJAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <m3znkol1oi.fsf@defiant.pm.waw.pl>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Jesse Pollard <jesse@cats-chateau.net> writes:

> > As in: ALWAYS ready to write as soon as a connection is made. It can
> > still block on a write if the amount to write is larger than the buffer
> > available. Nothing is said about the AMOUNT that can be written
> > (though with most FIFOs/pipes the limit is ~ 4K, though not guaranteed
> > since other writers may fill it between the poll and the write.

> Still, it is local (UNIX) datagram socket and thus the number of
> datagrams is the limit, not the number of bytes. And yes, the problem
> is present with 1-byte datagrams. And still, the problem is with select()
> and not with send*().

	Can you find me where any standard says that local UNIX datagrams can't
have lengths of less than one byte? It's really this simple -- you don't
have the guarantee you think you have. Yes, the kernel could be nicer. But
what you're trying to do (foist on the kernel the job of transmit scheduling
on a connectionless socket) is fundamentally wrong.

	DS


