Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261848AbVAHVyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261848AbVAHVyj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 16:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVAHVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 16:54:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:38335 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261894AbVAHVwG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 16:52:06 -0500
Date: Sat, 8 Jan 2005 13:51:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <1105220326.24592.98.camel@krustophenia.net>
Message-ID: <Pine.LNX.4.58.0501081345440.2386@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>  <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
  <1105113998.24187.361.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org> 
 <Pine.LNX.4.58.0501070936500.2272@ppc970.osdl.org> <41DEF81B.60905@sun.com>
  <41DF1F3D.3030006@nortelnetworks.com> <1105220326.24592.98.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 8 Jan 2005, Lee Revell wrote:
> 
> Many latency critical apps use (tmpfs mounted) FIFO's for IPC; the Linux
> FIFO being one of the fastest known IPC mechanisms.  Each client in the
> JACK (http://jackit.sf.net) graph wakes the next one by writing a single
> byte to a FIFO.  Ardour's GUI, control, and audio threads interact via a
> similar mechanism.  How would you expect this change to impact the inter
> thread wakeup latency?  It's confusing when people say "performance",
> meaning "increased throughput albeit with more latency".  For many
> people that's a regression.

I posted the performance numbers in the thread already, and with every
single throughput number I also talked abotu what the latency difference
was. So quite frankly, if you were confused, I suspect it was because you
didn't read them. Tssk, tssk.

Short and sweet: the latency changes are in the noise for SMP, but can be
seen on UP. I'll look at it a bit more:  since I had to add the coalescing
code anyway, I might also decide to re-use a buffer page rather than free
it immediately, since that may help latency for small writes.

		Linus
