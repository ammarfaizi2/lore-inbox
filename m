Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284488AbRLRSgX>; Tue, 18 Dec 2001 13:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284506AbRLRSgD>; Tue, 18 Dec 2001 13:36:03 -0500
Received: from m851-mp1-cvx1c.edi.ntl.com ([62.253.15.83]:19438 "EHLO
	pinkpanther.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S284500AbRLRSgB>; Tue, 18 Dec 2001 13:36:01 -0500
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200112181727.fBIHRkm16908@pinkpanther.swansea.linux.org.uk>
Subject: Re: [PATCH] kill(-1,sig)
To: sim@netnation.com (Simon Kirby)
Date: Tue, 18 Dec 2001 17:27:46 +0000 (GMT)
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011214123628.A22506@netnation.com> from "Simon Kirby" at Dec 14, 2001 12:36:28 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Dec 14, 2001 at 05:34:48PM +0000, Andries.Brouwer@cwi.nl wrote:
> 
> > + * POSIX (2001) specifies "If pid is -1, sig shall be sent to all processes
> > + * (excluding an unspecified set of system processes) for which the process
> > + * has permission to send that signal."
> > + * So, probably the process should also signal itself.
> > -			if (p->pid > 1 && p != current) {
> > +			if (p->pid > 1) {
> 
> Argh, I hate this.  I fail to see what progress a process could make if
> it kills everything _and_ itself.  I frequently use "kill -9 -1" to kill
> everything except my shell, and now I'll have to kill everything else
> manually, one by one.
> 
> If a process wants to commit suicide too, why doesn't it just do that
> after?

This is the best suggestion I've yet seen. kill() is defined at C library
level so glibc can do the self kill at the end if POSIX_ME_HARDER is
in the environment

