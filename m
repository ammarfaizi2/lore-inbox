Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129805AbQK0XGW>; Mon, 27 Nov 2000 18:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129821AbQK0XGM>; Mon, 27 Nov 2000 18:06:12 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14184 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S129805AbQK0XGA>; Mon, 27 Nov 2000 18:06:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Peter Samuelson <peter@cadcamlab.org>
cc: Russell King <rmk@arm.linux.org.uk>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>, Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
Subject: Re: silly [< >] and other excess 
In-Reply-To: Your message of "Mon, 27 Nov 2000 16:02:13 MDT."
             <20001127160213.F8881@wire.cadcamlab.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 Nov 2000 09:35:37 +1100
Message-ID: <1368.975364537@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2000 16:02:13 -0600, 
Peter Samuelson <peter@cadcamlab.org> wrote:
>
>  [Albert D. Cahalan]
>> > Somebody else posted a reasonable hack for the [<>] problem.  His
>> > proposal involved letting multiple values share the same markers,
>> > something like this:
>Me too. (:  Keith posed two objections:
>
>1. The >] could get word-wrapped so that it doesn't appear on the same
>   line as the [<.  I *do not* see what makes this hard to parse
>   reliably.

People seem to have forgotten that reading an oops from the screen is
not the only source of data.  Many oops are read from syslog which
contains lots of different lines, most of which have no identification.
ksymoops has to pick out oops text from a syslog and ignore all the
non-oops lines.

If the oops text is just a hex number with no identifying characters
then it is very difficult to pick out oops text from all the other
noise in syslog.  ksymoops already gets false positives and prints some
non-oops text, this confuses users who think that these lines are
related to the oops.

Removing [< >] increases the already high level of ambiguity and false
positives in oops reporting from syslog.  The presence of the marker
characters makes the output more robust when line wrapped, without the
markers a line wrapped trace is just a hex number.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
