Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266690AbUAOLjV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 06:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266737AbUAOLjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 06:39:20 -0500
Received: from [160.218.214.150] ([160.218.214.150]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266690AbUAOLip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 06:38:45 -0500
Date: Thu, 15 Jan 2004 12:38:11 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 NFS-server low to 0 performance
Message-ID: <20040115113810.GA9265@elf.ucw.cz>
References: <1073771855.3958.15.camel@nidelv.trondhjem.org> <Pine.LNX.4.44.0401102338270.7120-100000@poirot.grange> <20040111131857.GA11246@hh.idb.hist.no> <20040111135309.F1931@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040111135309.F1931@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The only my doubt was - yes, you upgrade the __server__, so, you look in
> > > Changes, upgrade all necessary stuff, or just upgrade blindly (as does
> > > happen sometimes, I believe) a distribution - and the server works, fine.
> > > What I find non-obvious, is that on updating the server you have to
> > > re-configure __clients__, see? Just think about a network somewhere in a
> > 
> > If you upgrade the server and read "Changes", then a note in changes might
> > say that "you need to configure carefully or some clients could get in trouble."
> > (If the current "Changes" don't have that - post a documentation patch.)
> 
> [This is more to Guennadi than Helge]
> 
> I don't see why such a patch to "Changes" should be necessary.  The
> problem is most definitely with the client hardware, and not the
> server software.
> 
> The crux of this problem comes down to the SMC91C111 having only a
> small on-board packet buffer, which is capable of storing only about
> 4 packets (both TX and RX).  This means that if you receive 8 packets
> with high enough interrupt latency, you _will_ drop some of those
> packets.

I believe problem is in software... basically UDP is broken. I don't
think you can call hw broken just because small RX ring. RX ring has
to have some fixed size, and if the OS is not fast enough, well, some
packets are going on the floor.

I believe SW should deal with RX ring being just one packet big, and
believe that UDP is to blame...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
