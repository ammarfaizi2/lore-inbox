Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285461AbRL2U1D>; Sat, 29 Dec 2001 15:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285449AbRL2U0x>; Sat, 29 Dec 2001 15:26:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24070 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S285453AbRL2U0l>; Sat, 29 Dec 2001 15:26:41 -0500
Date: Sat, 29 Dec 2001 12:23:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Keith Owens <kaos@ocs.com.au>
cc: Legacy Fishtank <garzik@havoc.gtf.org>, <linux-kernel@vger.kernel.org>,
        Larry McVoy <lm@bitmover.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        Dave Jones <davej@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: State of the new config & build system 
In-Reply-To: <7861.1009589244@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0112291221210.30748-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Dec 2001, Keith Owens wrote:
>
> Yes, some of the problems with mkdep can be fixed in the current design
> but there is one problem that is inherently unfixable.  make dep is a
> manual process so it relies on users knowing when they have to rerun
> make dep AND THEY DON'T DO IT!

Don't be silly.

Make the dependency file itself depend on all the files it describes, and
add a makefile rule to re-generate it. Poof, problem gone.

> Dependencies _do_ change when your .config changes,

Only if you do them wrong. Look at mkdep.c - it statically determines the
complete list of header files that _can_ be included, and does not care at
all about what config options there are.

> that are included varies.  gcc -MD gets this exactly right, gcc knows
> which files it read.

Bzzt, it knows the subset of files to read, nothing more.

		Linus

