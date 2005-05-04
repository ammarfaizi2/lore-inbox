Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVEDUMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEDUMa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261399AbVEDUMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:12:30 -0400
Received: from aquila.skane.tbv.se ([193.13.139.7]:22433 "EHLO
	diadema.skane.tbv.se") by vger.kernel.org with ESMTP
	id S261357AbVEDUKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:10:20 -0400
From: "Oskar Liljeblad" <oskar@osk.mine.nu>
Date: Wed, 4 May 2005 22:10:11 +0200
To: Drew Winstel <DWinstel@Miltope.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Bill Davidsen <davidsen@tmr.com>
Subject: Re: clock drift with two Promise Ultra133 TX2 (PDC 20269) cards
Message-ID: <20050504201011.GA817@oskar>
References: <66F9227F7417874C8DB3CEB057727417045155@MILEX0.Miltope.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66F9227F7417874C8DB3CEB057727417045155@MILEX0.Miltope.local>
User-Agent: Mutt/1.5.9i
X-Spam-Score: 0.2 (/)
X-Spam-Report: Spam detection software, running on the system "diadema.skane.tbv.se", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tuesday, May 03, 2005 at 13:45, Drew Winstel wrote:
	> > Thanks, now it loads correctly. Unfortunately the clock drift still
	occurs > > with pata_pdc2027x. I'm guessing here, but can clock drift
	have anything > > to do with IRQs? Also, is it normal to see errors in
	/proc/interrupt? > > I've never noticed any errors before, but that
	could just be a result of me > never actually bothering to look. [...] 
	Content analysis details:   (0.2 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.2 UPPERCASE_25_50        message body is 25-50% uppercase
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, May 03, 2005 at 13:45, Drew Winstel wrote:
> > Thanks, now it loads correctly. Unfortunately the clock drift still occurs
> > with pata_pdc2027x. I'm guessing here, but can clock drift have anything
> > to do with IRQs? Also, is it normal to see errors in /proc/interrupt?
> 
> I've never noticed any errors before, but that could just be a result of me 
> never actually bothering to look.

Are interrupts errors serious? Can anyone tell? The error count was higher
when I had a fifth PCI card in the computer (natsemi ethernet NIC).
Could there be some kind of PCI card conflict? Maybe I should try to
remove a few of them...

[..]
> Let's do some poking into your kernel config.  What do you have set under 
> "Processor type and features"?

CONFIG_X86_PC=y
CONFIG_MK7=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_INTEL_USERCOPY=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_X86_USE_3DNOW=y
CONFIG_HPET_TIMER=y
CONFIG_X86_UP_APIC=y
CONFIG_X86_UP_IOAPIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_TSC=y

In other words, Athlon/Duron/K7 + HPET + Local APIC + IO-Apic
(though I have tried with both XT-PIC and Local APIC, with same
drift).

And no, the clock drift occurs no matter if ntpd is running or not.
It's having a very hard time to syncronize with the remote servers,
because the clock drift is too high. (It also says somewhere in the
NTP documentation that it doesn't handle too high clock drift.)

Regards,

Oskar Liljeblad (oskar@osk.mine.nu)
