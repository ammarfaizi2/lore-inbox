Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317315AbSFLSPB>; Wed, 12 Jun 2002 14:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317754AbSFLSPA>; Wed, 12 Jun 2002 14:15:00 -0400
Received: from ns1.ptt.yu ([212.62.32.1]:62379 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id <S317315AbSFLSO7>;
	Wed, 12 Jun 2002 14:14:59 -0400
Subject: Re: [PATCH] Futex Asynchronous Interface
From: Vladimir Zidar <mr_w@mindnever.org>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D077BBB.6090708@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/1.0.2 
Date: 12 Jun 2002 20:15:42 +0200
Message-Id: <1023905756.1387.290.camel@server1>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by ns1.ptt.yu id g5CIElH26157
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-12 at 18:50, Peter Wächtler wrote:

> >>What are the plans on how to deal with a waiter when the lock holder
> >>dies abnormally?
> >>
> >>What about sending a signal (SIGTRAP or SIGLOST), returning -1 and
> >>setting errno to a reasonable value (EIO?)
> >>
> >>I couldn't find anything in susv3
> >>
> > 
> > I thing this was decided some time ago that we won't deal with this situation.
> > If we need to, the following needs to happen.
> > 
> > A) we need to follow a protocol to register the PID/TID id within the lock.
> >     Example of this is described in 
> > 	"Recoverable User-Level Mutual Exclusion" by Phiilip Bohannon
> >             Proceedings of the 7th IEEE Symposium on Parallel and Distributed 
> >             Systems, 1995.
> > 
> > B) this again requires that some entity (kernel ?) knows about all locks, 
> > whether waited on in the kernel or not.
> > 
> > C) I believe we need a deamon that occasinally identifies dead locks.
> > 
> > Is it worth all this trouble? Or do we need two versions of the ?
> > 
> > The paper describes that for a Sun SS20/61 the safe spin locks obtained
> > only 25% of the performance of spinlocks.
> > 
> 
> Oops, I see it already myself. We lack a way for saying who is/was owning
> the futex and so we can hardly tell who is waiting on this "unknown" lock.
> :-(

 Which is not the case in 'nutex' implementation.

 Take look:

 http://www.mindnever.org/~mr_w/nutex_mod.tar.gz


-- 
Bye,

 and have a very nice day !



