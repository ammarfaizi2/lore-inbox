Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWG1GJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWG1GJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 02:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWG1GJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 02:09:51 -0400
Received: from www.osadl.org ([213.239.205.134]:47521 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751838AbWG1GJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 02:09:50 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>,
       Christoph Lameter <clameter@sgi.com>
In-Reply-To: <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
References: <1154044607.27297.101.camel@localhost.localdomain>
	 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 08:14:07 +0200
Message-Id: <1154067247.27297.104.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 08:22 +0300, Pekka Enberg wrote:
> Hi Thomas,
> Looks bad.
> 
>   cache_reap
>   reap_alien	(grabs l3->alien[node]->lock)
>   __drain_alien_cache
>   free_block
>   slab_destroy	(slab management off slab)
>   kmem_cache_free
>   __cache_free
>   cache_free_alien (recursive attempt on l3->alien[node] lock)
> 
> Christoph?

If you need more info, I can add debugs. It happens every bootup.

	tglx


