Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261433AbSIWWpy>; Mon, 23 Sep 2002 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261434AbSIWWpy>; Mon, 23 Sep 2002 18:45:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41988 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261433AbSIWWpx>;
	Mon, 23 Sep 2002 18:45:53 -0400
Message-ID: <3D8F9AB9.1040505@mandrakesoft.com>
Date: Mon, 23 Sep 2002 18:50:33 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Quick aic7xxx bug hunt...
References: <20020923180017.GA16270@sexmachine.doom> <2539730816.1032808544@aslan.btc.adaptec.com> <3D8F874B.3070301@mandrakesoft.com> <2640410816.1032818062@aslan.btc.adaptec.com> <3D8F934F.7000606@mandrakesoft.com> <2678680816.1032821098@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
>>Great, I stand corrected.  Looks like 2.5 code is ancient then?
> 
> 
> Yes.  I didn't do the original port and am now just finishing up my
> port to 2.5.X.
> 
> 
>>comments on the 2.4 code:
>>* the 1000us delay in ahc_reset needs to be turned into a sleep, instead
>>all paths to that function [AFAICS] can sleep.  likewise for the huge
>>delay in ahc_acquire_seeprom.
> 
> 
> For all of these delays, I'd be more than happy to make them all into
> sleeps if I can tell, from inside ahc_delay() if I'm in a context where
> it is safe to sleep.  On the other platforms that this core code runs on
> I'm usually not in a context where it is safe to sleep, so I don't want
> to switch to using a different driver primitive.

For Linux it's unconditionally safe, and other platforms is sounds like 
it's unconditionally not.  So, s/ahc_delay/ahc_sleep/ for the places I 
pointed out, and just make ahc_delay==ahc_sleep on non-Linux platforms 
(or any similarly-functioning solution)

It's pretty much impossible to detect if you are inside certain 
spinlocks, in a generic fashion.


>>* PCI posting?  (aic7xxx_core.c, line 1322, the last statement in the
>>function...)
>>
>>                 ahc_outb(ahc, CLRINT, CLRSCSIINT);
> 
> 
> I don't care when the write occurs only that it will occur eventually.
> The buffer will get flushed eventually so there is no need to call
> ahc_flush_device_writes().

ok, thanks for clarifying.

	Jeff



