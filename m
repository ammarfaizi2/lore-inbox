Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287103AbRL2DVy>; Fri, 28 Dec 2001 22:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287106AbRL2DVp>; Fri, 28 Dec 2001 22:21:45 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:60176 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287103AbRL2DVb>;
	Fri, 28 Dec 2001 22:21:31 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric S. Raymond" <esr@thyrsus.com>,
        Legacy Fishtank <garzik@havoc.gtf.org>, Dave Jones <davej@suse.de>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 14:27:37 -0800."
             <Pine.LNX.4.33.0112281417410.23445-100000@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 14:21:13 +1100
Message-ID: <8822.1009596073@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 14:27:37 -0800 (PST), 
Linus Torvalds <torvalds@transmeta.com> wrote:
>Note that I do _not_ want to mess up source files with magic comments. I
>absolutely detest those. They only detract from the real job of coding,
>and do not make anybody happier.
>
>We have a hierarchical filesystem. Most drivers already have
>
>	driver.c
>	driver.h
>
>(in fact _very_ few drivers are single-file) and some have a subdirectory
>of their own. So why not just have
>
>	driver.conf
>
>and be done with it. No point in messing up the C file with stuff that
>doesn't add any information to either the programmer _or_ the compiler.

I would love to do that, with each driver/filesystem/... having an
associated control file that defined its config options, its help and
who to make it.  That is, an "Insert New Facility" file, we could call
them driver.inf (ducks and runs ;).

There is one big problem in the way, makefile order controls link order
which controls init order.  I have no problem with the link order
controlling init order, that is far better than the old Space.c code.
I intensely dislike makefile order controlling link order, it results
in loss of information, we have makefiles in a specific order with no
idea about whether that order is required or is just accidental.

IMHO the link order should be divorced from makefile order and made
explicit.  Then you could have makefile fragments associated with each
driver.  But the last time I tried to break the dependency between make
and link order, Linus shot me down in flames[1], so I have no intention
of going there again.  As long as you have monolithic makefiles,
drivers.conf is going to be problematic.

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=97301359812683&w=2

