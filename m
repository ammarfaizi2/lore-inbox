Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261465AbSIWWup>; Mon, 23 Sep 2002 18:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261467AbSIWWuo>; Mon, 23 Sep 2002 18:50:44 -0400
Received: from magic.adaptec.com ([208.236.45.80]:13303 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S261465AbSIWWuo>; Mon, 23 Sep 2002 18:50:44 -0400
Date: Mon, 23 Sep 2002 16:55:10 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Konstantin Kletschke <konsti@ludenkalle.de>, linux-kernel@vger.kernel.org
Subject: Re: Quick aic7xxx bug hunt...
Message-ID: <2687750816.1032821710@aslan.btc.adaptec.com>
In-Reply-To: <3D8F9AB9.1040505@mandrakesoft.com>
References: <20020923180017.GA16270@sexmachine.doom>
 <2539730816.1032808544@aslan.btc.adaptec.com>
 <3D8F874B.3070301@mandrakesoft.com>
 <2640410816.1032818062@aslan.btc.adaptec.com>
 <3D8F934F.7000606@mandrakesoft.com>
 <2678680816.1032821098@aslan.btc.adaptec.com>
 <3D8F9AB9.1040505@mandrakesoft.com>
X-Mailer: Mulberry/3.0.0a4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> For all of these delays, I'd be more than happy to make them all into
>> sleeps if I can tell, from inside ahc_delay() if I'm in a context where
>> it is safe to sleep.  On the other platforms that this core code runs on
>> I'm usually not in a context where it is safe to sleep, so I don't want
>> to switch to using a different driver primitive.
> 
> For Linux it's unconditionally safe, and other platforms is sounds like
> it's unconditionally not.  So, s/ahc_delay/ahc_sleep/ for the places I
> pointed out, and just make ahc_delay==ahc_sleep on non-Linux platforms
> (or any similarly-functioning solution)

So you can sleep while in an interrupt context?  I didn't know that
2.5 had switched to using interrupt threads or some similar construct.

> It's pretty much impossible to detect if you are inside certain
> spinlocks, in a generic fashion.

In 2.5, I should only need to release my own host lock assuming it is
held.

--
Justin

