Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUAPT4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 14:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUAPT4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 14:56:05 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:52989 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265801AbUAPT4A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 14:56:00 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Pavel Machek <pavel@suse.cz>, Aaron Lehmann <aaronl@vitelus.com>
Subject: Re: [PATCH] stronger ELF sanity checks v2
Date: Fri, 16 Jan 2004 13:55:23 -0600
X-Mailer: KMail [version 1.2]
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Eric Youngdale <eric@andante.org>,
       Eric Youngdale <ericy@cais.com>
References: <Pine.LNX.4.56.0401130228490.2265@jju_lnx.backbone.dif.dk> <20040113033234.GD2000@vitelus.com> <20040116160841.GA302@elf.ucw.cz>
In-Reply-To: <20040116160841.GA302@elf.ucw.cz>
MIME-Version: 1.0
Message-Id: <04011613552300.04912@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 January 2004 10:08, Pavel Machek wrote:
> Hi!
>
> > On Tue, Jan 13, 2004 at 02:55:07AM +0100, Jesper Juhl wrote:
> > > Here's the second version of my patch to add better sanity checks for
> > > binfmt_elf
> >
> > I assume this breaks Brian Raiter's tiny ELF executables[1]. Even
> > though these binaries are evil hacks that don't comply to standards
> > and serve no serious purpose, I'm not sure what the purpose of the
> > sanity checks is. Are there any risks associated with running
> > non-compliant ELF executables? (Now that I mention it, the
>
> You get vy ugly behaviour. If you compile executable with huge static
> data, it will compile okay, link okay, *launch okay* and die on
> segfault. That's wrong, it should have died on -ENOMEM during exec.
> 								Pave

Wouldn't that depend on the overcommit options?

With permitted overcommit -
	compile/link ok
	launch - segfault/-ENOMEM if heap/stack + static data UPDATES exceed
		 system capacity
Without overcommit:
	-ENOMEM if the heap/stack can't be initialized; as in even the
		first page of the heap/stack fails - and before actual
		launch completes, as the situation you describe.

If static data is just referenced, it should page in, and get dropped.
