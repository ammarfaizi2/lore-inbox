Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVALWuD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVALWuD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbVALWsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:48:21 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:37343 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261522AbVALWoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:44:16 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Date: Wed, 12 Jan 2005 23:44:20 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
References: <20050106002240.00ac4611.akpm@osdl.org> <200501121951.48102.rjw@sisk.pl> <20050112210147.GJ1408@elf.ucw.cz>
In-Reply-To: <20050112210147.GJ1408@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501122344.20589.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 12 of January 2005 22:01, Pavel Machek wrote:
> Hi!
> 
> > [-- snip --]
> > > > > > The regression is caused by the timer driver.  Obviously, turning 
> > > > > > timer_resume() in arch/x86_64/kernel/time.c into a NOOP makes it 
go
> > > > > > away. 
> > [-- snip --]
> > > > > 
> > > > > ..you might want to look at i386 time code, they have common
> > > > > ancestor, and i386 one seems to work.
> > 
> > Well, I've changed timer_resume() in arch/x86_64/kernel/time.c into the 
> > following function:
> 
> Ugh, looking at arch/i386/kernel/time.c... "This could have never
> worked".
> 
> It does something like get_cmos_time() - get_cmos_time()*HZ. It looks
> seriously wrong.
> 
> > (for example - the second number is always negative and huge).  Would it 
mean 
> > that get_cmos_time() needs fixing?
> 
> get_cmos_time() looks okay, but timer){suspend,resume} looks
> hopelessly broken.

Well, why don't we convert them to noops, then, at least temporarily?

RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
