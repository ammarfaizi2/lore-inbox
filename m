Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281019AbRKOTi7>; Thu, 15 Nov 2001 14:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281015AbRKOTit>; Thu, 15 Nov 2001 14:38:49 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:32760 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281012AbRKOTil>; Thu, 15 Nov 2001 14:38:41 -0500
Date: Thu, 15 Nov 2001 19:37:17 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Matt Bernstein <matt@theBachChoir.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
        linux-kernel@vger.kernel.org, Stephen Tweedie <sct@redhat.com>
Subject: Re: Athlon SMP blues - kernels 2.4.[9 13 15-pre4]
Message-ID: <20011115193717.B14221@redhat.com>
In-Reply-To: <3BF285D7.8F5AAB6E@redhat.com> <Pine.LNX.4.33.0111141502110.8473-100000@nick.dcs.qmul.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111141502110.8473-100000@nick.dcs.qmul.ac.uk>; from matt@theBachChoir.org.uk on Wed, Nov 14, 2001 at 03:08:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 14, 2001 at 03:08:25PM +0000, Matt Bernstein wrote:

> I hope they do; I've just set up a very similar beast (looks like the same
> mobo and same CPUs). Is the RAM "registered" ECC? Are your CPUs the same
> stepping? One problem we were bitten by was the Radeon DRI, so we disabled
> it (in XF86Config-4) and it now seems to at least boot into X.

There are known problems in AMD760+Radeon setups, and a workaround is
to avoid asserting RADEON_SOFT_RESET_HBP during init.  The latest
kernels have that fix in the radeon drm.  Using that in conjunction
with an X server containing the same fix, I've finally got a stable
761+radeon setup here.

I think the X server fix went in on the 4.1.99 branch, but I know that
at least the Red Hat XFree86-4.1 rpms have got the patch back-ported.

> it's not any faster than a dual PIII (1GHz) at the task it's meant to
> perform :( both CPUs report 75% usage, and vmstat 1 doesn't show the IO
> systems being slugged. Very strange. We're wondering if we've hit memory
> bandwidth as the tasks involve some hard sums with big matrices.

If the CPUs were bottlenecked on memory then they would still be
pegged at 100% according to the OS.  They'd just get less work done in
a given interval.

Cheers,
 Stephen
