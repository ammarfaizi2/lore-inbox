Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbVAEJ1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbVAEJ1b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVAEJ1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:27:31 -0500
Received: from verein.lst.de ([213.95.11.210]:48326 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262312AbVAEJ1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:27:19 -0500
Date: Wed, 5 Jan 2005 10:26:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jim Nelson <james4765@cwazy.co.uk>
Cc: Brian Gerst <bgerst@didntduck.org>, linuxppc-dev@ozlabs.org,
       paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] ppc: remove cli()/sti() from arch/ppc/*
Message-ID: <20050105092659.GA27103@lst.de>
References: <20050104214048.21749.85722.89116@localhost.localdomain> <41DB4E99.3060200@didntduck.org> <41DB5476.9040103@cwazy.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DB5476.9040103@cwazy.co.uk>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2005 at 09:44:06PM -0500, Jim Nelson wrote:
> Brian Gerst wrote:
> 
> >James Nelson wrote:
> >
> >>This series of patches is to remove the last cli()/sti() function 
> >>calls in arch/ppc.
> >>
> >>These are the only instances in active code that grep could find.
> >
> >
> >Are you sure none of these need real spinlocks instead of just 
> >disabling interrupts?
> >
> >-- 
> >                Brian Gerst
> >
> These are for single-processor systems, mostly evaluation boards and 
> embedded processors.  I coudn't find any reference to multiprocessor 
> setups for the processors in question after a peruse of the code or a 
> quick google on the boards in question.

think CONFIG_PREEMPT.  In either case a spinlock becomes
lock_irq_disable in the !SMP, !PREEMPT case but it documents the
intention a whole lot better.

Also you're locking only in a single plpace which is a ***BIG*** warning
sign.  At least look at the other users of the data structure, it's
extremly likely they'll need locking aswell.

