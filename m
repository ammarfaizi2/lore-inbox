Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbUAPWHh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 17:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUAPWFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 17:05:15 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265709AbUAPVwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 16:52:39 -0500
Date: Fri, 16 Jan 2004 22:51:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Matt Mackall <mpm@selenic.com>, discuss@x86-64.org,
       George Anzinger <george@mvista.com>
Subject: Re: KGDB 2.0.3 with fixes and development in ethernet interface
Message-ID: <20040116215144.GA208@elf.ucw.cz>
References: <200401161759.59098.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401161759.59098.amitkale@emsyssoft.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> KGDB 2.0.3 is available at 
> http://kgdb.sourceforge.net/kgdb-2/linux-2.6.1-kgdb-2.0.3.tar.bz2
> 
> Ethernet interface still doesn't work. It responds to gdb for a couple of 
> packets and then panics. gdb log for ethernet interface is pasted below.
> 
> It panics and enter kgdb_handle_exception recursively and silently. To see the 
> panic on screen make kgdb_handle_exception return immediately if 
> kgdb_connected is non-zero. 
> 
> Panic trace is pasted below. It panics in skb_release_data. Looks like skb 
> handling will have to changed to be have kgdb specific buffers.

This seems to be needed (if I unselect CONFIG_KGDB_THREAD, I get
compile error on x86-64).
								Pavel

--- linux/kernel/kgdbstub.c	2004-01-16 16:56:51.000000000 +0100
+++ linux-cvs/kernel/kgdbstub.c	2004-01-16 20:11:45.000000000 +0100
@@ -1178,7 +1178,9 @@
 #endif
 
 EXPORT_SYMBOL(breakpoint);
+#ifdef CONFIG_KGDB_THREAD
 EXPORT_SYMBOL(kern_schedule);
+#endif
 
 static int __init opt_gdb(char *str)
 {


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
