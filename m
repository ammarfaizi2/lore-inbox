Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUDRQu6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 12:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbUDRQu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 12:50:58 -0400
Received: from ns.suse.de ([195.135.220.2]:43723 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262142AbUDRQu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 12:50:57 -0400
Date: Sun, 18 Apr 2004 18:50:55 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [PATCH] ppc64: Fix CPU hot unplug deadlock]
Message-ID: <20040418165055.GC28807@suse.de>
References: <1082266724.2500.327.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1082266724.2500.327.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Apr 18, Benjamin Herrenschmidt wrote:

> My RTAS locking fixes incorrectly added a spinlock around the function
> used to stop a CPU, that function never returns, thus the lock becomes
> stale. The correct fix is to disable interrupts instead (the RTAS params
> beeing per-CPU, this should be safe enough)
> 
> Ben.
> 
> diff -urN linux-2.5/arch/ppc64/kernel/rtas.c ppc64-linux-2.5/arch/ppc64/kernel/rtas.c
> --- linux-2.5/arch/ppc64/kernel/rtas.c	2004-04-17 12:39:03.253986984 +1000
> +++ ppc64-linux-2.5/arch/ppc64/kernel/rtas.c	2004-04-18 15:35:41.871029480 +1000
> @@ -504,9 +504,9 @@
>  void rtas_stop_self(void)
>  {
>  	struct rtas_args *rtas_args = &(get_paca()->xRtas);
> -	unsigned long s;
>  
> -	spin_lock_irqsave(&rtas.lock, s);
> +	local_irq_disable(s);

did that compile ok for you?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
