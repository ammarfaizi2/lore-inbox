Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTLNUaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 15:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbTLNUap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 15:30:45 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:54772 "EHLO
	mail.kroptech.com") by vger.kernel.org with ESMTP id S262375AbTLNUao
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 15:30:44 -0500
Date: Sun, 14 Dec 2003 15:35:04 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Nathan Fredrickson <8nrf@qlink.queensu.ca>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>,
       sam@mars.ravnborg.org
Subject: Re: HT schedulers' performance on single HT processor
Message-ID: <20031214153504.A6795@mail.kroptech.com>
References: <200312130157.36843.kernel@kolivas.org> <1071431363.19011.64.camel@rocky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1071431363.19011.64.camel@rocky>; from 8nrf@qlink.queensu.ca on Sun, Dec 14, 2003 at 02:49:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 14, 2003 at 02:49:24PM -0500, Nathan Fredrickson wrote:
> Same table as above normalized to the j=1 uniproc case to make
> comparisons easier.  Lower is still better.
> 
>              j =  1     2     3     4     8
> 1phys (uniproc)  1.00  1.00  1.00  1.00  1.00
> 1phys w/HT       1.02  1.02  0.87  0.87  0.87
> 1phys w/HT (w26) 1.02  1.02  0.87  0.87  0.88
> 1phys w/HT (C1)  1.03  1.02  0.88  0.88  0.88
> 2phys            1.00  1.00  0.53  0.53  0.53
  ^^^^^                  ^^^^

Ummm...

> 2phys w/HT       1.01  1.01  0.64  0.50  0.48
> 2phys w/HT (w26) 1.02  1.01  0.55  0.49  0.47
> 2phys w/HT (C1)  1.02  1.01  0.53  0.50  0.48

> There was not much benefit from either HT or SMP with j=2.  Maximum
> speedup was not realized until j=3 for one physical processor and j=5
> for 2 physical processors.

This is mighty suspicious. With -j2 did you check to see that there
were indeed two parallel gcc's running? Since -test6 I've found that 
-j2 only results in a single gcc instance. I've seen this on both an
old hacked-up RH 7.3 installation and a brand new RH 9 + updates
installation.

> This suggests that j should be set to at least the number of logical
> processors + 1.

Since -test6 I've found this to be the case for kernel builds, yes. But
I don't think it has anything to do with the scheduler or HT vs SMP
platforms.

--Adam

