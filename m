Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUHAA4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUHAA4N (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 20:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUHAA4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 20:56:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:31414 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264299AbUHAA4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 20:56:06 -0400
Subject: Re: [Unichrome-devel] Dragging window in
	X	causes	soundcard	interrupts to be lost
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1091317027.7443.29.camel@localhost.localdomain>
References: <1089952196.25689.7.camel@mindpipe>
	 <40F78D21.10305@shipmail.org>  <40F793C1.2080908@shipmail.org>
	 <1090001316.27995.3.camel@mindpipe>  <40F8298E.8080508@shipmail.org>
	 <1090010147.30435.2.camel@mindpipe> <1090107507.10795.1.camel@mindpipe>
	 <40FA3AEC.9050906@shipmail.org> <1090190244.22282.8.camel@mindpipe>
	 <40FB0092.3070800@shipmail.org>  <1091319939.20819.67.camel@mindpipe>
	 <1091317027.7443.29.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1091321794.20819.96.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 31 Jul 2004 20:56:35 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-31 at 19:37, Alan Cox wrote:
> On Sul, 2004-08-01 at 01:25, Lee Revell wrote:
> > Do you have the original driver source from VIA handy?  This is looking
> > more and more like a hardware bug - 2D acceleration engine activity
> > causes interrupts from the PCI slot to be disabled for long periods. 
> 
> I do. There is no code in the 2D engine that touches interrupt control
> at all. 
> 

Yes, I saw that.  This basically means it has to be a hardware bug,
correct?

> > Maybe it disables interrupts to prevent other processes writing to the
> > shared video/system RAM as it DMAs.  I would like to verify that the
> > problem still occurs with their driver, before I try to convince them
> > there's a hardware issue with the EPIA boards.
> 
> A similar problem occurs with some other chips when you write enough
> data to the chip that the FIFO fills and the PCI bus locks until the
> write can complete. Various vendors implemented this at one point for
> benchmarketing reasons and that would have a similar effect if so.
> 

This was the first thing that occurred to me, but I am not really a
video driver expert, and looking at the code it's just banging bits.  I
have hacked device drivers, just not video, and I don't have the
bandwidth to learn right now.

> The 2D driver source is essentially the same as the source in Xorg CVS
> barring cleanups and the accelerator code has not changed at all. You
> might want to take a look at the fifo management side of things in that
> code.
> 
> > On that note, assuming I verify the bug, does anyone have any
> > recommendations for getting VIA to take me seriously?  The problem is
> > very easy to reproduce.
> 
> I have some contact with VIA however you need to understand that the
> graphics world moves rapidly. I would be suprised if the CLE266 saw any
> more development given the CN400 has been demoed, although I certainly
> can't speak for VIA on this matter.
> 

Yes, I would be happy to just get an acknowledgement of the issue. 
Actually I don't even need that, I just want to know if it's fixed in
the newer ones.  I have a perfectly acceptable workaround.  The 2D
acceleration is pretty shoddy anyway, many things seem to work better
with NoAccel.   I still love the EPIA board.

Maybe you could forward this on to them?  Off the record is fine.

Lee

