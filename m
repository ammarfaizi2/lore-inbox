Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSHOUJV>; Thu, 15 Aug 2002 16:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317400AbSHOUJV>; Thu, 15 Aug 2002 16:09:21 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:9491 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S317399AbSHOUJN>; Thu, 15 Aug 2002 16:09:13 -0400
Date: Thu, 15 Aug 2002 22:12:08 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
cc: Greg Banks <gnb@alphalink.com.au>, Peter Samuelson <peter@cadcamlab.org>,
       <linux-kernel@vger.kernel.org>, <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: [patch] config language dep_* enhancements
In-Reply-To: <Pine.LNX.4.44.0208150937270.849-100000@chaos.physics.uiowa.edu>
Message-ID: <Pine.LNX.4.44.0208151717460.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 15 Aug 2002, Kai Germaschewski wrote:

> Surely not all conceptual problems are fixable easily, they probably need
> to be done in conjunction with switching to a common parser etc. (Note:
> this switch to a new parser should happen with no change to the config.in
> format or semantics, in order to fit the Linux/Linus way of doing things).

This is where I disagree. Switching the parser and the syntax separately
would mean two big changes, that need to be tested. You actually have to
write two parsers, one that emulates the shell behaviour as exactly as
possible and a second parser that get rids of that again. Doing a single
switch would be far less painful.
There are some corner cases in the current rulebase, which are difficult/
ambiguous for a compiling parser (instead of interpreting). These cases
are mostly in arch/*/config.in files, which were probably never tested
with xconfig.
My converter can convert almost everything, with some small changes to the
input files it should also be able to convert the rest. The resulting
needs some small editing to be completely useable, so this process is not
completely automatic (The reason for this are the recursive dependencies,
which need some small manual fixing).
I tried very hard to make that switch as painless as possible. By
automatically converting the config the rulebase is still almost the same.
Normal users will hardly see a difference (except for xconfig, as that
is reimplemented in QT).

> However, I think it is too late in 2.5 for these kind of big changes.

Most of the work is actually already done, there isn't that much left to
be completely usable. If anyone wants to help, I'd be happy.

bye, Roman

