Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWEOXZB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWEOXZB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 19:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbWEOXZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 19:25:01 -0400
Received: from mx.pathscale.com ([64.160.42.68]:1165 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750756AbWEOXZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 19:25:00 -0400
Message-ID: <40771.71.131.57.117.1147735500.squirrel@rocky.pathscale.com>
In-Reply-To: <ada64k6sx7w.fsf@cisco.com>
References: <f8ebb8c1e43635081b73.1147477418@eng-12.pathscale.com>
    <adazmhjth56.fsf@cisco.com>
    <1147727447.2773.14.camel@chalcedony.pathscale.com>
    <60844.71.131.57.117.1147734080.squirrel@rocky.pathscale.com>
    <ada64k6sx7w.fsf@cisco.com>
Date: Mon, 15 May 2006 16:25:00 -0700 (PDT)
Subject: Re: [PATCH 53 of 53] ipath - add memory barrier when waiting for  
     writes
From: ralphc@pathscale.com
To: "Roland Dreier" <rdreier@cisco.com>
Cc: ralphc@pathscale.com, "Bryan O'Sullivan" <bos@pathscale.com>,
       openib-general@openib.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.6
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     ralphc> I don't have a lot to add to this other than I looked at
>     ralphc> the assembly code output for -Os and -O3 and both looked
>     ralphc> OK.  I put the mb() in to be sure the writes were complete
>     ralphc> and I found this to work by experimentation.  Without it,
>     ralphc> the driver fails to read the EEPROM correctly.
>
> Hmm, that doesn't give me a warm fuzzy feeling.  Basically on x86-64
> you're adding an unneeded mfence instruction to work around
> miscompilation?
>
> Is i2c_wait_for_writes miscompiled without the mb() with -Os?  What
> does the bad assembly look like?
>
>  - R.

We had a power failure here so I'm not able to reproduce the
assembly code at the moment.  What I remember from looking
at the code is that the code for ipath_read_kreg32() was
present in i2c_wait_for_writes() when compiled -Os so
it didn't look like a compiler bug.  I probably could put the
mb() at the end of i2c_gpio_set() if that makes you more
comfortable.  The mb() is definitely needed though.

