Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261428AbSIWWkf>; Mon, 23 Sep 2002 18:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261430AbSIWWkf>; Mon, 23 Sep 2002 18:40:35 -0400
Received: from magic.adaptec.com ([208.236.45.80]:47858 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261428AbSIWWke>; Mon, 23 Sep 2002 18:40:34 -0400
Date: Mon, 23 Sep 2002 16:44:58 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Quick aic7xxx bug hunt...
Message-ID: <2678680816.1032821098@aslan.btc.adaptec.com>
In-Reply-To: <3D8F934F.7000606@mandrakesoft.com>
References: <20020923180017.GA16270@sexmachine.doom>
 <2539730816.1032808544@aslan.btc.adaptec.com>
 <3D8F874B.3070301@mandrakesoft.com>
 <2640410816.1032818062@aslan.btc.adaptec.com>
 <3D8F934F.7000606@mandrakesoft.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Great, I stand corrected.  Looks like 2.5 code is ancient then?

Yes.  I didn't do the original port and am now just finishing up my
port to 2.5.X.

> comments on the 2.4 code:
> * the 1000us delay in ahc_reset needs to be turned into a sleep, instead
> all paths to that function [AFAICS] can sleep.  likewise for the huge
> delay in ahc_acquire_seeprom.

For all of these delays, I'd be more than happy to make them all into
sleeps if I can tell, from inside ahc_delay() if I'm in a context where
it is safe to sleep.  On the other platforms that this core code runs on
I'm usually not in a context where it is safe to sleep, so I don't want
to switch to using a different driver primitive.

> * PCI posting?  (aic7xxx_core.c, line 1322, the last statement in the
> function...)
> 
>                  ahc_outb(ahc, CLRINT, CLRSCSIINT);

I don't care when the write occurs only that it will occur eventually.
The buffer will get flushed eventually so there is no need to call
ahc_flush_device_writes().

--
Justin
