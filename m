Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSHNLh2>; Wed, 14 Aug 2002 07:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316615AbSHNLh2>; Wed, 14 Aug 2002 07:37:28 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:43790 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316609AbSHNLh2>; Wed, 14 Aug 2002 07:37:28 -0400
Date: Wed, 14 Aug 2002 13:40:48 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Peter Samuelson <peter@cadcamlab.org>
cc: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       Greg Banks <gnb@alphalink.com.au>, <linux-kernel@vger.kernel.org>,
       <kbuild-devel@lists.sourceforge.net>
Subject: Re: [patch] config language dep_* enhancements
In-Reply-To: <20020813204829.GJ761@cadcamlab.org>
Message-ID: <Pine.LNX.4.44.0208141242280.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 13 Aug 2002, Peter Samuelson wrote:

> Mutating the language, long-term, so that it looks less like sh and
> more like a specialised language, is IMO a worthy goal.  And I think
> it can be done.  The main thing to deal with is adding an alternative
> syntax for 'if' statements which doesn't look like test(1).  More
> about that in a separate message.

That doesn't solve any of the more fundamental problems.
1) We still have 3 config parsers, which produce slightly different
.config files.
2) To integrate a new driver, you have to touch at least 3 files:
Config.in, Config.help, Makefile. Properly configuring and building a
driver outside of the tree is painful to impossible.

I'm not against fixing the bugs in the config scripts or adding some
small extensions, but if you want to "mutate" the language into something
different, I really hope you have a good plan for that.
The problems are really not simple, the current config language is very
limited, which also limits a bit the current error sources. As soon as you
add new features, you need to add better error checking, which will be
very painful in pure shell and keeping it consistent between multiple
parsers will also be interesting.
It's not the same problem area as with the build system. There we only
have a single Rules.make file. Normal users don't need to care much about
it. make was actually designed to build applications. The build system can
rely on correct information from the config system.
The build system was fixable within the capabilities of make, but the
config system involves a lot more complex system of various scripts and
programs. If you some great ideas to fix all the problems, I'd really like
to hear them.

bye, Roman

