Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319068AbSIJHlz>; Tue, 10 Sep 2002 03:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319069AbSIJHlz>; Tue, 10 Sep 2002 03:41:55 -0400
Received: from users.linvision.com ([62.58.92.114]:24726 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S319068AbSIJHlx>; Tue, 10 Sep 2002 03:41:53 -0400
Date: Tue, 10 Sep 2002 09:46:16 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ingo Molnar <mingo@elte.hu>, Zwane Mwaikambo <zwane@mwaikambo.name>,
       Robert Love <rml@tech9.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] per isr in_progress markers
Message-ID: <20020910094616.B21776@bitwizard.nl>
References: <Pine.LNX.4.44.0209092041300.30411-100000@localhost.localdomain> <Pine.LNX.4.33.0209091151200.14841-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0209091151200.14841-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 11:53:40AM -0700, Linus Torvalds wrote:
> 
> (Btw, if there is, that would also allow us to notice the "constantly
> screaming PCI interrupt" without help from the low-level isrs)

OH! That'd be nice: instead of a lockup if a PCI device's interrupt
isn't serviced, you get a nice message and a machine that might
still work!

On the other hand, you have a possibility for disaster if the 
threshold isn't set right. 

I have written serial drivers where the card will limit the interrupt
rate to max 100 per second. I then build in a detection: if my IRQ 
handler gets called more than 10 times in a jiffy, we're in trouble.

Turns out that I left this in "in the field" and some people put the
serial card on the same interrupt line as a SCSI controller. The
scsi controller can generate more than 1000 interrupts per second ->
my driver shuts down.... 

Something similar may happen if say you net-spray a sligtly 
under-powered machine with a Gigabit ethernet card: The GBE card may
indeed have a new packet ready by the time the interrupt tries to 
return. Leads to an interesting DOS: just send a bunch of packets
in quick succession and the machine drops off the internet... 

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
