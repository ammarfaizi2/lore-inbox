Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVC3IA5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVC3IA5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 03:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVC3IA5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 03:00:57 -0500
Received: from zone4.gcu-squad.org ([213.91.10.50]:28389 "EHLO
	zone4.gcu-squad.org") by vger.kernel.org with ESMTP id S261810AbVC3IAt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 03:00:49 -0500
Date: Wed, 30 Mar 2005 09:53:03 +0200 (CEST)
To: vonbrand@inf.utfsm.cl
Subject: Re: Do not misuse Coverity please
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <OofSaT76.1112169183.7124470.khali@localhost>
In-Reply-To: <200503300125.j2U1PFQ9005082@laptop11.inf.utfsm.cl>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: "Andrew Morton" <akpm@osdl.org>, "Adrian Bunk" <bunk@stusta.de>,
       "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Horst,

> > > No, there is a third case: the pointer can be NULL, but the compiler
> > > happened to move the dereference down to after the check.
>
> > Wow. Great point. I completely missed that possibility. In fact I didn't
> > know that the compiler could possibly alter the order of the
> > instructions. For one thing, I thought it was simply not allowed to. For
> > another, I didn't know that it had been made so aware that it could
> > actually figure out how to do this kind of things. What a mess. Let's
> > just hope that the gcc folks know their business :)
>
> The compiler is most definitely /not/ allowed to change the results the
> code gives.

I think that Andrew's point was that the compiler could change the order
of the instructions *when this doesn't change the result*, not just in
the general case, of course. In our example, The instructions:

    v = p->field;
    if (!p) return;

can be seen as equivalent to

    if (!p) return;
    v = p->field;

by the compiler, which might actually optimize the first into the second
(and quite rightly so, as it actually is faster in the null case). The
fact that doing so prevents an oops is unknown to the compiler, so it
just wouldn't care.

Now I don't know what gcc actually does or not, but Andrew's point
makes perfect sense to me in the theory, and effectively voids my own
argument if gcc performs this kind of optimizations. (The prefered
approach to fix these bugs is a different issue though.)

--
Jean Delvare
