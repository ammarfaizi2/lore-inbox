Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbTLNVP5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 16:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbTLNVP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 16:15:57 -0500
Received: from qlink.QueensU.CA ([130.15.126.18]:12451 "EHLO qlink.queensu.ca")
	by vger.kernel.org with ESMTP id S262655AbTLNVPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 16:15:51 -0500
Subject: Re: HT schedulers' performance on single HT processor
From: Nathan Fredrickson <8nrf@qlink.queensu.ca>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Nick Piggin <piggin@cyberone.com.au>, Ingo Molnar <mingo@elte.hu>,
       sam@mars.ravnborg.org
In-Reply-To: <20031214153504.A6795@mail.kroptech.com>
References: <200312130157.36843.kernel@kolivas.org>
	 <1071431363.19011.64.camel@rocky>  <20031214153504.A6795@mail.kroptech.com>
Content-Type: text/plain
Message-Id: <1071436539.19124.6.camel@rocky>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 14 Dec 2003 16:15:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-14 at 15:35, Adam Kropelin wrote:
> On Sun, Dec 14, 2003 at 02:49:24PM -0500, Nathan Fredrickson wrote:
> > Same table as above normalized to the j=1 uniproc case to make
> > comparisons easier.  Lower is still better.
> > 
> >              j =  1     2     3     4     8
> > 1phys (uniproc)  1.00  1.00  1.00  1.00  1.00
> > 1phys w/HT       1.02  1.02  0.87  0.87  0.87
> > 1phys w/HT (w26) 1.02  1.02  0.87  0.87  0.88
> > 1phys w/HT (C1)  1.03  1.02  0.88  0.88  0.88
> > 2phys            1.00  1.00  0.53  0.53  0.53
>   ^^^^^                  ^^^^
> 
> Ummm...
> 
> This is mighty suspicious. With -j2 did you check to see that there
> were indeed two parallel gcc's running? Since -test6 I've found that 
> -j2 only results in a single gcc instance. I've seen this on both an
> old hacked-up RH 7.3 installation and a brand new RH 9 + updates
> installation.

I just checked and you're right, the number of compilers that actually
run is j-1, for all j>1.  I assume this is a problem with the parallel
build process, but it does not invalidate these results for comparing
the scheduler performance with different patches.
> 
> > This suggests that j should be set to at least the number of logical
> > processors + 1.
> 
> Since -test6 I've found this to be the case for kernel builds, yes. But
> I don't think it has anything to do with the scheduler or HT vs SMP
> platforms.

The 1-3% performance loss when HT is enabled for -j1 is still very real.

Nathan



