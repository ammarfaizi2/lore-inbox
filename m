Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136375AbRD2VVp>; Sun, 29 Apr 2001 17:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136377AbRD2VVf>; Sun, 29 Apr 2001 17:21:35 -0400
Received: from chromium11.wia.com ([207.66.214.139]:62216 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S136376AbRD2VVS>; Sun, 29 Apr 2001 17:21:18 -0400
Message-ID: <3AEC86B7.119362D9@chromium.com>
Date: Sun, 29 Apr 2001 14:25:11 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release: as fast as TUX but in user space
In-Reply-To: <Pine.LNX.4.33.0104281029390.15790-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can disable header caching and see what happens, I'll add an option for this
in the next X15 release.

Nevertheless I don't know how much this is interesting in real life, since on
the internet most static pages are cached on proxies. I agree that the
RFC asks for a date for the original response, but once the response is cached
what does this date mean?

 - Fabio

Ingo Molnar wrote:

> Fabio,
>
> i noticed one weirdness in the Date-field handling of X15. X15 appears to
> cache the Date field too, which is contrary to RFCs:
>
>  earth2:~> wget -s http://localhost/index.html -O - 2>/dev/null | grep Date
>  Date: Sat Apr 28 10:15:14 2001
>  earth2:~> date
>  Sat Apr 28 10:32:40 CEST 2001
>
> ie. there is already a 15 minutes difference between the 'origin date of
> the reply' and the actual date of the reply. (i started X15 up 15 minutes
> ago.)
>
> per RFC 2616:
> .............
> The Date general-header field represents the date and time at which the
> message was originated, [...]
>
> Origin servers MUST include a Date header field in all responses, [...]
> .............
>
> i considered the caching of the Date field for TUX too, and avoided it
> exactly due to this issue, to not violate this 'MUST' item in the RFC. It
> can be reasonably expected from a web server to have a 1-second accurate
> Date: field.
>
> the header-caching in X15 gives it an edge against TUX, obviously, but IMO
> it's a questionable practice.
>
> if caching of headers was be allowed then we could the obvious trick of
> sendfile()ing complete web replies (first header, then body).
>
>         Ingo

