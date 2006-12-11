Return-Path: <linux-kernel-owner+w=401wt.eu-S1758682AbWLKBVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758682AbWLKBVz (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 20:21:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758878AbWLKBVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 20:21:55 -0500
Received: from smtp.osdl.org ([65.172.181.25]:57179 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758682AbWLKBVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 20:21:54 -0500
Date: Sun, 10 Dec 2006 17:17:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Daniel Drake <dsd@gentoo.org>, Adrian Bunk <bunk@stusta.de>,
       Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>, Jean Delvare <khali@linux-fr.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Brice Goglin <brice@myri.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       Bauke Jan Douma <bjdouma@xs4all.nl>,
       Tomasz Koprowski <tomek@koprowski.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: RFC: PCI quirks update for 2.6.16
In-Reply-To: <20061210224903.GA23643@tuatara.stupidest.org>
Message-ID: <Pine.LNX.4.64.0612101705180.12500@woody.osdl.org>
References: <20061207132430.GF8963@stusta.de> <45782774.8060002@gentoo.org>
 <1165723779.334.3.camel@localhost.localdomain> <20061210160053.GD10351@stusta.de>
 <457C345D.8030305@gentoo.org> <20061210223351.GA22878@tuatara.stupidest.org>
 <Pine.LNX.4.64.0612101438080.12500@woody.osdl.org> <20061210224903.GA23643@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 10 Dec 2006, Chris Wedgwood wrote:
> 
> Well, it's not clear to me that reverting to a quirk the pokes *all*
> VIA pci devices on all machines is safe, it's not even clear if it was
> a good idea to merge this.

I'm just saying that the stable tree should never merge anything that can 
possibly cause a regression. 

> Well, I think the current 2.6.16.x release series is already broken on
> some other subset of hardware.

That's not the point. If it was broken on some subset of hardware, as long 
as it's not a REGRESSION from 2.6.16, that's better than _changing_ the 
breakage. And no, it doesn't really matter how many machines are affected 
(ie it's not better to have a "smaller" set of cases that break, unless 
it's a _strict_ subset).

The reason? It's better to be _dependable_ than to work on a maximum 
number of machines. This is why _regressions_ are always much worse than 
old bugs. It's much better to have "it didn't work before, and it still 
doesn't work" than to have "it used to work, but now it broke".

Because people for whom something used to work should always be able to 
update to a new kernel without having to constantly worry.

So for the _stable_ series, if you don't understand the problem 100%, and 
you don't know that something really fixes something and never causes 
regressions, such a patch simply SHOULD NOT be applied. It's that easy.

(And the argument that it "fixes more than it breaks" is a total garbage 
argument for several reasons:

 - you don't actually know that. You may have a lot of reports about 
   breakage that you think will be fixed (so you _think_ it fixes a lot), 
   but by definition you won't have any clue AT ALL about how much it will 
   break, since nobody will have tested it. The machines that weren't 
   broken before generally won't even bother to upgrade, so you'll find 
   out only much later.

 - machines that didn't use to work well before are much less important 
   than machines that worked fine. People don't _expect_ them to work, 
   people don't have a history of them working. So if you fix ten machines 
   that didn't work before, but you break one that _did_ work before, 
   that's _still_ not actually a good deal. Because angst-wise, you 
   actually lost on it.

So please revert anythign that is even slightly open for debate in the 
stable series. The whole point of the stable series is to be _stable_, and 
regressions are bad.

			Linus
