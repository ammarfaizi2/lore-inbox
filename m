Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262671AbTCZX5R>; Wed, 26 Mar 2003 18:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbTCZX5Q>; Wed, 26 Mar 2003 18:57:16 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:24840 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S262671AbTCZX5P>;
	Wed, 26 Mar 2003 18:57:15 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200303270008.h2R08Fr11963@oboe.it.uc3m.es>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <5.1.0.14.2.20030327104129.032dee90@mira-sjcm-3.cisco.com> from
 Lincoln Dale at "Mar 27, 2003 10:49:55 am"
To: Lincoln Dale <ltd@cisco.com>
Date: Thu, 27 Mar 2003 01:08:15 +0100 (MET)
Cc: ptb@it.uc3m.es, Jeff Garzik <jgarzik@pobox.com>,
       Matt Mackall <mpm@selenic.com>,
       Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lincoln Dale wrote:"
> Hi Peter,

Hi!

> decent GE cards will do coalescing themselves anyway.

 From what I confusedly remember of my last interchange with someone
convinced that packet coalescing (or lack of it, I forget which)
was the root of all evil, it's "all because" there's some magic limit
of 8K interrupts per second somewhere, and at 1.5KB per packet, that
would be only 12MB/s. So Ge cards wait after each interrupt to see if
there's some more stuff coming, so that they can treat more than one
packet at a time.

Apparently that means that if you have a two-way interchange in
your protocol at low level, they wait at the end of each half of
the protocol, even though you can't proceed with the protocol
until they decide to stop listening and start working. And the 
result is a severe slowdown.

In my naive opinion, hat should make ENBD's architecture (in which all
the channels going through the same NIC nevertheless work independently
and asynchronously) have an advantage, because pipelining effects
will fill up the slack time spaces in one channel's protocol with
activity from other channels.

But surely the number of channels required to fill up the waiting time
woulod be astronomical? Oh well.

Anyway, my head still spins. 

The point is that none of this is as easy or straightforward as it
seems. I suspect that pure storage people like andre will make a real
mess of the networking considerations. It's just not easy.

Peter
