Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbSLTGbV>; Fri, 20 Dec 2002 01:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267734AbSLTGbV>; Fri, 20 Dec 2002 01:31:21 -0500
Received: from air-2.osdl.org ([65.172.181.6]:20412 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267727AbSLTGbV>;
	Fri, 20 Dec 2002 01:31:21 -0500
Date: Thu, 19 Dec 2002 22:38:19 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <linux-kernel@vger.kernel.org>
Subject: pr_debug() and #define DEBUG usage
Message-ID: <Pine.LNX.4.33L2.0212192235020.32456-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Some drivers, filesystems, subsystems, and libraries #define or use
DEBUG locally in their source files.  This can conflict with DEBUG
in include/linux/kernel.h, specifically the "pr_debug" macro, which
has over 300 uses (invocations, calls) in 2.5.52 spread throughout
drivers, libraries, and filesystems.

Question:
How should DEBUG be enabled for use by include/linux/kernel.h ?
a.  change CFLAGS_KERNEL in linux/Makefile to include "-DDEBUG"
b.  #define DEBUG in include/linux/kernel.h
c.  #define DEBUG in each file where someone wants to enable it
d.  others?

"DEBUG" seems heavily used (or overused, misused, abused) and too
generic.

And in one place, it keeps a kernel build from completing when
DEBUG is defined.  In lib/inflate.c, line 999:
  fprintf(stderr, "<%u> ", h);
gcc just doesn't like this line.

-- 
~Randy

