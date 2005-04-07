Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVDGKWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVDGKWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 06:22:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVDGKWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 06:22:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:55984 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262418AbVDGKWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 06:22:30 -0400
Date: Thu, 7 Apr 2005 03:22:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2 in_atomic() picks up preempt_disable()
Message-Id: <20050407032220.4a62b45f.akpm@osdl.org>
In-Reply-To: <13730.1112868613@kao2.melbourne.sgi.com>
References: <13730.1112868613@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
> 2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The
> in_atomic() macro thinks that preempt_disable() indicates an atomic
> region so calls to __might_sleep() result in a stack trace.
> preempt_count() returns 1, no soft or hard irqs are running and no
> spinlocks are held.  It looks like there is no way to distinguish
> between the use of preempt_disable() in the lock functions (atomic) and
> preempt_disable() outside the lock functions (do nothing that might
> migrate me).

Is this new behaviour?

It sounds correct to me:

	preempt_disable();
	do_something_which_might_sleep();
	preempt_enable();

Is buggy?
