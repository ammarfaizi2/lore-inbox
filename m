Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129238AbQKDQ52>; Sat, 4 Nov 2000 11:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129258AbQKDQ5T>; Sat, 4 Nov 2000 11:57:19 -0500
Received: from Cantor.suse.de ([194.112.123.193]:28937 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129238AbQKDQ5C>;
	Sat, 4 Nov 2000 11:57:02 -0500
Date: Sat, 4 Nov 2000 17:56:59 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andi Kleen <ak@suse.de>, "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
Message-ID: <20001104175659.A15475@gruyere.muc.suse.de>
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com> <3A03DABD.AF4B9AD5@mandrakesoft.com> <20001104111909.A11500@gruyere.muc.suse.de> <3A042D04.5B3A7946@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A042D04.5B3A7946@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Nov 04, 2000 at 10:36:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 10:36:36AM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> > 
> > On Sat, Nov 04, 2000 at 04:45:33AM -0500, Jeff Garzik wrote:
> > >
> > > > *       What about dev->open and dev->stop ?
> > >
> > > Sleep all you want, we'll leave the light on for ya.
> > 
> > ... but make sure you have no module unload races (or at least not too
> > huge holes, some are probably unavoidable with the current network
> > driver interface, e.g. without moving module count management a bit up).
> > This means you should do MOD_INC_USE_COUNT very early at least to
> > minimize the windows (and DEC_USE_COUNT very late)
> 
> Can you provide a trace of a race or deadlock?  I do not see where there
> are races in the current 2.4.x code.

All the MOD_INC/DEC_USE_COUNT are done inside the modules themselves. There
is nothing that would a driver prevent from being unloaded on a different
CPU while it is already executing in ->open but has not yet executed the add 
yet or after it has executed the _DEC but it is still running in module code
Normally the windows are pretty small, but very long running interrupt
on one CPU hitting exactly in the wrong moment can change that.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
