Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUG1V7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUG1V7b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUG1V6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:58:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:29411 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265119AbUG1V5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:57:40 -0400
Date: Wed, 28 Jul 2004 15:00:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       Sylvain Munaut <tnt@246tNt.com>
Subject: Re: [PATCH][PPC32] Makefile cleanups and gcc-3.4+binutils-2.14
 check
Message-Id: <20040728150052.4effe78a.akpm@osdl.org>
In-Reply-To: <20040728154630.GN10891@smtp.west.cox.net>
References: <20040728154630.GN10891@smtp.west.cox.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini <trini@kernel.crashing.org> wrote:
>
> The following patch does three things.  First, it removes all instances
> of:
> ifeq ($(CONFIG_FOO),y)
> AFLAGS += -Wa,-mfoo
> endif
> 
> and makes us set them once in arch/ppc/Makefile, via
> aflags-$(CONFIG_FOO), just like we do for CFLAGS.  Next it adds a test
> for gcc-3.4 and binutils-2.14.  The problem with this combination is
> that the -many flag is broken in binutils-2.14 and gcc-3.4 will pass it
> down, causing other flags to be overridden and the compile to fail.
> Changing gcc or binutils versions fixes this.  Finally, it changes
> places in the Makefiles where we did:
> ifeq ($(CONFIG_FOO),y)
> obj-$(CONFIG_BAR) += foo_bar.o
> endif
> into
> obj-$(CONFIG_FOO) += $(bar-y)
> bar-$(CONFIG_BAR) += foo_bar.o

Unfortunately this has significant clashes with the mpc52xx bk tree
which I'm carrying.

That patch has been sitting around for several weeks now - can we get it
merged up first?

