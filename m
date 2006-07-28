Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161260AbWG1UHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbWG1UHX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161261AbWG1UHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 16:07:23 -0400
Received: from www.osadl.org ([213.239.205.134]:58539 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161260AbWG1UHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 16:07:23 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Christoph Lameter <clameter@sgi.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>,
       alokk@calsoftinc.com
In-Reply-To: <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
References: <1154044607.27297.101.camel@localhost.localdomain>
	 <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
	 <1154067247.27297.104.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 22:11:41 +0200
Message-Id: <1154117501.10196.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 08:35 -0700, Christoph Lameter wrote:
> On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> 
> > If you need more info, I can add debugs. It happens every bootup.
> 
> Could you tell me why _spin_lock and _spin_unlock seem 
> to be calling into the slab allocator? Also what is child_rip()? Cannot 
> find that function upstream.

arch/x86_64/kernel/entry.S

child_rip:
        /*
         * Here we are in the child and the registers are set as they were
         * at kernel_thread() invocation in the parent.
         */
        movq %rdi, %rax
        movq %rsi, %rdi
        call *%rax
        # exit
        xorl %edi, %edi
        call do_exit
ENDPROC(child_rip)

	tglx


