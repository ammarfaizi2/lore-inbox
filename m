Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750755AbWA2JLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWA2JLa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 04:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWA2JLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 04:11:30 -0500
Received: from ozlabs.org ([203.10.76.45]:32897 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750755AbWA2JLa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 04:11:30 -0500
Date: Sat, 28 Jan 2006 12:19:48 +1100
From: Anton Blanchard <anton@samba.org>
To: Mark Haverkamp <markh@osdl.org>
Cc: "linuxppc64-dev@ozlabs.org" <linuxppc64-dev@ozlabs.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: iommu_alloc failure and panic
Message-ID: <20060128011948.GB17018@krispykreme>
References: <1138381060.11796.22.camel@markh3.pdx.osdl.net> <20060127234853.GA17018@krispykreme> <1138406447.11796.32.camel@markh3.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138406447.11796.32.camel@markh3.pdx.osdl.net>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> It looks like they are already on:
> 
> CONFIG_DEBUG_STACKOVERFLOW=y
> CONFIG_DEBUG_STACK_USAGE=y

You could try bumping the limit for the warning in
arch/powerpc/kernel/irq.c

	if (unlikely(sp < (sizeof(struct thread_info) + 2048)))

Change it to 4096.

Unfortunately if the long call chain is in an interrupt disabled area
you will not get warned.

> The machine is frozen after the panic. 

You can do it sometime before the hang to see if you are getting close
to overflowing the stack.

Anton
