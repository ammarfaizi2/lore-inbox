Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269712AbTGULwj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269731AbTGULwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:52:39 -0400
Received: from zeus.kernel.org ([204.152.189.113]:11761 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S269712AbTGULwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:52:30 -0400
Date: Mon, 21 Jul 2003 13:00:54 +0200 (MEST)
From: Javier Achirica <achirica@telefonica.net>
To: Daniel Ritz <daniel.ritz@gmx.ch>
cc: Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-net <linux-net@vger.kernel.org>,
       Jean Tourrilhes <jt@bougret.hpl.hp.com>,
       Mike Kershaw <dragorn@melchior.nerv-un.net>
Subject: Re: [PATCH 2.5] fixes for airo.c
In-Reply-To: <200307180015.16687.daniel.ritz@gmx.ch>
Message-ID: <Pine.SOL.4.30.0307211252190.25549-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel,

Thank you for your patch. Some comments about it:

- I'd rather fix whatever is broken in the current code than going back to
spinlocks, as they increase latency and reduce concurrency. In any case,
please check your code. I've seen a spinlock in the interrupt handler that
may lock the system.
- The fix for the transmit code you mention, is about fixing the returned
value in case of error? If not, please explain it to me as I don't see any
other changes.
- Where did you fix a buffer overflow?

I submitted to Jeff an updated version just before you sent your e-mail.
It incorporates most of your fixes expect for the possible loop-forever.
It's more stable that the one in the current kernel tree.

Javier Achirica

On Fri, 18 Jul 2003, Daniel Ritz wrote:

> in 2.4.20+ airo.c is broken and can even kill keventd. this patch fixes it:
> - sane locking with spinlocks and irqs disabled instead of the buggy locking
>   with semaphores
> - fix transmit code
> - safer unload ordering of disable irq, unregister_netdev, kfree
> - fix possible loop-forever bug
> - fix a buffer overflow
>
> a kernel 2.4 version of the patch is tested by some people with good results.
> against 2.6.0-test1-bk. please apply.
>
>
> rgds
> -daniel

