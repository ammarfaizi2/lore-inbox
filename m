Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318194AbSIFIxZ>; Fri, 6 Sep 2002 04:53:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSIFIxZ>; Fri, 6 Sep 2002 04:53:25 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:59909 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318194AbSIFIxZ>;
	Fri, 6 Sep 2002 04:53:25 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200209060857.g868vqr05475@oboe.it.uc3m.es>
Subject: Re: (fwd) Re: [RFC] mount flag "direct"
In-Reply-To: <5.1.0.14.2.20020906002019.00ac7290@pop.cus.cam.ac.uk> from Anton
 Altaparmakov at "Sep 6, 2002 00:24:00 am"
To: Anton Altaparmakov <aia21@cantab.net>
Date: Fri, 6 Sep 2002 10:57:52 +0200 (MET DST)
Cc: Daniel Phillips <phillips@arcor.de>, "Peter T. Breuer" <ptb@it.uc3m.es>,
       Alexander Viro <viro@math.psu.edu>,
       Xavier Bestel <xavier.bestel@free.fr>, david.lang@digitalinsight.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Anton Altaparmakov wrote:"
> [DanP]
> >He was going to go hack the vfs, so in his mind, practical issues of how the
> >vfs works now aren't an obstacle.  The only mistake he's making is seriously
> >underestimating how much effort is required to learn enough to do this kind
> >of surgery and have a remote chance that the patient will survive.
> 
> Ok so he plans to rewrite the whole I/O subsystem starting from block up to 
> FS drivers and VFS. Great. See him again in 10 years... And his changes 

I've had a look now. I concur that e2fs at least is full of assumptions
that it has various different sorts of metadata in memory at all times.
I can't rewrite that, or even add a "warning will robinson" callback to
vfs, as I intended. What I can do, I think, is ..

.. simply do a dput of the fs root directory from time to time, from
vfs - whenever I think it is appropriate. As far as I can see from my
quick look that may cause the dcache path off that to be GC'ed. And
that may be enough to do a few experiments for O_DIRDIRECT.

Is that (approx) correct?

Peter
