Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751822AbWEPNPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWEPNPS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWEPNPR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:15:17 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:26504 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751822AbWEPNPQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:15:16 -0400
Date: Tue, 16 May 2006 14:46:37 +0200
From: Pavel Machek <pavel@suse.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jonathan Day <imipak@yahoo.com>, linux-kernel@vger.kernel.org,
       Zvika Gutterman <zvi@safend.com>
Subject: Re: /dev/random on Linux
Message-ID: <20060516124637.GB6654@elf.ucw.cz>
References: <20060515213956.31627.qmail@web31508.mail.mud.yahoo.com> <1147732867.26686.188.camel@localhost.localdomain> <20060516025003.GC18645@rhun.haifa.ibm.com> <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B2E79864-3AC6-4B72-B97B-222FEDA136A1@mac.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>I would dismiss 2.2 for the cases of things like Knoppix because  
> >>CDs introduce significant randomness because each time you boot  
> >>the CD is subtly differently positioned. The OpenWRT case seems  
> >>more credible. The hard disk patching one is basically irrelevant,  
> >>at that point you already own the box and its game over since you  
> >>can just do a virtualization attack or patch the OS to record  
> >>anything you want.
> 
> Any system with a cycle counter has a vast amount of entropy  
> available by the time the system even gets through the BIOS.  Various  
> things like memory timing, power initialization, BIOS tests, etc are  
> all sufficiently variable in terms of CPU clock cycles that the value  
> of the cycle counter at the first bootloader instruction executed has  
> several bits of randomness.  By the time the bootloader has  
> optionally waited for user input and loaded the kernel off the disk,  
> chaotic variability in the disk access for HDDs, CDROMs, etc will  
> make many bits of the cycle counter sufficiently random.  At that  
> point there's a decently random seed, especially once you start  
> getting further-randomized cycle-counter-based disk interrupts.  I  
> believe there was a paper that discussed how air turbulence in a disk  
> drive was sufficient on a several hundered MHz CPU to provide lots of  
> entropy per interrupt from the cycle counter alone.
> 
> This is totally untrue for an embedded flash-based system; but for  
> such a system the only way to get any kind of entropy at all is with  
> a hardware RNG anyways, so I don't really see this as being a problem.
> 
> I was unsure about the purported forward-security-breakage claims  
> because I don't know how to validate those, but I seem to recall  
> (from personal knowledge and the paper) that the kernel does an SHA1  
> hash of the contents of the pool and the current cycle-counter when  
> reading, uses that as input for the next pool state and returns it  
> as /dev/random output.  Since the exact cycle-counter value is never  
> exposed outside the kernel and only a small window of the previous  

Are you sure? For vsyscalls to work, rdtsc has to be available from
userspace, no?
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
