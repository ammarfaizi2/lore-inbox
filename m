Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbTALW4S>; Sun, 12 Jan 2003 17:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267618AbTALW4S>; Sun, 12 Jan 2003 17:56:18 -0500
Received: from almesberger.net ([63.105.73.239]:21510 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267612AbTALW4O>; Sun, 12 Jan 2003 17:56:14 -0500
Date: Sun, 12 Jan 2003 20:04:48 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: uaca@alumni.uv.es,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dveitch@unimelb.edu.au
Subject: Re: How much we can trust packet timestamping
Message-ID: <20030112200448.G1516@almesberger.net>
References: <20021230112838.GA928@pusa.informat.uv.es> <1041253743.13097.3.camel@irongate.swansea.linux.org.uk> <20030110190706.A6866@almesberger.net> <1042253032.32431.28.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042253032.32431.28.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sat, Jan 11, 2003 at 02:43:52AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> You run NTP between the host clock and the nic timer.

While NTP is a good synchronization source (frequently the only
affordable one around), I'm not so sure it's such a good tool
for correcting drift. If you have a look at figure 5 in
http://www.cubinlab.ee.mu.oz.au/~darryl/tscclock_final.pdf.gz
you'll see that NTP uses drift to correct for offset errors, so
using NTP directly doesn't yield a clock that remains stable
unless it's constantly getting corrected by NTP.

What should work better is to use NTP only as a reference for
offset, and then calibrate the hardware clock from that.
Particularly the TSC is very stable, so there isn't much drift
to worry about.

But what I'm after is the interface between kernel and user space,
and any kernel-internal interfaces that may be needed. If people
really want to use NTP directly on hardware clocks, I guess my
approach 1) (export everything to user space, and let user space
worry about the details) would then be the appropriately flexible
choice ?

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
