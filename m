Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293135AbSCOTJv>; Fri, 15 Mar 2002 14:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSCOTJl>; Fri, 15 Mar 2002 14:09:41 -0500
Received: from opengraphics.com ([216.208.162.194]:39437 "EHLO
	hurricane.opengraphics.com") by vger.kernel.org with ESMTP
	id <S293135AbSCOTJa>; Fri, 15 Mar 2002 14:09:30 -0500
Date: Fri, 15 Mar 2002 14:02:39 -0500
To: Richard Harman <rharman@xabean.net>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver v6.2.4 "queue abort message" questions
Message-ID: <20020315140239.A22884@opengraphics.com>
In-Reply-To: <200201161601.g0GG1BB27489@xabean.xabean.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201161601.g0GG1BB27489@xabean.xabean.net>
User-Agent: Mutt/1.3.18i
From: Len Sorensen <lsorense@opengraphics.com>
X-Scanner: exiscan *16lwyN-00061A-00*sBt42hKrCzM* (OpenGraphics Corp, Toronto, Canada)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2002 at 11:01:11AM -0500, Richard Harman wrote:
> It's a dual P3 600/100 with 512mb of ram, tyan thunder 100 gx (s1836dulan model) with an onboard aic-7895 dual channel UW SCSI.  I'm booting off channel B (the 68pin only channel) Id 1, which is my seagate 36g SCA drive in a 5 bay sca enclosure.  Id 0 is a ultraplex 40x. Channel A has a 50pin 8x2x20 plexwriter.  The motherboard has a PIIX4 (GX) chipset.  (http://www.tyan.com/products/html/a_thunder100gx.html)
> 
> I've hand copied down what I could of the v6.2.4 driver's debug messages, but wasn't able to catch all of it.  (I hope to switch to serial console as soon as I find a null modem cable and log it that way.)  Shall I send the screenfull to the list or you directly?

I was having this problem as well on an iBM M-Pro P2 450 with the aic7895
onboard (dual channel), while an identical P2 400 did not seem to have
the same problem with the same kernel build.

I think the problem started around 2.4.13 or so.  I can boot from warn
reboot, but not cold reboot.

I just tried applying the aic7xxx 6.2.5 driver patch to replace 6.2.4
that is in 2.4.18, and it actually appears to have removed the problem.
I know the new version asks in the config if you want to probe for
EISA/VLB cards, which I set to no, so either that fixed it (I should
try aic7xxx=no_probe with the other kernel), or something else in the
changes in the code has fixed it.  I personally suspect a marginal timing
issue during init given the 400mhz machine is fine and the 450mhz machine
was not.  Having not read through all the code changes in the patch,
I am not sure.

Len Sorensen
