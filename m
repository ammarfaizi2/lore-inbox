Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261258AbRERAc5>; Thu, 17 May 2001 20:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262002AbRERAcr>; Thu, 17 May 2001 20:32:47 -0400
Received: from shell.ca.us.webchat.org ([216.152.64.152]:55695 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S261258AbRERAcg>; Thu, 17 May 2001 20:32:36 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "Chris Evans" <chris@scary.beasts.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Kernel bug with UNIX sockets not detecting other end gone?
Date: Thu, 17 May 2001 17:32:34 -0700
Message-ID: <NCBBLIEPOCNJOAEKBEAKAEPJPBAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.30.0105180042440.21745-100000@ferret.lmh.ox.ac.uk>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm - there's definitely a Linux inconsistency here. With SOCK_DGRAM,
> read() is blocking but write() is giving ECONNRESET.
>
> The ECONNRESET makes sense to me (despite this being a datagram socket),
> because the sockets are anonymous. Once one end goes away, the other end
> is pretty useless.
>
> Cheers
> Chris

	One can justify any behavior, since this is a datagram socket but the
kernel does know that it has been 'disconnected'. One can even justify the
inconcsistent behavior -- the write definitely has no place to go (now), but
the read can't be totally sure that there is no possible way anybody could
ever find the other end and write to it.	I think it would, however, be
preferable to have it return ECONNRESET in all cases (read, write, and
'select'/'poll' should hit on read and write).

	DS

