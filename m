Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265305AbUGDBPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265305AbUGDBPI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 21:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265306AbUGDBPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 21:15:08 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:20616 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S265305AbUGDBPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 21:15:02 -0400
Date: Sun, 4 Jul 2004 03:15:01 +0200
From: bert hubert <ahu@ds9a.nl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: small perfctr bug or misunderstanding
Message-ID: <20040704011501.GA28252@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
References: <200407031458.i63EwAGO023123@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407031458.i63EwAGO023123@harpo.it.uu.se>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 04:58:10PM +0200, Mikael Pettersson wrote:
> Currently no; I removed them while we've been debating the
> API to the (IMO more important) per-process counters.
> I intend to add them back once the current stuff has been
> Linus-approved.

Ok - I'd love the ability to diagnose an entire system. Furthermore, it'd be
very cool if it were possible to profile another process, like strace -p
pid.

I think this means looking at 'virtual counters' for arbitrary processes.
Would this be possible?

I currently have a client using a 2.6.7 kernel and they have performance
problems and applications I can't recompile. It'd be very good if I could
spot which of their many application is thrashing the cache.

> The driver sees ENABLE set in EVNTSEL1 on your P-M,
> and properly returns an error.

Ahhhh, I see. With this line things work as intended:
d_control.cpu_control.evntsel[count] = v | (1 << 16) | (!count << 22) | (unit << 8); 

> handle any quirks. For P6 vs K7 the differences are
> minor, but to program the P4 you _really_ need helper
> procedures.

Indeed. Thanks. I'll make a P6PerfCtr and an AMDPerfCtr and a P4PerfCtr. The
pentium 1/2 people can work it out for themselves :-)

Regards,

bert

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
