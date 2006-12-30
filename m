Return-Path: <linux-kernel-owner+w=401wt.eu-S1754431AbWL3WOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbWL3WOd (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 17:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWL3WOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 17:14:33 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:39816 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754426AbWL3WOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 17:14:32 -0500
X-Originating-Ip: 74.109.98.100
Date: Sat, 30 Dec 2006 17:08:53 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <200612302149.35752.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
 <200612302149.35752.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006, Denis Vlasenko wrote:

> On Friday 29 December 2006 07:16, Robert P. J. Day wrote:
> >
> >   is there some reason there are so many calls of the form
> >
> >   memset(addr, 0, PAGE_SIZE)
> >
> > rather than the apparently equivalent invocation of
> >
> >   clear_page(addr)
> >
> > the majority of architectures appear to define the clear_page()
> > macro in their include/<arch>/page.h header file, but not entirely
> > identically, and in some cases that definition is conditional, as
> > with i386:
> >
> > =============================================================
> > #ifdef CONFIG_X86_USE_3DNOW
> > ...
> > #define clear_page(page)        mmx_clear_page((void *)(page))
> > ...
> > #else
> > ...
> > #define clear_page(page)        memset((void *)(page), 0, PAGE_SIZE)
> > ...
> > #endif
> > ============================================================
> >
> >   should it perhaps be part of the CodingStyle doc to use the
> > clear_page() macro rather than an explicit call to memset()?
> > (and should all architectures be required to define that macro?)
>
> clear_page assumes that given address is page aligned, I think. It
> may fail if you feed it with misaligned region's address.

i don't see how that can be true, given that most of the definitions
of the clear_page() macro are simply invocations of memset().  see for
yourself:

  $ grep -r "#define clear_page" include

my only point here was that lots of code seems to be calling memset()
when it would be clearer to invoke clear_page().  but there's still
something a bit curious happening here.  i'll poke around a bit more
before i ask, though.

rday
