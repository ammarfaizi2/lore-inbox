Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUCEXon (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUCEXon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:44:43 -0500
Received: from [80.72.36.106] ([80.72.36.106]:23002 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S261474AbUCEXol (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:44:41 -0500
Date: Sat, 6 Mar 2004 00:44:37 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.3.0
In-Reply-To: <m3brnb8bxa.fsf@defiant.pm.waw.pl>
Message-ID: <Pine.LNX.4.58.0403060022570.5790@alpha.polcom.net>
References: <200402291942.45392.mmazur@kernel.pl> <200403031829.41394.mmazur@kernel.pl>
 <m3brnc8zun.fsf@defiant.pm.waw.pl> <200403042149.36604.mmazur@kernel.pl>
 <m3brnb8bxa.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2004, Krzysztof Halasa wrote:
> BTW: the user space programs don't necessarily need glibc. They may need
> the kernel API headers, of course.
> You may even want to use another C library. Would you copy the headers
> in such case again?

I agree.


> > As to linux-common linux-kernelonly and linux-userland headers (linux-common 
> > used by both) - I just find it weird for userland to require kernel sources. 

But some programs (hdparm?) and/or libs must (for example most C libs like 
glibc)...


> >> If they are part of kernel API/ABI, then of course they are still used
> >> by 2.6 kernel and they need to be there. If they aren't used by the
> >> kernel (old #define names for instance) they should go to glibc headers
> >> (#ifndef xxx #define xxx etc.).
> >
> > Additionall defines mostly. Probably some extra structures.
> 
> I'd go with the above, then.

But how synchronize kernel development with glibcs (+ all other C libs + 
all other programs that must interface directly with the kernel)?

When kernel developers want to stop using something, how they should tell 
that to glibc developers and others. And how these non-kernel developers 
can change their projects in very short time to start using new kernel 
headers (= define things removed from the kernel in their own headers)? 
Most admins change kernels more often than all other programs and libs 
and these programs can potenitially not be updated yet.

My proposal is to move these things from linux-common to linux-userland 
instead of removng them from the kernel immendiatelly.
So no compatibility with user program and libs will be broken (and after a 
few releases of kernel, when all programs and libs will be updated, these 
things can be removed completly from kernel headers of all three types).


Grzegorz Kulewski
ex inx user :)

