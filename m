Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287449AbSA0BaZ>; Sat, 26 Jan 2002 20:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287464AbSA0BaO>; Sat, 26 Jan 2002 20:30:14 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:11276 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S287439AbSA0BaE>; Sat, 26 Jan 2002 20:30:04 -0500
Date: Sat, 26 Jan 2002 19:29:58 -0600
To: brendan.simon@bigpond.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: touch commands in Makefiles
Message-ID: <20020127012958.GB645@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Brendan Simon]
> Why are header file touched in Makefiles ?

Dependency reasons.  Header files depend on whatever CONFIG options
they reference, and this is implemented via proxy header files.  Say
you have foo.c which includes foo_bar.h which makes a reference to
CONFIG_BAR.  The correct dep tree would be

  foo.o: foo.c foo_bar.h CONFIG_BAR

but, as it turned out, it was easier / more efficient to represent the
tree as

  foo.o: foo.c foo_bar.h
  foo_bar.h: CONFIG_BAR

This second tree is not strictly correct -- foo_bar.h does *not* in
fact need to be rebuilt when CONFIG_BAR changes -- so the 'touch'
commands are there to make it work correctly.

If you don't like it (and most of us don't!), you should patch your
tree with Keith Owens's 2.5 makefile structure, "kbuild-2.5".  It fixes
this problem (and many others).  It is hoped that kbuild-2.5 will be
merged with Linux 2.5 in the near future.

Peter
