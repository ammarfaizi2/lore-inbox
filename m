Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271758AbRHURfT>; Tue, 21 Aug 2001 13:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271759AbRHURfK>; Tue, 21 Aug 2001 13:35:10 -0400
Received: from mail.webmaster.com ([216.152.64.131]:9668 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S271758AbRHURe5>; Tue, 21 Aug 2001 13:34:57 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Mike Jagdis" <jaggy@purplet.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: PROBLEM: select() says closed socket readable
Date: Tue, 21 Aug 2001 10:35:10 -0700
Message-ID: <NOEJJDACGOHCKNCOGFOMIEKBDFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2479.0006
In-Reply-To: <3B8223A8.70900@purplet.demon.co.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> David S. Miller wrote:
> >    From: Jay Rogers <jay@rgrs.com>
> >    Date: Mon, 20 Aug 2001 10:34:09 -0400
> >
> >    > Right. It does not block on read, hence it is readable.
> >
> >    No, a socket that's never been connected isn't readable, hence
> >    select() shouldn't be returning a value of 1 on it.
> >
> > You may read without blocking, select() returns 1.

> By this logic a socket that is set non-blocking should always be
> treated as readable. I think we can all agree that argument is
> flawed :-).

	No, because 'select' is defined to work the same on both blocking and
non-blocking sockets. Roughly, select should hit on read if a non-blocking
read wouldn't return 'would block'.

> The prevailing view from other systems appears to be that reading
> from an unconnected (or unconnectING) socket is meaningless so
> the socket is not readable.

	So is reading from a closed or errored socket. There is nothing to wait
for, so why should the system call wait?

> Presumably there is a damn good reason, or a standards reference,
> why that is the wrong behaviour and should be changed?

	If you think about the cases where someone might actually do this, odds are
you want the application's error handling code to launch. That won't happen
if you never break out of select. However, if you do break out of select, do
a read, and get an error, the problem will then be handled, rather than
ignored.

	DS

