Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136474AbREDSDc>; Fri, 4 May 2001 14:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136475AbREDSDX>; Fri, 4 May 2001 14:03:23 -0400
Received: from chromium11.wia.com ([207.66.214.139]:35851 "EHLO
	neptune.kirkland.local") by vger.kernel.org with ESMTP
	id <S136474AbREDSDK>; Fri, 4 May 2001 14:03:10 -0400
Message-ID: <3AF2EFCF.22DCDBA9@chromium.com>
Date: Fri, 04 May 2001 11:07:11 -0700
From: Fabio Riccardi <fabio@chromium.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, David_J_Morse@Dell.com
Subject: Re: X15 alpha release
In-Reply-To: <Pine.LNX.4.33.0105041015230.2178-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,

I'm really impressed by your feedback! How do you manage to discover so many
things?

I fixed the bug, and checked that it hadn't affected my specweb results.

Indeed specweb never issues closing 1.1 connections, it would use a 1.0
request with close in that case.

Moreover even if a client says that it will close the connection and the
server instead leaves it open, the client would just close the connection
anyway, unless there is a (very contrived) bug in the client which would let
itself be diverted from its original intention by an overly talkative
server...

X15 would be indeed negatively affected by these useless idle open
connections cluttering the file descriptor table and consuming resources for
nothing.

I'll post the corrected version later on today.

BTW: is there any _concise_ document specifying the HTTP protocol and its
variants?

 - Fabio

Ingo Molnar wrote:

> Fabio,
>
> i noticed another RFC anomaly in X15. It ignores the "Connection: close"
> request header passed by a HTTP/1.1 client. This behavior is against RFC
> 2616, a server must not override the client's choice of non-persistent
> connection. (there might be HTTP/1.1 clients that do not support
> persistent connections and signal this via "Connection: close".)
>
> the rule is this: a request is either keepalive or non-keepalive. HTTP/1.0
> requests default to non-keepalive. HTTP/1.1 requests default to keepalive.
> The default can be overriden via the "Connection: Keep-Alive" or
> "Connection: close" header fields.
>
> if you fix this, does it impact SPECweb99 performance in any way?
>
>         Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

