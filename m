Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264579AbUFRWtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264579AbUFRWtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265317AbUFRWsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:48:22 -0400
Received: from mail.dif.dk ([193.138.115.101]:41126 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S264579AbUFRWpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:45:51 -0400
Date: Sat, 19 Jun 2004 00:44:55 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: matthew-lkml@newtoncomputing.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
In-Reply-To: <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.56.0406190032290.17899@jjulnx.backbone.dif.dk>
References: <20040618205355.GA5286@newtoncomputing.co.uk>
 <Pine.LNX.4.58.0406181407330.6178@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 18 Jun 2004, Linus Torvalds wrote:
>
>
> On Fri, 18 Jun 2004 matthew-lkml@newtoncomputing.co.uk wrote:
> >
> > The main problem seems to be in ACPI, but I don't see any reason for
> > printk to even consider printing _any_ non-printable characters at all.
> > It makes all characters out of the range 32..126 (except for newline)
> > print as a '?'.
>
> How about emitting them as \xxx, so that you see what they are. And using
> a case-statement to make it easy and clear when to do exceptions (I think
> we should accept \t too, no?).
>

Would there be any reason not to allow all the standard C escape sequences
- true, they are hardly used atm (I see a few \f uses with grep, but not
much else), but it's not unthinkable they could be useful somewhere in
some cases (I'm thinking \f could be useful for console on line-printer
for example, \a could be useful for critical errors on boxes without a
monitor - or maybe that's all too far fetched)...

\a	alert (bell)
\b	backspace
\f	formfeed
\n	newline
\r	carriage return
\t	horizontal tab
\v	vertical tab
\\	backslash
\?	question mark
\'	single quote
\"	double quote

(the last few are in the 32..126 range, just listing for completeness)...
none of them should cause trouble on output, so little reason to exclude
them if someone find a use for them at some point - or am I not making
sense?


 --
Jesper Juhl <juhl-lkml@dif.dk>


