Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTIOXF5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 19:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTIOXF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 19:05:57 -0400
Received: from h-69-3-93-149.SNVACAID.covad.net ([69.3.93.149]:40127 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S261651AbTIOXFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 19:05:51 -0400
Date: Mon, 15 Sep 2003 15:31:51 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200309152231.h8FMVph11922@freya.yggdrasil.com>
To: ink@jurassic.park.msu.ru, maz@wild-wind.fr.eu.org, mec@shout.net
Subject: linux-2.6.0-test5/drivers/eisa verbose build failure
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	linux-2.6.0-test5/drivers/eisa fails to build if KBUILD_VERBOSE=1
in the top level Linux Makefile (KBUILD_VERBOSE=1 causes the build
process to show the actual commands that are being executed).

	linux-2.6.0-test5/drivers/eisa/Makefile contains a change
that tries to use the Linux KBUILD_VERBOSE system to control
echoing of a command that contains some single quotes.  It looks
like scripts/Makefile.lib contains some macros designed to put
backslashes in front of single quotes as necessary to handle this
case, but, somehow, this is not happening.  The build process attempts
to execute an echo command without the single quotes escaped, and the
result is a shell syntax error:

make -f scripts/Makefile.build obj=drivers/eisa
/bin/sh: -c: line 1: syntax error near unexpected token `("'
/bin/sh: -c: line 1: `echo '  sed -e '/^#/D' -e 's/^\([[:alnum:]]\{7\}\) \+"\([^"]\{1,49\}\).*"/EISA_DEVINFO ("\1", "\2"),/' drivers/eisa/eisa.ids > drivers/eisa/devlist.h' && sed -e '/^#/D' -e 's/^\([[:alnum:]]\{7\}\) \+"\([^"]\{1,49\}\).*"/EISA_DEVINFO ("\1", "\2"),/' drivers/eisa/eisa.ids > drivers/eisa/devlist.h'
make[2]: *** [drivers/eisa/devlist.h] Error 2
make[1]: *** [drivers/eisa] Error 2
make: *** [drivers] Error 2

	I'm not sure if this is a bug in drivers/eisa/Makefile or
some part of kbuild (probably something in scripts/Makefile.lib).
I do not see any changes in linux-2.6.0-test5-bk3 that look like
they would fix the problem, although I have yet to try it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
