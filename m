Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161275AbWG1UXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161275AbWG1UXi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161279AbWG1UXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:23:38 -0400
Received: from www.osadl.org ([213.239.205.134]:10156 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161275AbWG1UXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:23:37 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       alokk@calsoftinc.com
In-Reply-To: <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
References: <1154044607.27297.101.camel@localhost.localdomain>
	 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
	 <1154067247.27297.104.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
	 <1154117501.10196.2.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 22:27:55 +0200
Message-Id: <1154118476.10196.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 13:18 -0700, Christoph Lameter wrote:
> On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> 
> > On Fri, 2006-07-28 at 08:35 -0700, Christoph Lameter wrote:
> > > On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> > > 
> > > > If you need more info, I can add debugs. It happens every bootup.
> > > 
> > > Could you tell me why _spin_lock and _spin_unlock seem 
> > > to be calling into the slab allocator? Also what is child_rip()? Cannot 
> > > find that function upstream.
> > 
> > arch/x86_64/kernel/entry.S
> 
> Ah. Ok wrong arch. Why does _spin_unlock_irq call child_rip and then end 
> up in the slab allocator?
> 
> Why does _spin_lock call kmem_cache_free?
> 
> Is the stack trace an accurate representation of the calling sequence?

Probably not. Thats a call tail optimization artifact. I retest with
UNWIND info =y 

	tglx


