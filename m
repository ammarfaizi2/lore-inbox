Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWEaRR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWEaRR2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 13:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWEaRR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 13:17:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9095 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751163AbWEaRR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 13:17:27 -0400
Date: Wed, 31 May 2006 10:21:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: pauldrynoff@gmail.com, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.17-rc5-mm1 - output of lock validator
Message-Id: <20060531102128.eb0020ad.akpm@osdl.org>
In-Reply-To: <1149085739.3114.34.camel@laptopd505.fenrus.org>
References: <20060530195417.e870b305.pauldrynoff@gmail.com>
	<20060530132540.a2c98244.akpm@osdl.org>
	<20060531181926.51c4f4c5.pauldrynoff@gmail.com>
	<1149085739.3114.34.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006 16:28:59 +0200
Arjan van de Ven <arjan@linux.intel.com> wrote:

> --- linux-2.6.17-rc5-mm1.5.orig/drivers/net/8390.c
> +++ linux-2.6.17-rc5-mm1.5/drivers/net/8390.c
> @@ -299,7 +299,7 @@ static int ei_start_xmit(struct sk_buff 
>  	 
>  	disable_irq_nosync(dev->irq);
>  	
> -	spin_lock(&ei_local->page_lock);
> +	spin_lock_irqsave(&ei_local->page_lock, flags);

Again, notabug - we did disable_irq().

I think lockdep needs to be taught about this idiom.  Perhaps add a new
disable_irq_tell_lockdep() which assumes that we're in an
equivalent-to-local_irq_disable() state.

