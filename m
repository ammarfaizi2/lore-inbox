Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262283AbTFZSa6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 14:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbTFZSa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 14:30:58 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:488 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262283AbTFZSau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 14:30:50 -0400
Date: Thu, 26 Jun 2003 20:44:46 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin Diehl <lists@mdiehl.de>
Cc: Jean Tourrilhes <jt@hpl.hp.com>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Provide refrigerator support for irda
Message-ID: <20030626184446.GB16172@elf.ucw.cz>
References: <20030625184509.GB5028@elf.ucw.cz> <Pine.LNX.4.44.0306252308070.14534-100000@notebook.home.mdiehl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306252308070.14534-100000@notebook.home.mdiehl.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Admittedly I didn't care about swsusp so far. Given the big fat warning on 
> > > top of Documentation/swsusp.txt I would not even try and i personally 
> > > don't see what I would miss without swsusp.
> > 
> > That's okay... Just support your DMA-ing devices are supported.
> 
> No matter whether it would be ISA-DMA or PCI busmastering I guess?

Any DMA is a problem.

> Not sure whether we can claim most irda drivers ready for swsusp then.
> vlsi_ir should be fine and for irda-usb I assume it would be up to the
> hcd - but don't know about the others...

Well, at least SIR should work as it works over normal serial, IIRC.

> > If it is possible to sleep at place "a", and no locks needed for
> > suspend are held at "a", inserting 
> > 
> > 	if (current->flags & PF_FREEZE)
> > 		refrigerator(PF_IOTHREAD);
> > 
> > is the right thing to do.
> 
> Ok, so the proposed patch is doing the right thing and should be applied.
> 
> Pavel, two more questions:
> 
> * For a kernel compiled with CONFIG_SWSUSP=n, may I assume PF_FREEZE would 
>   never be set or at least refrigerator would be noop?

PF_FREEZE is 0 so if() never succeeds.

> * Isn't there a race on SMP (and probably UP with CONFIG_PREEMPT) when 
>   PF_FREEZE gets modified by another cpu right after the test?

Only task itself ever clears its PF_FREEZE. That means there should be
no problem.
									Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
