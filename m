Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWFZBCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWFZBCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWFZBCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:02:11 -0400
Received: from terminus.zytor.com ([192.83.249.54]:26767 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964993AbWFZA7i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 20:59:38 -0400
Date: Sun, 25 Jun 2006 17:58:10 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: linux-kernel@vger.kernel.org, klibc@zytor.com
Subject: [klibc 42/43] dash - a small POSIX shell for klibc
Message-Id: <klibc.200606251757.42@tazenda.hos.anvin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[klibc] dash - a small POSIX shell for klibc

A port of dash, a size-optimized version of ash by Herbert Xu, for
klibc.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>

---
commit c61927fa211e3c54be7e868f41a4a1b99768111f
tree bcc3c134be8c85809d4d7ef00aa4c6e183398440
parent 6c2ddf4b91c2c390ef4568c02204f0af26fae842
author H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:59:03 -0700
committer H. Peter Anvin <hpa@zytor.com> Sun, 25 Jun 2006 16:59:03 -0700

 usr/dash/Kbuild          |  146 +++
 usr/dash/README.klibc    |    7 
 usr/dash/TOUR            |  356 +++++++
 usr/dash/alias.c         |  227 ++++
 usr/dash/alias.h         |   52 +
 usr/dash/arith.y         |  155 +++
 usr/dash/arith_yylex.c   |  163 +++
 usr/dash/bltin/bltin.h   |   89 ++
 usr/dash/bltin/echo.1    |  109 ++
 usr/dash/bltin/printf.1  |  354 +++++++
 usr/dash/bltin/printf.c  |  476 +++++++++
 usr/dash/bltin/test.1    |  309 ++++++
 usr/dash/bltin/test.c    |  500 ++++++++++
 usr/dash/builtins.def.in |   92 ++
 usr/dash/cd.c            |  303 ++++++
 usr/dash/cd.h            |   35 +
 usr/dash/config.h        |   85 ++
 usr/dash/error.c         |  233 +++++
 usr/dash/error.h         |  145 +++
 usr/dash/eval.c          | 1100 ++++++++++++++++++++++
 usr/dash/eval.h          |   62 +
 usr/dash/exec.c          |  869 +++++++++++++++++
 usr/dash/exec.h          |   77 ++
 usr/dash/expand.c        | 1744 ++++++++++++++++++++++++++++++++++
 usr/dash/expand.h        |   83 ++
 usr/dash/funcs/cmv       |   47 +
 usr/dash/funcs/dirs      |   71 +
 usr/dash/funcs/kill      |   47 +
 usr/dash/funcs/login     |   36 +
 usr/dash/funcs/newgrp    |   35 +
 usr/dash/funcs/popd      |   71 +
 usr/dash/funcs/pushd     |   71 +
 usr/dash/funcs/suspend   |   39 +
 usr/dash/gendeps.pl      |   38 +
 usr/dash/hetio.c         |  397 ++++++++
 usr/dash/hetio.h         |   22 
 usr/dash/histedit.c      |  492 ++++++++++
 usr/dash/init.h          |   39 +
 usr/dash/input.c         |  563 +++++++++++
 usr/dash/input.h         |   68 +
 usr/dash/jobs.c          | 1499 ++++++++++++++++++++++++++++++
 usr/dash/jobs.h          |  109 ++
 usr/dash/machdep.h       |   53 +
 usr/dash/mail.c          |  112 ++
 usr/dash/mail.h          |   38 +
 usr/dash/main.c          |  349 +++++++
 usr/dash/main.h          |   54 +
 usr/dash/memalloc.c      |  329 ++++++
 usr/dash/memalloc.h      |   97 ++
 usr/dash/miscbltin.c     |  457 +++++++++
 usr/dash/miscbltin.h     |   31 +
 usr/dash/mkbuiltins      |  101 ++
 usr/dash/mkinit.c        |  476 +++++++++
 usr/dash/mknodes.c       |  448 +++++++++
 usr/dash/mksyntax.c      |  315 ++++++
 usr/dash/mktokens        |   92 ++
 usr/dash/myhistedit.h    |   45 +
 usr/dash/mystring.c      |  209 ++++
 usr/dash/mystring.h      |   58 +
 usr/dash/nodes.c.pat     |  166 +++
 usr/dash/nodetypes       |  144 +++
 usr/dash/options.c       |  547 +++++++++++
 usr/dash/options.h       |   86 ++
 usr/dash/output.c        |  385 ++++++++
 usr/dash/output.h        |  112 ++
 usr/dash/parser.c        | 1556 +++++++++++++++++++++++++++++++
 usr/dash/parser.h        |   96 ++
 usr/dash/redir.c         |  475 +++++++++
 usr/dash/redir.h         |   49 +
 usr/dash/sh.1            | 2332 ++++++++++++++++++++++++++++++++++++++++++++++
 usr/dash/shell.h         |   94 ++
 usr/dash/show.c          |  403 ++++++++
 usr/dash/show.h          |   45 +
 usr/dash/system.c        |  191 ++++
 usr/dash/system.h        |   91 ++
 usr/dash/trap.c          |  443 +++++++++
 usr/dash/trap.h          |   52 +
 usr/dash/var.c           |  676 +++++++++++++
 usr/dash/var.h           |  146 +++
 79 files changed, 22768 insertions(+), 0 deletions(-)

Patch suppressed due to size (577 K), available at:
http://www.kernel.org/pub/linux/kernel/people/hpa/klibc-patchset/42-dash---a-small-posix-shell-for-klibc.patch
