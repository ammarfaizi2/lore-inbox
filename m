Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265488AbTIDTOB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 15:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265491AbTIDTOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 15:14:01 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5138 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265488AbTIDTNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 15:13:55 -0400
Date: Thu, 4 Sep 2003 21:13:53 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ikconfig - resolve rebuild permissions
Message-ID: <20030904191353.GA10448@mars.ravnborg.org>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20030904113133.3f950a51.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904113133.3f950a51.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 11:31:33AM -0700, Stephen Hemminger wrote:
> This patch fixes it by removing the configs.o file when
> needed.

A better approach would be to remove the need for compile.h from
configs.c. See attached patch for the makefile change.
It just took the relevant part from mk_compile and
used it in the Makefile.
Example only - I expect Randy to integrate it properly.

But what you see is also a more fundamental problem.
Should we allow the kernel to be build by two distinct users - 
in this case a normal user and root.

We could check for this early, and stop. But it would require
too many changes in the top-level Makefile for my taste.

	Sam

===== kernel/Makefile 1.33 vs edited =====
--- 1.33/kernel/Makefile	Mon Sep  1 01:13:58 2003
+++ edited/kernel/Makefile	Thu Sep  4 21:05:29 2003
@@ -19,6 +19,7 @@
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
 obj-$(CONFIG_COMPAT) += compat.o
 obj-$(CONFIG_IKCONFIG) += configs.o
+CFLAGS_configs.o = -DLINUX_COMPILER="$(shell $(CC) -v 2>&1 | tail -n 1)"
 
 ifneq ($(CONFIG_IA64),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
