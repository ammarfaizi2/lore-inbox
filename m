Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSLOL67>; Sun, 15 Dec 2002 06:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbSLOL67>; Sun, 15 Dec 2002 06:58:59 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:59658 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266407AbSLOL67>;
	Sun, 15 Dec 2002 06:58:59 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: How to do -nostdinc?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Dec 2002 23:06:41 +1100
Message-ID: <1357.1039954001@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are two ways of setting the -nostdinc flag in the kernel Makefile :-

(1) -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
(2) -nostdinc -iwithprefix include

The first format breaks with non-English locales, however the fix is trivial.

(1a) -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

The second format is simpler but there have been reports that it does
not work with some versions of gcc.  I have been unable to find a
definitive statement about which versions of gcc fail and whether the
problem has been fixed.  Anybody care to provide a definitive
statement?

If kernel build cannot rely on gcc working with -nostdinc -iwithprefix include
then we need to convert to (1a).

