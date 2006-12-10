Return-Path: <linux-kernel-owner+w=401wt.eu-S1759218AbWLJXr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759218AbWLJXr0 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 18:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760247AbWLJXrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 18:47:25 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1429 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1759218AbWLJXrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 18:47:25 -0500
Date: Mon, 11 Dec 2006 00:47:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Chris Wedgwood <cw@f00f.org>, Daniel Drake <dsd@gentoo.org>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@redhat.com>
Subject: Re: RFC: PCI quirks update for 2.6.16
Message-ID: <20061210234733.GH10351@stusta.de>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org> <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de> <457C345D.8030305@gentoo.org> <20061210223351.GA22878@tuatara.stupidest.org> <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 02:39:37PM -0800, Linus Torvalds wrote:
> 
> On Sun, 10 Dec 2006, Chris Wedgwood wrote:
> > 
> > > If I remember right, it breaks Chris Wedgwood's box
> > 
> > I'm not bothered about 2.6.16.x anymore, feel free to do whatever is
> > needed there.
> 
> That's really not the point.
> 
> What's the whole _reason_ for 2.6.x.y releases?
> 
> They should be safe, and OBVIOUS. 
> 
> If there is a box that breaks with a 2.6.x.y release, then that .y release 
> was clearly a mistake, and fundamentally broke the whole point of the 
> stable tree. If you can't depend on the stable tree being a real 
> improvement - regardless of what hw you are on - then the stable tree has 
> lost all meaning, and you'd be better off just getting 2.6.x+1 instead.

If life was that easy...  ;-)

The problem is that the fix for Chris' issue went into the -stable 
2.6.16.17.

So we have the following situation:
- 2.6.16    - 2.6.16.16 : problems for Chris
                          (and possibly many other people)
- 2.6.16.17 - 2.6.16.35 : problems for many other people
                          (I remember 4-5 bug reports in the kernel
                           Bugzilla alone)

The fix in 2.6.19 was considered suboptimal, and Alan's patch for fixing 
this whole issue more properly is currently not even in your tree. 

Looking at the patch description of the patch that was merged into 
2.6.16.17 I got the wrong impression this was a non-critical issue on 
Chris' machine, and the patch could therefore be reverted.

Now it seems the best choice is to:
- go back to the 2.6.16.35 code and
- apply commit 1ae4f9ba84b94b85d995a6ae0064b869ff15b080 from your tree
  that went into 2.6.18 and fixes breakage for at least some devices and
- to perhaps revisit the situation after 2.6.20 got released
  (but I'm becoming more and more inclined to fix the 2.6.16.17
   regression by adding more devices to the quirk if required)

> 		Linus

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

