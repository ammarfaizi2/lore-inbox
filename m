Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSIWWOQ>; Mon, 23 Sep 2002 18:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261461AbSIWWOQ>; Mon, 23 Sep 2002 18:14:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41234 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261440AbSIWWOP>;
	Mon, 23 Sep 2002 18:14:15 -0400
Message-ID: <3D8F934F.7000606@mandrakesoft.com>
Date: Mon, 23 Sep 2002 18:18:55 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Quick aic7xxx bug hunt...
References: <20020923180017.GA16270@sexmachine.doom> <2539730816.1032808544@aslan.btc.adaptec.com> <3D8F874B.3070301@mandrakesoft.com> <2640410816.1032818062@aslan.btc.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:
> I somewhat doubt that any CPU would hold onto a posted write for 200us
> since you are not guaranteed that a read will occur quickly and you want
> those write buffers to be availble for other clients, but regardless, the
> code has not been as you describe since November of last year.


Great, I stand corrected.  Looks like 2.5 code is ancient then?

comments on the 2.4 code:
* the 1000us delay in ahc_reset needs to be turned into a sleep, instead 
all paths to that function [AFAICS] can sleep.  likewise for the huge 
delay in ahc_acquire_seeprom.

* 400ms worst case udelay() is in ahc_clear_critical_section is kinda 
annoying [but I suppose it can be lived with, if the average is a lot 
less than that :)]

* the delay in ahc_init should be replaced with a sleep

* PCI posting?  (aic7xxx_core.c, line 1322, the last statement in the 
function...)

                 ahc_outb(ahc, CLRINT, CLRSCSIINT);

I'll look it over some more later.

