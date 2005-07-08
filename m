Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262856AbVGHVxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbVGHVxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 17:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVGHVvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 17:51:42 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:21407 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262829AbVGHVtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 17:49:17 -0400
X-ORBL: [63.202.173.158]
Date: Fri, 8 Jul 2005 14:49:08 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       christoph@lameter.org
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Message-ID: <20050708214908.GA31225@taniwha.stupidest.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506231828.j5NISlCe020350@hera.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2005 at 11:28:47AM -0700, Linux Kernel Mailing List wrote:

> [PATCH] i386: Selectable Frequency of the Timer Interrupt

[...]

> +choice
> +	prompt "Timer frequency"
> +	default HZ_250

WHAT?

The previous value here i386 is 1000 --- so why is the default 250.

Changing the *default* time interrupt frequency in a stable series is
*really* bad idea if you ask me.


Now that this has hit mainline please consider applying:


--- kernel/Kconfig.hz~	2005-06-24 22:16:35.023986593 -0700
+++ kernel/Kconfig.hz	2005-07-08 14:46:35.428917597 -0700
@@ -4,7 +4,7 @@
 
 choice
 	prompt "Timer frequency"
-	default HZ_250
+	default HZ_1000
 	help
 	 Allows the configuration of the timer frequency. It is customary
 	 to have the timer interrupt run at 1000 HZ but 100 HZ may be more
