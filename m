Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVLSORX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVLSORX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 09:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbVLSORX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 09:17:23 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:49116 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750810AbVLSORW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 09:17:22 -0500
Subject: Re: [patch 10/15] Generic Mutex Subsystem,
	mutex-migration-helper-core.patch
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       David Howells <dhowells@redhat.com>,
       Alexander Viro <viro@ftp.linux.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <20051219013837.GF28038@elte.hu>
References: <20051219013837.GF28038@elte.hu>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:16:26 -0500
Message-Id: <1135001786.13138.249.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-19 at 02:38 +0100, Ingo Molnar wrote:
> +#ifdef CONFIG_DEBUG_MUTEXESS
> +void fastcall
> +__mutex_debug_sema_init(struct mutex_debug *lock, int val, char
> *name,
> +                       char *file, int line)
> +{
> +       __mutex_init(&lock->lock, name, file, line);
> +
> +       DEBUG_WARN_ON(val != 0 && val != 1);
> +       if (!val)
> +               __mutex_lock(&lock->lock __CALLER_IP__);
> +}
> +#else
> +void fastcall __mutex_debug_sema_init(struct mutex_debug *lock, int
> val)
> +{
> +       __mutex_init(&lock->lock);
> +
> +       DEBUG_WARN_ON(val != 0 && val != 1);

DEBUG_WARN_ON in this part of the #if is always a no-op.

-- Steve

> +       if (!val)
> +               __mutex_lock(&lock->lock __CALLER_IP__);
> +}
> +#endif
> +

