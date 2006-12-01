Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935072AbWLAN6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935072AbWLAN6V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 08:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936500AbWLAN6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 08:58:21 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:17355 "EHLO
	vervifontaine.sonycom.com") by vger.kernel.org with ESMTP
	id S935072AbWLAN6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 08:58:21 -0500
Date: Fri, 1 Dec 2006 14:58:16 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: `make checkstack' and cross-compilation
Message-ID: <Pine.LNX.4.62.0612011455040.19178@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Makefile has:
| # Use $(SUBARCH) here instead of $(ARCH) so that this works for UML.
| # In the UML case, $(SUBARCH) is the name of the underlying
| # architecture, while for all other arches, it is the same as $(ARCH).
| checkstack:
|         $(OBJDUMP) -d vmlinux $$(find . -name '*.ko') | \
|         $(PERL) $(src)/scripts/checkstack.pl $(SUBARCH)

While this may fix `make checkstack' for UML, it breaks cross-compilation.
E.g. when cross-compiling for PPC on ia32, ARCH=powerpc, but SUBARCH=i386.

Probably it should use SUBARCH if ARCH=um, and ARCH otherwise?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
