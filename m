Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262858AbUJ1Jm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262858AbUJ1Jm7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 05:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262851AbUJ1JiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 05:38:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51416 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262862AbUJ1JgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 05:36:04 -0400
Date: Thu, 28 Oct 2004 11:00:10 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, ncunningham@linuxmail.org,
       Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fixing MTRR smp breakage and suspending sysdevs.
Message-ID: <20041028090009.GA7609@openzaurus.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB600333AEF9@scsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB600333AEF9@scsmsx403.amr.corp.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >What about this one, instead?
> >
> >* ACPI Link device should allocate with GFP_ATOMIC
> >
> >* during suspend, locks can't be taken. (We stop userland, etc). So it
> >should be okay to down_trylock() and panic if that does not work.
> 
> 
> Actually, I am trying another approach for Link Device.
> 
> - Temporarily enable interrupts during Link Device resume. Turn off all
> the external interrupts at suspend time. They will remain suspended
> until interrupt device resumes.

Hmm, perhaps you should turn off external interrupts during resume
time...

But none of this is going to help. You want interrupts so that you can
allocate with GFP_KERNEL, right? But disk is stopped at this point, if
vm system attempts to swap, you are deadlocked, anyway.

				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

