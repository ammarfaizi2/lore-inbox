Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135914AbREDI0n>; Fri, 4 May 2001 04:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135919AbREDI0e>; Fri, 4 May 2001 04:26:34 -0400
Received: from chiara.elte.hu ([157.181.150.200]:25867 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S135914AbREDI0W>;
	Fri, 4 May 2001 04:26:22 -0400
Date: Fri, 4 May 2001 10:24:40 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Fabio Riccardi <fabio@chromium.com>
Cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Christopher Smith <x@xman.org>, Andrew Morton <andrewm@uow.edu.au>,
        "Timothy D. Witham" <wookie@osdlab.org>, <David_J_Morse@Dell.com>
Subject: Re: X15 alpha release
In-Reply-To: <3AF20CE3.63C92B3C@chromium.com>
Message-ID: <Pine.LNX.4.33.0105041015230.2178-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fabio,

i noticed another RFC anomaly in X15. It ignores the "Connection: close"
request header passed by a HTTP/1.1 client. This behavior is against RFC
2616, a server must not override the client's choice of non-persistent
connection. (there might be HTTP/1.1 clients that do not support
persistent connections and signal this via "Connection: close".)

the rule is this: a request is either keepalive or non-keepalive. HTTP/1.0
requests default to non-keepalive. HTTP/1.1 requests default to keepalive.
The default can be overriden via the "Connection: Keep-Alive" or
"Connection: close" header fields.

if you fix this, does it impact SPECweb99 performance in any way?

	Ingo

