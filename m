Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136088AbREBXo7>; Wed, 2 May 2001 19:44:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136092AbREBXos>; Wed, 2 May 2001 19:44:48 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:21510 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S136088AbREBXol>;
	Wed, 2 May 2001 19:44:41 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200105022344.f42NiZ727894@oboe.it.uc3m.es>
Subject: Re: [OT] Interrupting select
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Thu, 3 May 2001 01:44:35 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark Hahn wrote:"
> >              while (1) {
> >                  int res = select(n,rfds,wfds,efds,&timeout);
> >                  if (res > 0)
> >                     return res;    // data or error is expected
> >                  if (res == 0) {
> >                     return -ETIME; // timeo in select
> >                  }
> >              }
> > 
> > A resounding "no". kill -9 hurts it but it's invulnerable to everything
> > else.
> 
> um, shouldn't you be testing for res==-1, as well?
> specifically that condition and errno==EINTR is how I'd expect
> signals to effect the loop...

Possibly .. if so that's the answer. But the man page doesn't say so:

          tained in the descriptor sets, which may be zero if the
          timeout expires before anything interesting happens.  On
          error, -1 is returned, and errno is set appropriately;

I assumed that "error" is something like trying to  watch for a
negative number or zero descriptors, or having a fd_set that doesn't
contain open fd's. The reason I assumed that is because EINTR is not
listed as a possible:

    
ERRORS
       EBADF   An invalid file descriptor was given in one of the
               sets.
       EINTR   A non blocked signal was caught.
       EINVAL  n is negative.
       ENOMEM  select was unable to allocate memory for  internal
               tables.

But I'm willing to give it a try! Thanks!

Now back to your regularly scheduled programs ...

Peter

