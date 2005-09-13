Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVIMRPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVIMRPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVIMRPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:15:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44978 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964894AbVIMRPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:15:30 -0400
Date: Tue, 13 Sep 2005 10:15:22 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Mathieu Fluhr <mfluhr@nero.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: "Read my lips: no more merges" - aka Linux 2.6.14-rc1
In-Reply-To: <1126630878.2066.6.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0509131010010.3351@g5.osdl.org>
References: <Pine.LNX.4.58.0509122019560.3351@g5.osdl.org> 
 <1126608030.3455.23.camel@localhost.localdomain> <1126630878.2066.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Sep 2005, Mathieu Fluhr wrote:
>
> Ok, after having performed a bisection of the kernel tree (took me the
> whole afternoon.... 13 compilations needed ;-) I think I am able to give
> the faulty patch for these buffer underruns: 

Thanks, interesting.

And hey, 13 compilations may sound like a lot, but considering that there
were 2069 commits between 2.6.12 and 2.6.13-rc1, having to do "just" 13
kernels to pinpoint the exact cause is pretty good, I think.

Especially as I don't think anybody would really have expected the one you 
found:

> [PATCH] i386: Selectable Frequency of the Timer Interrupt
> 
> So I would say that it is related to somehow some kind of timeout in
> SCSI I/O (but really not sure...).

Interesting, and a bit scary. If it worked with 1kHz (old default value),
it's not even any of the old Linux x86 timeouts (that were designed for
100 Hz), so it's some _new_ HZ dependency.

> As far as I saw, there is now an option in the kernel config file
> related to this, so I will try to see what happens with 1000 Hz and 100
> Hz (I left the default value of 250 Hz for my tests).

Yes, that would be interesting.

Btw, what's the exact error message you get? (And is it the kernel or the
burning app that complains?)

			Linus
