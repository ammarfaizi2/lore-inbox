Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266535AbSKORcM>; Fri, 15 Nov 2002 12:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSKORcL>; Fri, 15 Nov 2002 12:32:11 -0500
Received: from mons.uio.no ([129.240.130.14]:4561 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S266535AbSKORcI>;
	Fri, 15 Nov 2002 12:32:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15829.12372.977319.366227@helicity.uio.no>
Date: Fri, 15 Nov 2002 18:35:16 +0100
To: Juan Gomez <juang@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: Non-blocking lock requests during the grace period
In-Reply-To: <OF92154664.1C5EF07E-ON87256C72.005A0481@us.ibm.com>
References: <OF92154664.1C5EF07E-ON87256C72.005A0481@us.ibm.com>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


     > 2.-I also have this part enclosed in the if(resp->status ==
     > NLM_LCK_DENIED_GRACE_PERIOD) as follows:

     > if(resp->status == NLM_LCK_DENIED_GRACE_PERIOD) {

     >       blah blah...

     > wait_on_grace:
     >                          if ((proc == NLMPROC_LOCK) &&
     >                          !argp->block)
     >                                      return -EAGAIN
     > } else {

     >       ....
     > }

     > This with the intention to be very specific as to when we want
     > the return -EAGAIN to be called.

The above means that you will still block on a F_GETLK query...

In any case, why would we want to return -EAGAIN in one case where
argp->block isn't set, and not in another? If there are cases where we
want to block and where we are not currently setting argp->block (the
only one I can think of might be NLMPROC_UNLOCK), then we should fix
the caller.

Cheers,
  Trond
