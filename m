Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269104AbUJTTMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269104AbUJTTMz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 15:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUJTTMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 15:12:37 -0400
Received: from gprs214-236.eurotel.cz ([160.218.214.236]:55683 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269187AbUJTTLB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 15:11:01 -0400
Date: Wed, 20 Oct 2004 21:10:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <20041020191044.GB21315@elf.ucw.cz>
References: <41763777.27136.1B3B687B@localhost> <41764FB3.29782.1B9A13F4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41764FB3.29782.1B9A13F4@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > >         pushl   $0                                              # Kill any dangerous flags
> > > >         popfl
> > > > 
> > > >         movl    real_magic - wakeup_code, %eax
> > > >         cmpl    $0x12345678, %eax
> > > >         jne     bogus_real_magic
> > > > 
> > > >         testl   $1, video_flags - wakeup_code
> > > >         jz      1f
> > > >         lcall   $0xc000,$3
> > > 
> > > The call to 0xC000:0x0003 is the entry point to POST the card. However 
> > > for PCI cards you need to make sure that AX is loaded with the bus, slot 
> > > and function for the card that is being POST'ed. It will pass this value 
> > > to the PCI BIOS Int 0x1A functions in order to find itself, so if this is 
> > > not set many BIOS'es will not work.
> > 
> > Ok, this one is bad... ... In case of just one vga adapter, we
> > should be able to store its parameters in some well-known place.
> > For more than one adapter, we'll definitely need to run BIOS in
> > emulator. 
> 
> Yes. If you are running this in real mode you don't have any option but 
> to use the BIOS emulator. If you are running in protected mode and using 
> vm86() style service, the 0xC0000 memory is just memory and can be re-
> written. For instance on Linux you can map 0xC0000 into your process 
> address space as copy on write, which then allows you to re-write the 
> BIOS image for a secondary controller and then restore it when you are 
> done.

One more question: Does 0xc0000 POST method work even on notebooks? On
regular machines, PCI card must have normal bios and stuff is easy. On
notebooks there was talk about "integrated bios" where it really has
no video bios at all and system bios POSTs the card. Have you seen
that?
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
