Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136589AbREEEuz>; Sat, 5 May 2001 00:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136651AbREEEuo>; Sat, 5 May 2001 00:50:44 -0400
Received: from MAIL1.ANDREW.CMU.EDU ([128.2.10.131]:14813 "EHLO
	mail1.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S136589AbREEEui>; Sat, 5 May 2001 00:50:38 -0400
Date: Sat, 5 May 2001 00:49:33 -0400 (EDT)
From: Paul Komarek <komarek@andrew.cmu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org, ross@willow.seitz.com,
        komarek@andrew.cmu.edu, John Fremlin <chief@bandits.org>
Subject: Re: 2.4.x APM interferes with FA311TX/natsemi.o
In-Reply-To: <E14uN9K-0000fb-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21L.0105050029180.14755-100000@unix49.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 May 2001, Alan Cox wrote:

> > When the call
> >   apm_bios_call_simple(APM_FUNC_SET_STATE, 0x100, APM_STATE_READY, &eax)
> > is made, the PMEEN (PME enable) bit in the CCSR register on my FA311
> > mysteriously changes from 0 to 1, causing the card to stop processing
> 
> The Linux driver set the power management of the card off. The BIOS then 
> rudely fiddled with it. If its not a laptop seriously consider just turning
> off APM support. The Linux idle loop halts will do a fair job of power
> saving anyway

Thanks to everyone that has helped me with this problem (Netgear FA311
dies when apm.c's set_power_state() is called to unblank screen, for
instance when an X server exits or the monitor is awakened from
APM-induced sleep).  Since everyone has suggested work arounds, I'm going
to assume it isn't worthwhile digging any deeper for causes.

I've sent a two-line patch for the natsemi.c driver to the mainainers,
which simply re-disables power management before checking if there are any
packets to process in the receive buffer.  Turning off the APM screen
blanking option in the kernel also works.  My patch isn't in the 2.4.4
kernel -- perhaps the maintainers have a better idea than my hack, or are
hoping to find one =-) -- but if anybody wants this patch, my email
address should be valid at least until the 2.6.x kernels.

-Paul Komarek
komarek@andrew.cmu.edu



