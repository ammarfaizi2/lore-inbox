Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbSJWQKq>; Wed, 23 Oct 2002 12:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265075AbSJWQKq>; Wed, 23 Oct 2002 12:10:46 -0400
Received: from nameservices.net ([208.234.25.16]:15564 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265074AbSJWQKp>;
	Wed, 23 Oct 2002 12:10:45 -0400
Message-ID: <3DB6CC71.9DA9A543@opersys.com>
Date: Wed, 23 Oct 2002 12:21:05 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: Richard J Moore <richardj_moore@uk.ibm.com>,
       Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       S Vamsikrishna <vamsi_krishna@in.ibm.com>
Subject: Re: 2.4 Ready list - Kernel Hooks
References: <OFD4366ECB.CE549043-ON80256C5A.007614F9@portsmouth.uk.ibm.com> <20021023122841.G1421@almesberger.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:
> Richard J Moore wrote:
> > This is nothing more than a call-back mechanism such as could be used by
> > LSM or LTT.
> 
> Hmm, Greg has already voiced some violent disagreement regarding
> LSM :-) That leaves LTT. Given the more exploratory nature of LTT,
> I wonder if [dk]probes wouldn't be quite sufficient there, too.

The whole point of tracing is that the system's behavior should not
be modified but only recorded. Generating int3 won't do.

> Oh, you could probably have some "fast" probes by just checking
> for a certain "anchor" pattern (e.g. a sequence of 5 nops on
> i386), which could then be replaced with a direct call. This
> optimization would have to be optional, in case some code yields
> the anchor pattern such that it isn't also a basic block.

If I remember correctly, the optimized arch-dependent code in kernel
hooks uses "compare immediate" and the value of the immediate is
edited to enable/disable hooking. Given modern branch-prediction the
cost should be quite close to an unconditional jump.

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
