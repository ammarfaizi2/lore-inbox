Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbVJBXOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbVJBXOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 19:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751075AbVJBXOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 19:14:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:41367 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751073AbVJBXOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 19:14:24 -0400
Subject: Re: thinkpad suspend to ram and backlight
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@suse.cz>
Cc: Jan Spitalnik <lkml@spitalnik.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de
In-Reply-To: <20051002182354.GA2031@elf.ucw.cz>
References: <20051002175703.GA3141@elf.ucw.cz>
	 <200510022007.29660.lkml@spitalnik.net>  <20051002182354.GA2031@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 03 Oct 2005 09:11:14 +1000
Message-Id: <1128294674.8267.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-02 at 20:23 +0200, Pavel Machek wrote:
> Hi!
> 
> > > When I suspend to RAM on x32, backlight is not turned off. (And, IIRC,
> > > video chips is not turned off, too). Unfortunately, backlight is not
> > > turned even when lid is closed. I know some patches were floating
> > > around to solve that... but I can't find them now. Any ideas?
> > 
> > if your thinkpad has ati radeon, you can use this:
> > 
> > http://www.thinkwiki.org/wiki/Radeontool
> 
> radeontool light off before suspend indeed works, but I'd like to
> solve it properly.

Well, it depends what you call "properly". There are indeed some patches
floating around that put the radeon chip in D2 state, that seem to help.
The problem is that the actual backlight control is a bit dodgy. That
is, some laptops use a separate chip from the radeon, some use the
radeon but have an inverted backlight signal, etc... and radeonfb
doesn't quite know how to deal with those cases (it has some hard coded
lists of machines with infos on how to deal with them for ppc).

Just dig around the list for the thinkpad suspend patches. I'm not 100%
sure they are correct yet though, but I suppose I should give them
another review and eventually merge them one of these days.

Ben.


