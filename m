Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030868AbWKOSyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030868AbWKOSyW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030870AbWKOSyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:54:22 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:14816 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030868AbWKOSyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:54:21 -0500
Date: Wed, 15 Nov 2006 19:53:31 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Mikael Pettersson <mikpe@it.uu.se>, 7eggert@gmx.de, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] floppy: suspend/resume fix
Message-ID: <20061115185331.GA6878@elte.hu>
References: <200611122240.kACMeS7l005120@harpo.it.uu.se> <20061112235806.GC31624@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061112235806.GC31624@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -4.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-4.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_20 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.0 BAYES_20               BODY: Bayesian spam probability is 5 to 20%
	[score: 0.1926]
	1.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Sun, Nov 12, 2006 at 11:40:28PM +0100, Mikael Pettersson wrote:
> > The bug occurs regardless of whether I leave the floppy disc in the drive
> > during suspend or not. 2.6.19-rc5 (vanilla and with Ingo's suspend/resume
> > hooks) fails the following use case as well:
> > 
> > 1. boot
> > 2. insert floppy disc
> > 3. tar tvf /dev/fd0 (works)
> > 4. manually eject floppy disc
> > 5. suspend, later resume 
> > 6. insert floppy disc
> > 7. tar tvf /dev/fd0 (fails with I/O errors)
> > 8. tar tvf /dev/fd0 (works)
> > 
> > Like Ingo said, something happens to the HW during suspend and we
> > need to figure out how to reinitialise the HW and the driver so that
> > things work immediately after resume.
> 
> Now this is interesting - I know there's been a long standing bug with 
> kernels on my Thinkpad which behave in a similar way to your 
> description above.  Basically whenever I change the disk in the drive 
> I tend to need _two_ goes to do anything with it - the first mostly 
> always fails with IO errors.

yeah. But somehow the pre-lockdep-change driver gets this right - purely 
by virtue of unregistering the IRQ line and the DMA channel - neither of 
which should have any material effect on behavior ... [and when i 
restored this in suspend/resume it didnt fix the bug] Weird.

	Ingo
