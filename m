Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbWARAyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbWARAyI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964978AbWARAyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:54:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60831 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964932AbWARAyG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:54:06 -0500
Date: Tue, 17 Jan 2006 16:56:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 6/9] uml: avoid malloc to sleep in atomic sections
Message-Id: <20060117165602.3d29f936.akpm@osdl.org>
In-Reply-To: <20060118001938.14622.47308.stgit@zion.home.lan>
References: <20060117235659.14622.18544.stgit@zion.home.lan>
	<20060118001938.14622.47308.stgit@zion.home.lan>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it> wrote:
>
> +int __cant_sleep(void) {
> +	return in_atomic() || irqs_disabled() || in_interrupt();

aww, man, this is awful.  Code is supposed to know what context it's
running in, not go fishing about in core internals trying to fix up its own
confusion.

> +	/* Is in_interrupt() really needed? */
>  }

Yes, it is.  in_atomic() is a no-op on !PREEMPT and local irq's can be
enabled in soft- or hard- interrupt context, so irqs_disabled() will return
0.
