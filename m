Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132586AbRD1Ios>; Sat, 28 Apr 2001 04:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRD1Io2>; Sat, 28 Apr 2001 04:44:28 -0400
Received: from chiara.elte.hu ([157.181.150.200]:37903 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S131446AbRD1IoU>;
	Sat, 28 Apr 2001 04:44:20 -0400
Date: Sat, 28 Apr 2001 10:42:29 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <3AEA0C52.FA7CE1F1@chromium.com>
Message-ID: <Pine.LNX.4.33.0104281029390.15790-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fabio,

i noticed one weirdness in the Date-field handling of X15. X15 appears to
cache the Date field too, which is contrary to RFCs:

 earth2:~> wget -s http://localhost/index.html -O - 2>/dev/null | grep Date
 Date: Sat Apr 28 10:15:14 2001
 earth2:~> date
 Sat Apr 28 10:32:40 CEST 2001

ie. there is already a 15 minutes difference between the 'origin date of
the reply' and the actual date of the reply. (i started X15 up 15 minutes
ago.)

per RFC 2616:
.............
The Date general-header field represents the date and time at which the
message was originated, [...]

Origin servers MUST include a Date header field in all responses, [...]
.............

i considered the caching of the Date field for TUX too, and avoided it
exactly due to this issue, to not violate this 'MUST' item in the RFC. It
can be reasonably expected from a web server to have a 1-second accurate
Date: field.

the header-caching in X15 gives it an edge against TUX, obviously, but IMO
it's a questionable practice.

if caching of headers was be allowed then we could the obvious trick of
sendfile()ing complete web replies (first header, then body).

	Ingo

