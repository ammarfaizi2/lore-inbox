Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbTLZTDA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Dec 2003 14:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbTLZTDA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Dec 2003 14:03:00 -0500
Received: from gprs214-253.eurotel.cz ([160.218.214.253]:128 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265209AbTLZTC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Dec 2003 14:02:58 -0500
Date: Fri, 26 Dec 2003 19:27:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kgdb without serial port
Message-ID: <20031226182740.GA10397@elf.ucw.cz>
References: <20031215200640.GA3724@elf.ucw.cz> <20031215223438.196295a8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215223438.196295a8.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2.6 kgdb patches in -mm tree seem to contain kgdb-over-ethernet stuff,
> > but still require me to fill in serial port interrupt/address. Is
> > there easy way to make it work without serial port? [This notebook has
> > none :-(].
> 
> That's a bit ugly, but things should still work OK?  Give it some random
> UART address but specify an ethernet connection at boot time - the kgdb
> stub should never touch the UART.

I found out what was biting me: using 2.95 with kgdb is bad idea. 2.95
with kgdb means reboot just after uncompressing kernel -- pretty nasty
to debug. Please apply,
									Pavel
PS: kgdb could use some code-style changes. Will you accept such
patches?

--- tmp/linux/arch/i386/kernel/kgdb_stub.c	2003-12-26 18:50:45.000000000 +0100
+++ linux/arch/i386/kernel/kgdb_stub.c	2003-12-26 18:41:58.000000000 +0100
@@ -121,6 +121,10 @@
 #include <linux/inet.h>
 #include <linux/kallsyms.h>
 
+#if __GNUC__ < 3
+#error Sorry, your GCC is too old to work with kgdb. (It works with 3.3.2)
+#endif
+
 /************************************************************************
  *
  * external low-level support routines

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
