Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbTFZNNK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTFZNNK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:13:10 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:11791 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261773AbTFZNNF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:13:05 -0400
Date: Thu, 26 Jun 2003 15:27:34 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Pavel Machek <pavel@suse.cz>
cc: Jean Tourrilhes <jt@hpl.hp.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Provide refrigerator support for irda
In-Reply-To: <20030625184509.GB5028@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0306252308070.14534-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jun 2003, Pavel Machek wrote:

> > Admittedly I didn't care about swsusp so far. Given the big fat warning on 
> > top of Documentation/swsusp.txt I would not even try and i personally 
> > don't see what I would miss without swsusp.
> 
> That's okay... Just support your DMA-ing devices are supported.

No matter whether it would be ISA-DMA or PCI busmastering I guess?

Not sure whether we can claim most irda drivers ready for swsusp then.
vlsi_ir should be fine and for irda-usb I assume it would be up to the
hcd - but don't know about the others...

> > For the meantime, I think we should apply this if somebody would explain 
> > what's going on here.
> 
> We need kernel thread to sleep at defined place. Process running
> userspace can be stopped any time, but processes running in kernel can
> be only stopped at defined places, to avoid unexpected surprises.

Ok, thanks for explaining!

> If it is possible to sleep at place "a", and no locks needed for
> suspend are held at "a", inserting 
> 
> 	if (current->flags & PF_FREEZE)
> 		refrigerator(PF_IOTHREAD);
> 
> is the right thing to do.

Ok, so the proposed patch is doing the right thing and should be applied.

Pavel, two more questions:

* For a kernel compiled with CONFIG_SWSUSP=n, may I assume PF_FREEZE would 
  never be set or at least refrigerator would be noop?

* Isn't there a race on SMP (and probably UP with CONFIG_PREEMPT) when 
  PF_FREEZE gets modified by another cpu right after the test?

Thanks
Martin

