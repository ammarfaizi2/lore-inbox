Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUHAAjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUHAAjk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbUHAAjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:39:40 -0400
Received: from the-village.bc.nu ([81.2.110.252]:13739 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264045AbUHAAjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:39:36 -0400
Subject: Re: [Unichrome-devel] Dragging window in
	X	causes	soundcard	interrupts to be lost
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091319939.20819.67.camel@mindpipe>
References: <1089952196.25689.7.camel@mindpipe>
	 <40F78D21.10305@shipmail.org>  <40F793C1.2080908@shipmail.org>
	 <1090001316.27995.3.camel@mindpipe>  <40F8298E.8080508@shipmail.org>
	 <1090010147.30435.2.camel@mindpipe> <1090107507.10795.1.camel@mindpipe>
	 <40FA3AEC.9050906@shipmail.org> <1090190244.22282.8.camel@mindpipe>
	 <40FB0092.3070800@shipmail.org>  <1091319939.20819.67.camel@mindpipe>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091317027.7443.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 01 Aug 2004 00:37:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-01 at 01:25, Lee Revell wrote:
> Do you have the original driver source from VIA handy?  This is looking
> more and more like a hardware bug - 2D acceleration engine activity
> causes interrupts from the PCI slot to be disabled for long periods. 

I do. There is no code in the 2D engine that touches interrupt control
at all. 

> Maybe it disables interrupts to prevent other processes writing to the
> shared video/system RAM as it DMAs.  I would like to verify that the
> problem still occurs with their driver, before I try to convince them
> there's a hardware issue with the EPIA boards.

A similar problem occurs with some other chips when you write enough
data to the chip that the FIFO fills and the PCI bus locks until the
write can complete. Various vendors implemented this at one point for
benchmarketing reasons and that would have a similar effect if so.

The 2D driver source is essentially the same as the source in Xorg CVS
barring cleanups and the accelerator code has not changed at all. You
might want to take a look at the fifo management side of things in that
code.

> On that note, assuming I verify the bug, does anyone have any
> recommendations for getting VIA to take me seriously?  The problem is
> very easy to reproduce.

I have some contact with VIA however you need to understand that the
graphics world moves rapidly. I would be suprised if the CLE266 saw any
more development given the CN400 has been demoed, although I certainly
can't speak for VIA on this matter.

Alan


