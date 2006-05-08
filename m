Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWEHOK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWEHOK2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 10:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWEHOK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 10:10:27 -0400
Received: from waste.org ([64.81.244.121]:20151 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751266AbWEHOK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 10:10:27 -0400
Date: Mon, 8 May 2006 09:05:00 -0500
From: Matt Mackall <mpm@selenic.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: pavel@suse.cz, tytso@mit.edu, mrmacman_g4@mac.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/14] random: Remove SA_SAMPLE_RANDOM from network drivers
Message-ID: <20060508140500.GZ15445@waste.org>
References: <20060506.170810.74552888.davem@davemloft.net> <20060507045920.GH15445@waste.org> <20060508062604.GD5765@ucw.cz> <20060508.000754.06312852.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060508.000754.06312852.davem@davemloft.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 12:07:54AM -0700, David S. Miller wrote:
> From: Pavel Machek <pavel@suse.cz>
> Date: Mon, 8 May 2006 06:26:05 +0000
> 
> > > Then I'll run my test on one of the various arches where HZ=~100 and
> > > we don't have a TSC. Like Sparc?
> > > 
> > >   /* XXX Maybe do something better at some point... -DaveM */
> > >   typedef unsigned long cycles_t;
> > >   #define get_cycles()    (0)
> > 
> > Seems like sparc32 is broken :-(, and probably broken terminally...
> > there are very little randomness sources that can handle 10msec
> > sampling period :-(.
> > 
> > Maybe we should disable /dev/random on sparc32?
> 
> What do other platforms without a TSC do?

Using get_cycles() for /dev/random is new as of 2.6. Before that, we
were directly calling rdtsc on x86 alone. 10msec resolution is fine
for plenty of sources.

>From a brief glance, the following don't have a useful get_cycles:

v850, sh, sh64, h8300, m32r, arm, arm26, cris, frv, um, m68k, xtensa,
sparc

And several others like mips (and x86) have one on only some hardware.

-- 
Mathematics is the supreme nostalgia of our time.
