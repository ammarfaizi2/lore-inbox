Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129447AbQKEAig>; Sat, 4 Nov 2000 19:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129247AbQKEAi1>; Sat, 4 Nov 2000 19:38:27 -0500
Received: from Cantor.suse.de ([194.112.123.193]:25869 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129136AbQKEAiM>;
	Sat, 4 Nov 2000 19:38:12 -0500
Date: Sun, 5 Nov 2000 01:38:09 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andi Kleen <ak@suse.de>, "Hen, Shmulik" <shmulik.hen@intel.com>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'LNML'" <linux-net@vger.kernel.org>
Subject: Re: Locking Between User Context and Soft IRQs in 2.4.0
Message-ID: <20001105013809.B21900@gruyere.muc.suse.de>
In-Reply-To: <07E6E3B8C072D211AC4100A0C9C5758302B27077@hasmsx52.iil.intel.com> <3A03DABD.AF4B9AD5@mandrakesoft.com> <20001104111909.A11500@gruyere.muc.suse.de> <3A042D04.5B3A7946@mandrakesoft.com> <20001104175659.A15475@gruyere.muc.suse.de> <3A044256.D8CD063C@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A044256.D8CD063C@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Nov 04, 2000 at 12:07:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 12:07:34PM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> > All the MOD_INC/DEC_USE_COUNT are done inside the modules themselves. There
> > is nothing that would a driver prevent from being unloaded on a different
> > CPU while it is already executing in ->open but has not yet executed the add
> > yet or after it has executed the _DEC but it is still running in module code
> > Normally the windows are pretty small, but very long running interrupt
> > on one CPU hitting exactly in the wrong moment can change that.
> 
> Module unload calls unregister_netdev, which grabs rtnl_lock.
> dev->open runs under rtnl_lock.
> 
> Given this, how can the driver be unloaded if dev->open is running?

It does not help, because when the semaphore synchronizes it is already
too late -- free_module already did the zero module count check and 
nothing is going to stop it from unloading.

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
