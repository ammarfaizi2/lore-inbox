Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262478AbSI2NtG>; Sun, 29 Sep 2002 09:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSI2NtG>; Sun, 29 Sep 2002 09:49:06 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:24255 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S262478AbSI2NtE>;
	Sun, 29 Sep 2002 09:49:04 -0400
To: <linux-kernel@vger.kernel.org>
Subject: Re: Generic HDLC interface continued
References: <m3y99nrtsu.fsf@defiant.pm.waw.pl>
	<20020928202138.A17244@se1.cogenit.fr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 29 Sep 2002 15:49:22 +0200
In-Reply-To: <20020928202138.A17244@se1.cogenit.fr>
Message-ID: <m3smzsnbx9.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@cogenit.fr> writes:

> > Addressing the second problem (unknown data length) requires the caller
> > (user-space utils) to supply allocated space size. The kernel would
> > update the size to reflect the actual amount of data required, allowing
> > the caller to allocate more space and try again (or ignore the unknown
> > interface).
> 
> If size/limit of an underlying object is in a structure for other purpose
> than debygging, it means something (S) is working with an object and it (S)
> doesn't know what it is.
> Design proble: always work with an object whose 
> identity you know or simply pass a reference to someone knowing better.

Not exactly. The caller always knows meaning of the returned value
(or it reports error etc). The caller doesn't just know size of the value
_in_advance_, as it isn't constant. Still, meaning of the variable portion
of the data is defined by the constant part.

It won't be a problem if allocating space is a kernel task.

> struct ifreq
...

>         struct {
>              int type;
>              union {
>                  raw_hdlc_proto *;
>                  ...
>                  sync_serial_settings *;
>                  etc_line_settings *;
> 			}
> 		} ifru_settings;
>     } ifr_ifru;
> };
> 
> Note however that struct ifreq on amphetamin (wrt lines of code) doesn't 
> improve readability for everybody. That's a slightly different problem.

Of course, I didn't want to include all the member structs directly
in ifreq definition (in the header file). I just did it for the purpose
of discussion.

> > What is important here is that inner union consists of pointers
> > to *_proto / *_settings structs and not of the structs themselves.
> 
> Agree on this.
> 
> > Another solution - using a different ifreq structs for different tasks
> > (something like the sockaddr_*) - sort of:
> [...]
> 
> I am not too fond of this and, again, what are these 'size' for ?
> If it's supposed to replace/duplicate ifreq, the 'settings' part should
> be a pointer imho. Same reason as before: size change => compatibility 
> problems for tools (we have sources but downgrading tools when returning to
> previous kernel sucks).

Yes. That's why I want to finally have a well-designed interface,
with no need for changes in the future (except as needed for new
interfaces/protocols etc).
That's why I want to do it in 2.5 and then downport it to 2.4
and possibly even to 2.2.
-- 
Krzysztof Halasa
Network Administrator
