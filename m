Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263253AbVCKKJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbVCKKJA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 05:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263244AbVCKKJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 05:09:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:22987 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263253AbVCKKIe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 05:08:34 -0500
Date: Fri, 11 Mar 2005 02:07:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: arjan@infradead.org, pbadari@us.ibm.com, dhowells@redhat.com,
       torvalds@osdl.org, suparna@in.ibm.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rwsem: Make rwsems use interrupt disabling spinlocks
Message-Id: <20050311020717.46794d94.akpm@osdl.org>
In-Reply-To: <20050311094024.GC19954@elte.hu>
References: <20050309032832.159e58a4.akpm@osdl.org>
	<20050308170107.231a145c.akpm@osdl.org>
	<1110327267.24286.139.camel@dyn318077bld.beaverton.ibm.com>
	<18744.1110364438@redhat.com>
	<20050309110404.GA4088@in.ibm.com>
	<1110366469.6280.84.camel@laptopd505.fenrus.org>
	<4175.1110370343@redhat.com>
	<1110395783.24286.207.camel@dyn318077bld.beaverton.ibm.com>
	<20050309114234.6598f486.akpm@osdl.org>
	<1110399036.6280.151.camel@laptopd505.fenrus.org>
	<20050311094024.GC19954@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> 
> * Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > > Ingo, we already have a touch_nmi_watchdog() in the sysrq code.  It might be
> > > worth adding a touch_softlockup_watchdog() wherever we have a
> > > touch_nmi_watchdog().
> > 
> > ....or add touch_softlockup_watchdog to touch_nmi_watchdog() instead
> > and rename it tickle_watchdog() overtime.
> 
> you mean like:
> 
> +extern void touch_softlockup_watchdog(void);
> 
> in:
> 
>  http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm2/broken-out/detect-soft-lockups.patch
> 
> ?
> 

Nope.

This particular lockup happened because a huge stream of stuff was sent to
the serial console.

We already have a touch_nmi_watchdog() in that code.

We should arrange for touch_softlockup_watchdog() to be called whenever
touch_nmi_watchdog() is called.

