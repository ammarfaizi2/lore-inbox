Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVALXLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVALXLa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 18:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVALXJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 18:09:18 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:14560 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261555AbVALXCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 18:02:41 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: 2.6.10-mm2: swsusp regression [update]
Date: Thu, 13 Jan 2005 00:02:36 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ncunningham@linuxmail.org
References: <20050106002240.00ac4611.akpm@osdl.org> <200501122344.20589.rjw@sisk.pl> <20050112224641.GP1408@elf.ucw.cz>
In-Reply-To: <20050112224641.GP1408@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501130002.37311.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 12 of January 2005 23:46, Pavel Machek wrote:
> Hi!
> 
> > > > (for example - the second number is always negative and huge).  Would 
it 
> > mean 
> > > > that get_cmos_time() needs fixing?
> > > 
> > > get_cmos_time() looks okay, but timer){suspend,resume} looks
> > > hopelessly broken.
> > 
> > Well, why don't we convert them to noops, then, at least temporarily?
> 
> Actually, it was my analysis that was wrong. Did you try Nigel's trick
> with updating wall_jiffies?

Do you mean to add

wall_jiffies +=  (ctime - sleep_start) * HZ;

or an equivalent at the end of timer_resume()?  I did and it helped a little.  
With it, the box hangs while executing device_resume() in swsusp_write().  
Without it, the box hangs earlier.

Still, it's sleep_start that has a wrong value, apparently (it shouldn't be 
negative, at least), and I see that Nigel has a patch that changes 
__get_cmos_time() on x86_64.  I'm going to try it in a couple of minutes.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
