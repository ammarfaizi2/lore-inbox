Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267267AbTBXQRl>; Mon, 24 Feb 2003 11:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267270AbTBXQRk>; Mon, 24 Feb 2003 11:17:40 -0500
Received: from d146.dhcp212-198-27.noos.fr ([212.198.27.146]:7646 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP
	id <S267267AbTBXQRf>; Mon, 24 Feb 2003 11:17:35 -0500
Date: Mon, 24 Feb 2003 17:27:34 +0100
From: Stelian Pop <stelian@popies.net>
To: Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: modutils: FATAL: Error running install...
Message-ID: <20030224172734.C29439@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20030224171627.B29439@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030224171627.B29439@deep-space-9.dsnet>; from stelian@popies.net on Mon, Feb 24, 2003 at 05:16:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 05:16:27PM +0100, Stelian Pop wrote:

> With the latest 2.5-bk (and module-init-tools), my logs
> are polluted with lines like:
> 	FATAL: Error running install command for block_major_2

And replying to my own message after reading the latest posts
on lkml, I confirm that Mikael Pettersson's patch works for me.

I rediffed it below against the latest bk.

Linus,  please apply.

Stelian.

===== kernel/kmod.c 1.24 vs edited =====
--- 1.24/kernel/kmod.c	Mon Feb 24 04:18:09 2003
+++ edited/kernel/kmod.c	Mon Feb 24 17:19:39 2003
@@ -154,6 +154,7 @@
 
 	/* Unblock all signals. */
 	flush_signals(current);
+	current->sighand->action[SIGCHLD-1].sa.sa_handler = SIG_DFL;
 	spin_lock_irq(&current->sighand->siglock);
 	flush_signal_handlers(current);
 	sigemptyset(&current->blocked);

-- 
Stelian Pop <stelian@popies.net>
