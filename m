Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263181AbTC1WjP>; Fri, 28 Mar 2003 17:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263185AbTC1WjP>; Fri, 28 Mar 2003 17:39:15 -0500
Received: from sponsa.its.UU.SE ([130.238.7.36]:1740 "EHLO sponsa.its.uu.se")
	by vger.kernel.org with ESMTP id <S263181AbTC1WjJ>;
	Fri, 28 Mar 2003 17:39:09 -0500
Date: Fri, 28 Mar 2003 23:50:01 +0100 (MET)
Message-Id: <200303282250.h2SMo1V7019959@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org, rbultje@ronald.bitfreak.net
Subject: Re: some 2.5.66 issues
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Mar 2003 00:24:14 +0100, Ronald Bultje wrote:
>people are asking for comments on 2.5.x, so here goes. gcc-2.96, RH-7.3,
>kernel 2.5.66 with module-init-tools-0.9.10.
...
>* module_request() is still broken - it returns 0 but the specified
>module isn't loaded

To summarise: RH user-space, 2.5 kernel, modules don't autoload.

This is a well-known user-space (*) bug. Fix below.

(*) Well, unless "dropping /proc/ksyms for no good reason" counts
as a 2.5 kernel bug.

--- /etc/rc.d/rc.sysinit.~1~	2002-08-22 23:10:52.000000000 +0200
+++ /etc/rc.d/rc.sysinit	2003-01-14 03:04:57.000000000 +0100
@@ -334,7 +334,7 @@
     IN_INITLOG=
 fi
 
-if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
+if ! grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
     USEMODULES=y
 fi
 
