Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRCFT1I>; Tue, 6 Mar 2001 14:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129409AbRCFT06>; Tue, 6 Mar 2001 14:26:58 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:65288 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129402AbRCFT0x>;
	Tue, 6 Mar 2001 14:26:53 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200103061926.WAA23796@ms2.inr.ac.ru>
Subject: Re: Inadequate documentation: sockets
To: alex@baretta.COM (Alessandro Baretta)
Date: Tue, 6 Mar 2001 22:26:38 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AA52916.5FD87258@baretta.com> from "Alessandro Baretta" at Mar 6, 1 09:45:02 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> The manual specifies the following flag to be returned by the
> kernel
> > #define POLLHUP     0x0010    /* Hung up */
> 
> Hanging up is ambiguous. Does it mean that the client is dead,
> that he closed his end of the socket, or that he shut down one or
> both directions of the data flow? The following man page clears
> this up, but I think the following information would best be
> placed in man poll.

The information is is not quite correct.

POLLHUP is really ambigous in the case of full-duplex connections
with bi-directional close sort of TCP. However, invariants are:

* POLLHUP is set when connection is closed in both directions.
* POLLHUP implies that descriptor is not-writable and any write
  will cause error and, probably, SIGPIPE.
* POLLHUP is _not_ set when descriptor is writable (i.e. connection
  is shutdowned in write direction by remote)

Standards require that POLLHUP and POLLOUT never happened
together, however linux does this, which is formally bug.
However, it is not fixed, assuming that POLLHUP overrides POLLOUT.


> Finally I'm left with my original problem: how am I supposed to
> detect a close or a shutdown from the peer?

By EOF. No other way exists. POLLHUP is local condition, only
local side can close connection in write direction. Exception
is abort (reset) initiated by peer.


> by addressing me to more adequate documentation.

UNIX98 and Austin draft pages. The are very ambiguous though.

Alexey
