Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932465AbVLAUyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVLAUyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 15:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbVLAUyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 15:54:35 -0500
Received: from mail.suse.de ([195.135.220.2]:28072 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751724AbVLAUyf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 15:54:35 -0500
To: "David S. Miller" <davem@davemloft.net>
Cc: lkml@rtr.ca, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       davej@redhat.com
Subject: Re: [PATCH] Fix bytecount result from printk()
References: <438F1D05.5020004@rtr.ca> <20051201175732.GD19433@redhat.com>
	<20051201.121554.130875743.davem@davemloft.net>
From: Andi Kleen <ak@suse.de>
Date: 01 Dec 2005 18:23:15 -0700
In-Reply-To: <20051201.121554.130875743.davem@davemloft.net>
Message-ID: <p737jaofg1o.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@davemloft.net> writes:

> From: Dave Jones <davej@redhat.com>
> Date: Thu, 1 Dec 2005 12:57:32 -0500
> 
> > On Thu, Dec 01, 2005 at 10:55:49AM -0500, Mark Lord wrote:
> >  > printk() returns a bytecount, which nothing actually appears to use.
> > 
> > We do check it in a few places.
> > 
> > arch/x86_64/kernel/traps.c:                             i += printk(" "); \
> > arch/x86_64/kernel/traps.c:                     i += printk(" <%s> ", id);
> > arch/x86_64/kernel/traps.c:                     i += printk(" <EOE> ");
> > arch/x86_64/kernel/traps.c:                             i += printk(" <IRQ> ");
> > arch/x86_64/kernel/traps.c:                             i += printk(" <EOI> ");
> > drivers/char/mem.c:             ret = printk("%s", tmp);
> 
> Wow, that's amazing. :)

Taking the blame.

> I bet these can easily be removed, and since printk() is such
> a core thing, simplifying it should trump whatever benfits
> these few call sites have from getting a return byte count.

I used it for linewrapping in the oops output.

Actually I would expect more users from sprintf and snprintf
(e.g. common in /proc output to compute the return value of the read) 
and that is exactly the same code path.

If you do the same grep for sn?printf I bet there will be much more hits.

-Andi
