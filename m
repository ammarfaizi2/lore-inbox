Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261939AbSJJTCw>; Thu, 10 Oct 2002 15:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261972AbSJJTCw>; Thu, 10 Oct 2002 15:02:52 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:29646 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S261939AbSJJTCu>;
	Thu, 10 Oct 2002 15:02:50 -0400
Date: Thu, 10 Oct 2002 21:08:26 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Pavel Selivanov <pavel-linux-kernel@parabel.inc.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generic HDLC interface continued
Message-ID: <20021010210826.A17200@fafner.intra.cogenit.fr>
References: <35278845015.20021010232749@parabel.inc.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <35278845015.20021010232749@parabel.inc.ru>; from pavel-linux-kernel@parabel.inc.ru on Thu, Oct 10, 2002 at 11:27:49PM +0700
X-Organisation: Marie's fan club - III
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Pavel Selivanov <pavel-linux-kernel@parabel.inc.ru> :
[...]
> 1) I think that hdlc stack should know nothing about my interface type
> (whether it's V.35, DSL, E1/T1, HPPI, ...).
>  I'm sure that hdlc stack must provide only protocols support (and a
>  configuration utility to configure protocol's parameters only).
>  All other job is developer's problem (even crc type).

Then every driver must implement it's own ioctl() and utility. 
Ahum...

[...]
>  Possible it's reasonable to make another utility like ethertool (called, for
>  example, e1tool, mdsltool,...) and complementary header (ioctls, structs,...)
>  for configuring interface(for E1: crc4, timeslots,
>  ...), and getting stats.

mv sethdlc.c hdlctool.c ?

>  2) If I've understand author's ideology, he is going to implement
>  hdlc stack "near" current network stack.
>  I mean hdlc_device appends new fields to net_device, so hdlc device
>  is still the same device as ethernet, and that's fine.

I'd rather have hdlc_device pointing to it's own net_device instead of 
embedding it directly but I won't fight too much about this (so far :o) ).

[struct if_settings and friends]
> Is it really necessary ?

Yes, it's used. It may/will be done slightly differently.

> At my opinion it would be better to use char *,

It provides less type-checking at compile time.

> and to define it in hdlc.h, hdlc/ioctl.h

{hdlc/line}_settings are defined in hdlc/ioctl.h
Others layer 2 protocols may use if_settings (they don't seem to be in a
hurry though :o) ).

[include/linux/if.h - IF_IFACE_XYZ/IF_PROTO_ABC]
> As I understand, it will be never able to make something like
> ppp-over-framerelay...
> But it is widely used, and (for example) negraph in xBSD provide's
> such functionality...

Imho hacking drivers/net/wan/hdlc_fr.c::fr_rx() and hdlc/ioctl.h isn't
the hardest part of ppp-over-fr for those who really need it.

[struct hdlc_device]
> If someone will have to support one more protocol, he have to modify
> hdlc.h (to add new struct in the union)...

Do you have a specific protocol in mind ?

> Why don't we do like this:
[snip, snip]

Admitting there is a heap of ppp-over-fr code waiting to be included and
even if someone is ready to code this all, I'm for a lazyer solution. :o)

-- 
Ueimor
