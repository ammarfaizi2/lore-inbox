Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSHGVlA>; Wed, 7 Aug 2002 17:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSHGVlA>; Wed, 7 Aug 2002 17:41:00 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:28947 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313638AbSHGVk7>; Wed, 7 Aug 2002 17:40:59 -0400
Date: Wed, 7 Aug 2002 18:44:23 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jesse Barnes <jbarnes@sgi.com>
cc: linux-kernel@vger.kernel.org, <jmacd@namesys.com>, <phillips@arcor.de>,
       <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020807213949.GA27258@sgi.com>
Message-ID: <Pine.LNX.4.44L.0208071842060.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Jesse Barnes wrote:

> > The MUST_NOT_HOLD basically means the kernel will OOPS the
> > moment the lock is contended.
>
> I think those macros were intended to enforce lock ordering in the
> scsi layer (though I'm not sure).

If you can prove that a MUST_NOT_HOLD(foolock) will never
trigger because it is already protected by other locks,
then what's the point of having that foolock in the first
place ?   (since the region is already protected...)

If the foolock is actually protecting something, then by
definition lock contention is possible and the kernel will
Oops in MUST_NOT_HOLD(foolock).

> > If you want to detect lock recursion on the same CPU, I'd
> > suggest the following:
> > ...
>
> Of course, that's what the lockmetering code does, IIRC, but I think
> that's a feature for a seperate patch.

Agreed.

Btw, the MUST_HOLD macro _is_ straightforward and extremely
useful. IMHO it'd be a shame to have only the SCSI code use it ;)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

