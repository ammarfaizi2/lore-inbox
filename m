Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVLVBxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVLVBxP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 20:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVLVBxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 20:53:15 -0500
Received: from allen.werkleitz.de ([80.190.251.108]:4017 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S965027AbVLVBxO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 20:53:14 -0500
Date: Thu, 22 Dec 2005 02:53:49 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjanv@infradead.org>,
       Jes Sorensen <jes@trained-monkey.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Oleg Nesterov <oleg@tv-sign.ru>, David Howells <dhowells@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Benjamin LaHaise <bcrl@kvack.org>,
       Steven Rostedt <rostedt@goodmis.org>,
       Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>, Nicolas Pitre <nico@cam.org>
Message-ID: <20051222015349.GA8043@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
	Arjan van de Ven <arjanv@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Oleg Nesterov <oleg@tv-sign.ru>,
	David Howells <dhowells@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Christoph Hellwig <hch@infradead.org>, Andi Kleen <ak@suse.de>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Nicolas Pitre <nico@cam.org>
References: <20051221223656.GB4960@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221223656.GB4960@elte.hu>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: 84.189.240.121
Subject: Re: [patch 1/8] mutex subsystem, XFS namespace collision fixes
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 11:36:56PM +0100, Ingo Molnar wrote:
> Fixup the XFS code to avoid name clashing with the mutex code by 
> introducing xfs_mutex_ functions.
...
> --- linux.orig/fs/xfs/linux-2.6/mutex.h
> +++ linux/fs/xfs/linux-2.6/mutex.h
> @@ -30,10 +30,10 @@
>  #define MUTEX_DEFAULT		0x0
>  typedef struct semaphore	mutex_t;
>  
> -#define mutex_init(lock, type, name)		sema_init(lock, 1)
> -#define mutex_destroy(lock)			sema_init(lock, -99)
> -#define mutex_lock(lock, num)			down(lock)
> -#define mutex_trylock(lock)			(down_trylock(lock) ? 0 : 1)
> -#define mutex_unlock(lock)			up(lock)
> +#define xfs_mutex_init(lock, type, name)	arch_sema_init(lock, 1)
> +#define xfs_mutex_destroy(lock)			arch_sema_init(lock, -99)
> +#define xfs_mutex_lock(lock, num)		arch_down(lock)
> +#define xfs_mutex_trylock(lock)			(arch_down_trylock(lock) ? 0 : 1)
> +#define xfs_mutex_unlock(lock)			arch_up(lock)

This arch_ prefix seems to be a leftover from the migration helper patches?

Johannes
