Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265703AbTFSClN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 22:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265704AbTFSClN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 22:41:13 -0400
Received: from fmr06.intel.com ([134.134.136.7]:42981 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S265703AbTFSClM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 22:41:12 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780DD16D51@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'george anzinger'" <george@mvista.com>
Cc: "'Andrew Morton'" <akpm@digeo.com>,
       "'joe.korty@ccur.com'" <joe.korty@ccur.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'mingo@elte.hu'" <mingo@elte.hu>
Subject: RE: O(1) scheduler seems to lock up on sched_FIFO and sched_RR ta
	 sks
Date: Wed, 18 Jun 2003 19:55:06 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: george anzinger [mailto:george@mvista.com]
> 
> Wait a bit (or even a byte) here.  I think the proper thing to do, IF
> we want to go down this road, is to seperate out the various
> subsystems and give them each their own kernel task or workqueue.

Thaaaaaaat'd be so nice ... it'd also waste a lot of resources ...
maybe; I don't know if everybody at the lkml would swallow it.

That grossly reminds me of Timesys ... btw

> Then  those who need to could adjust, for example, network code to run
> ..<snip>.. If you give any kernel thread an untouchable priority, you
> might just as well move the work back to a bottom half or even the
> interrupt code.

My fault in not being more precise: on setting kernel stuff to FIFO 99+1,
for example, I was talking about defaults; users (better, admins/
designers) should be able to then tweak it (specially on embedded systems).

My point is that when Joe Sixpack fires some common appl that happens
to use RT things, he doesn't have to understand the whole book on
realtime and stuff to be able to tweak the system so it works.

In fact, Robert's point is the best, IMHO. Basically you add some more
priority space (20, I think he mentions) that are reserved for
system stuff (I think Solaris has something similar). They are the
only ones that can use that priority space, asides from the normal
space reserved to the user.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
