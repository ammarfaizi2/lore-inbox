Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbTC0Xrl>; Thu, 27 Mar 2003 18:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbTC0XrA>; Thu, 27 Mar 2003 18:47:00 -0500
Received: from fmr02.intel.com ([192.55.52.25]:13818 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S261631AbTC0Xpg> convert rfc822-to-8bit; Thu, 27 Mar 2003 18:45:36 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C780B7174C6@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Roger Larsson'" <roger.larsson@skelleftea.mail.telia.com>
Cc: "'lkml (linux-kernel@vger.kernel.org)'" 
	<linux-kernel@vger.kernel.org>
Subject: RE: How to force another (FIFO) task to yield from inside the ker
	nel?
Date: Thu, 27 Mar 2003 15:56:38 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Roger [copying to lkml]

> -----Original Message-----
> From: Roger Larsson [mailto:roger.larsson@skelleftea.mail.telia.com]
> 
> On Wednesday 26 March 2003 06:23, Perez-Gonzalez, Inaky wrote:
> >
> > I am dealing with this problem and it is time to ask (read the source
> > already). I have this in the rtfutex priority inheritance code: when
> task A
> > boosts task B's priority (both FIFO), task B runs with A's priority
> until B
> > decides to stop waiting for A to finish (ie: timeout/signal).
> 
> Don't you have a deadlock here?
> * A waiting for B and boosting B's priority.
> * B waiting for A to finish.
> * But A is waiting for B....

Crap! Typo in the house: should be until A decides to stop waiting for B to
finish (I should use a consistent terminology ... B was in my head the
Booster thread)

Good catch!

> * B inherits A's priority => same priority
> * B will run until
>  - the B priority gets lowered (shouldn't that happen when B is releasing
>    the lock A is waiting for?)

B's priority (Boosted) is lowered when B unlocks or when A stops waiting
(signal/timeout).

The former is the one causing trouble - now I get it to yield (unsing a
modification of sys_sched_yield()), but the priority does not seem to be
correctly lowered). I mean, it seems that it keep running with the same high
priority.

> Maybe B should get A's priority minus one?

No, it has to be A's ... otherwise it is cheating :)

Thanks!

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)


