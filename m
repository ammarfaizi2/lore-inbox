Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272056AbRIIQPL>; Sun, 9 Sep 2001 12:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272044AbRIIQPB>; Sun, 9 Sep 2001 12:15:01 -0400
Received: from smtp01.uc3m.es ([163.117.136.121]:22533 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S272049AbRIIQOw>;
	Sun, 9 Sep 2001 12:14:52 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200109091615.f89GF5j24432@oboe.it.uc3m.es>
Subject: Re: Query about Tun/Tap Modules
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Sun, 9 Sep 2001 18:15:05 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Erik Andersen wrote:"
> On Sun Sep 09, 2001 at 08:58:56PM +0530, Shiva Raman Pandey wrote:
> > 
> > Q2. What can be other ways, not very complicated  to solve my purpose
> > instead of using Tun/Tap.
> 
> The network block device can be used via loopback...

Not totally relaibly, however. It must deadlock when writing to a
server on the same machine, because when we run out of memory
we must free buffers by flushing pending writes on devices, which will
send packets for the nbd out to loaclhost and to the local server, where
they will take a buffer just prior to being written to disk ... and
of course they won't succeed because we are out of memory.

I would like the algorithms that free buffers to avoid the device
that caused the memory pressure. Since they can't do that, the
next best thing is to avoid it some of the time, which they
can do by avoiding everything randomly. Please add randomness under
stress, people.

Peter
