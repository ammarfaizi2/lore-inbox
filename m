Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269008AbUJQCu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269008AbUJQCu7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 22:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269010AbUJQCu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 22:50:59 -0400
Received: from ozlabs.org ([203.10.76.45]:6849 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269008AbUJQCu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 22:50:57 -0400
Subject: Re: s390(64) per_cpu in modules (ipv6)
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pete Zaitcev <zaitcev@redhat.com>
In-Reply-To: <OFC25D1557.60BFB654-ON42256F2E.00327ABF-42256F2E.0032D239@de.ibm.com>
References: <OFC25D1557.60BFB654-ON42256F2E.00327ABF-42256F2E.0032D239@de.ibm.com>
Content-Type: text/plain
Message-Id: <1097981469.29286.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 17 Oct 2004 12:51:09 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 19:15, Martin Schwidefsky wrote:
> 
> 
> Rusty Russell <rusty@rustcorp.com.au> wrote on 15/10/2004 03:41:40 AM:

> > The worse problem is that a (static) per-cpu var declared *inside* a
> > function gets renamed by gcc; IIRC some generic code used to do this.
> 
> __thread in the kernel would be a real innovation, but I fear it isn't easy.
> The problem with the per_cpu__x variables in modules is solved for s390x
> by the way.

Sure, but it doesn't solve this case, AFAICT:

void func(void)
{
	static DEFINE_PER_CPU(x, int);

	__get_per_cpu(x)++;
}

The compiler will create a variable called "per_cpu__x.0" and your asm
reference to "per_cpu__x" will cause a link failure, no?  Obviously, you
would have noticed this, so I'm wondering what I'm missing.

I hit this in mm/page-writeback.c:balance_dirty_pages_ratelimited().

Confused,
Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

