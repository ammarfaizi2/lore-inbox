Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264710AbTE1Mkz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264709AbTE1Mkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:40:55 -0400
Received: from mail.convergence.de ([212.84.236.4]:9689 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264710AbTE1Mku
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:40:50 -0400
Message-ID: <3ED4B16C.8030000@convergence.de>
Date: Wed, 28 May 2003 14:54:04 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: DVB updates, 2nd try
References: <3ED3634A.2000608@convergence.de> <20030528111202.A27811@infradead.org>
In-Reply-To: <20030528111202.A27811@infradead.org>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

>  - looks fine (obsiously :)).  If the old driver works with the
>    new firware I'd suggets sending it to Linux now

Yes, it should. It has some extended features, which are only visible 
through new ioctl, though.

> 02-saa7146-core.diff
> 
>  - the WRITE_RPS0 macro is ugly as hell, you probably want to
>     replace it with a proper inline.  But you can leave this to
>     a later patch.  If it doesn't need the other updates I'd
>     suggest submitting it now.

I'd leave this to a later patch.

> 03-dvb-core.diff
> 
>  - okay, this is a big one..  Could you submit the typedef removal
>    as a first separate patch so the actual changes are reviewable
>    more easily?

That's very difficult. I just had a look through the cvs changelogs and 
talked to a collegue: apparently, there haven't been any important 
bugfixes to the code -- only the major cleanups to get the code into 
"kernel shape" (typdef removals, use 16 instead of uint16_t, ...)

It would cause me a major pain to separate these diffs, because I did 
not tag the code very often. (my fault, I know)

The code just "works" for the dvb-subsystem, so I hope there is nothing 
to worry about for other coders.

>  - please use <linux/types.h> not <asm/types.h> everywhere
 >  - please include <asm/*.h> headers after <linux/*.h> ones

Ok, comes with the next patch.

>  - This is wrong:
> -static struct dvb_device dvbdev_dvr = {
> +static
> +struct dvb_device dvbdev_dvr = {
>    instead of breaking the indention rather fix the reamining parts
>    of the driver

It's already hard enough to make all these changes, make sure everything 
compiles and works for both 2.4 and 2.5, then create the patches and ... 
get rejected. 8-)

If there aren't any other objections, I'd like to ask to apply these 
patches.

The "kernel thread uses BKL" issue works for us, but can reviewed by the 
  responsible author of course.

CU
Michael.

