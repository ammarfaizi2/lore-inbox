Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbTHSVoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261641AbTHSVoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:44:22 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:42768 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261533AbTHSVlr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:41:47 -0400
Date: Tue, 19 Aug 2003 23:41:44 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, akpm@ravnborg.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: kbuild: Separate ouput directory support
Message-ID: <20030819214144.GA30978@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	akpm@ravnborg.org, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following set of patches introduce support for
separate output directory when building a kernel.
Typical usage is building several kernels with different configurations -
but based on the same kernel src.

Consider the following setup:
/home/sam/bk/linux-2.6		<= kernel src

/home/sam/kernel/mars		<= My workstation
/home/sam/kernel/defconfig	<= defconfig for compiletime testing

Then in order to handle the two different configurations I just have to do:
cd /home/sam/bk/linux-2.6
make O=../../kernel/mars

And the same for the defconfig version.

All output files are stored in the output directory, including .config.
[Thanks to Roman Zippel which made this loong time ago in kconfig].

The patch has been in existence in several months but only lately becoming
in a suitable state ready for inclusion. It is developed based on an initial
concept made by Kai Germaschewski, but refined a lot since then.
It works with a kernel based on default configuration (make defconfig).

It is divided up in the following parts:
core	the kbuild changes to support separate output directory
ieee	Fix in ieee Makefile
i386	Fix in i386 Makefiles + new syntax enabled for always
	This was required because i386 had an executable located in
	a subdirectory.
include	Fixes for errornous include paths, and one place where a generated
	.c file references a .h file in the kernel tree.
	

Please pull from
	bk pull bk://linux-sam.bkbits.net/kbuild

Patches follows this mail.

	Sam
