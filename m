Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312348AbSDCTUE>; Wed, 3 Apr 2002 14:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312350AbSDCTT4>; Wed, 3 Apr 2002 14:19:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:24069 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312348AbSDCTTk>; Wed, 3 Apr 2002 14:19:40 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: tigran@aivazian.fsnet.co.uk (Tigran Aivazian)
Date: Wed, 3 Apr 2002 20:35:09 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), andrea@suse.de (Andrea Arcangeli),
        arjanv@redhat.com (Arjan van de Ven), hugh@veritas.com (Hugh Dickins),
        mingo@redhat.com (Ingo Molnar),
        stelian.pop@fr.alcove.com (Stelian Pop), linux-kernel@vger.kernel.org,
        torvalds@transmeta.com (Linus Torvalds)
In-Reply-To: <Pine.LNX.4.33.0204031947210.1163-100000@einstein.homenet> from "Tigran Aivazian" at Apr 03, 2002 08:03:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16sqXF-0004Li-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> > > +EXPORT_SYMBOL(vmalloc_to_page);
> >
> Namely, you are saying that Andrea changed some code from being GPL to
> non-GPL. That is so obviously not true that I am even surprized that I
> need to point this out explicitly (especially to you; as Jesus said to
> Nicodemus, are you a teacher in Israel and knowest not these things?)

He removed the marker to make it clear that is not meant to be used by
non GPL modules and is an internal helper function. Its really to my
mind no different to changing the text of the license - someone elses license -
to delete the linking rules. Even if the change is not valid is misleads
and confuses and is extremely impolite.

> EXPORT_SYMBOL(vmalloc_to_page);
> is just as much under GPL license as the line of code:
> EXPORT_SYMBOL_GPL(vmalloc_to_page);
> 
> So, Andrea's patch is not changing any license of any line of Linux kernel
> code. He is just correcting a _technical_ mistake. Authors are allowed to

He's misleading people and contributing to future infringements. The _GPL
marker is correct, and it is there to assist people like Veritas by telling
them "excuse me this one is not for you". Note that there are higher level
interfaces using it which genuinely do seem to be needed by seperate works
and are not EXPORT_SYMBOL_GPL, as well as others like the Video4Linux buffer
helper logic which is very much a support library.

> make mistakes and others are allowed to fix them. I don't see any problem
> with that (even the wicked US legal system won't jail anyone for it :)

Actually it does. EXPORT_SYMBOL_GPL is a digital rights management system
subverting it is a US offence. Now if anyone was to go cart Andrea off to
jail for that I'd be pretty pissed off. Its stupidity factor is stunningly
high but it doesn't change the reality. Nor for that matter should anyone
forget that stupid laws can be used for good as well as evil some times 8)

> I understood the intention of EXPORT_SYMBOL_GPL was (from your email
> mentioning the internal helpers etc) is that it is for internal helper
> functions used by some parts of the kernel which happen to be
> modularizable, but not for general consumption of 3rd party modules.  So,
> really, the name EXPORT_SYMBOL_GPL is a _misnomer_.

It makes it clear what it is usable by. I don't as such consider it a 
misnomer. Now EXPORT_SYMBOL_INTERNAL would be a godsend for a lot of other
stuff. It would help binary folks and a lot of GPL driver folks know that
they were sticking their nose in the wrong spot and might get burned. At
that point they can make an intelligent assessment. Maybe they do need to
stick their noses in, maybe they should look at the right approach.

However _GPL and _INTERNAL are two different things. Linus has said he won't
allow people to go around removing existing symbols people rely on. Its not
quite my own viewpoint but Linus argues quite reasonably that he has at least
a moral reason to not go around screwing people and its his toy.

	modprobe -w mynewdriver.o
	Warning: This driver appears to use kernel internal interfaces
	that are very likely to change over time.
	[... list of symbols ...]

sound good. Its sort of a lint for driver authors. I support the addition
of _INTERNAL as _well_ as _GPL completely. Although maybe at that point its
time to think about EXPORT_SYMBOL(name, attributes) before Keith Owens goes
missing in a combinatorial explosion.

Alan
