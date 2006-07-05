Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbWGEJyD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWGEJyD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 05:54:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWGEJyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 05:54:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5536 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964782AbWGEJyB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 05:54:01 -0400
Date: Wed, 5 Jul 2006 02:53:49 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch] uninline init_waitqueue_*() functions
Message-Id: <20060705025349.eb88b237.akpm@osdl.org>
In-Reply-To: <20060705093259.GA11237@elte.hu>
References: <20060705084914.GA8798@elte.hu>
	<20060705023120.2b70add6.akpm@osdl.org>
	<20060705093259.GA11237@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2006 11:32:59 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > shrinks fs/select.o by eight bytes.  (More than I expected).  So it 
> > does appear to be a space win, but a pretty slim one.
> 
> there are 855 calls to these functions in the allyesconfig vmlinux i 
> did, and i measured a combined size reduction of 34791 bytes. That 
> averages to a 40 bytes win per call site. (on i386.)
> 

Yes, but that lumps all three together.  init_waitqueue_head() is obviously
the porky one.  And it's porkier with CONFIG_DEBUG_SPINLOCK and
CONFIG_LOCKDEP, which isn't the case to optimise for.

With the debug options turned off, even init_waitqueue_head() becomes just
three assignments, similar to init_waitqueue_entry() and
init_waitqueue_func_entry().  All pretty marginal.

