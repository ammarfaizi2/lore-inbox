Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313060AbSF2Pe4>; Sat, 29 Jun 2002 11:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312973AbSF2Pez>; Sat, 29 Jun 2002 11:34:55 -0400
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:32527 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S313060AbSF2Pey>; Sat, 29 Jun 2002 11:34:54 -0400
Date: Sat, 29 Jun 2002 17:36:18 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Keith Owens <kaos@ocs.com.au>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>, <mec@shout.net>,
       <kbuild-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kconfig: menuconfig and config uses $objtree 
In-Reply-To: <5050.1025315441@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0206291409430.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 29 Jun 2002, Keith Owens wrote:

> What happens when you want to support multiple source trees?

First we should answer the question, why kbuild support for multiple
source trees is such a must have feature? So far I haven't seen a
satisfying answer, that would justify a big increase in kbuild complexity.
Only very few people would need such a feature and often there are other
ways to archive almost the same.
If such a feature is really badly needed, I think it's better to implement
it first as a seperate tool, which synchronizes multiple source dirs into
a single dir. This is not as efficient, as kbuild has to recheck the
single dir, but most of it should be in the cache, so it shouldn't be that
bad. On the other hand it should be easy to integrate in whatever kbuild
system. If there should be a huge demand for a better integration, we can
still do this later.

> What happens when the config data is not in monolithic files but is
> supplied in per-driver files (driver.inf)?  Linus wants that feature
> eventually.  Note that driver.inf will contain more than just config
> data, it will contain all the data required to build a driver.  With
> your approach every CML program would have to be changed to understand
> the format of the driver.inf files, replicating the code over multiple
> parsers.  With my approach you need one program that extracts the
> relevant data for config and builds the config tree, then the existing
> CML programs run unchanged.

The simple answer is to replace all the parsers with a single library,
which is what I'm currently working on. Maintaining multiple config
formats is just silly.

bye, Roman

