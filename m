Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030986AbVIIXgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030986AbVIIXgp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 19:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030985AbVIIXgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 19:36:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17620 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030981AbVIIXgo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 19:36:44 -0400
Date: Fri, 9 Sep 2005 16:36:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: gregkh@suse.de, davej@codemonkey.org.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [GIT PATCH] More PCI patches for 2.6.13
Message-Id: <20050909163634.21afe4ca.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
References: <20050909220758.GA29746@kroah.com>
	<Pine.LNX.4.58.0509091535180.3051@g5.osdl.org>
	<20050909225421.GA31433@suse.de>
	<Pine.LNX.4.58.0509091613310.3051@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Fri, 9 Sep 2005, Greg KH wrote:
> > 
> > I fixed up all of the PCI core and USB drivers that were flagged by
> > these warnings already.  Biggest area left is network drivers that I
> > saw.
> 
> The reason I really dislike patches like these is that it causes people to 
> do questionable things.
> 
> For example, there may be perfectly valid reasons why somebody doesn't
> care about the result. I don't see much point in forcing people to check
> the return value of "pci_enable_wake()" for example. There's really no
> real reason to ever care, as far as I can tell - if it fails, there's 
> nothing you can really do about it anyway.
> 
> Also, in general, the fact is that things like "pci_set_power_state()" 
> might fail in _theory_, but we just don't care. A driver that doesn't 
> check the return value is in practice as good a driver as one that does, 
> and forcing people to add code that is totally useless in reality - or 
> look at a warning that is irritating - is just not very productive.
> 
> There are functions where it is really _important_ to check the error 
> return, because they return errors often enough - and the error case is 
> something you have to do something about - that it's good to force people 
> to be aware.
> 
> But "pci_set_power_state()"?
> 
> I don't think so.
> 

If something like a PCI power management function fails then it will likely
cause suspend or resume to malfunction, and we have a lot of such problems.

So we-the-developers do need to hear about it when such functions fail.  So
either a) each and every driver has to blurt a printk (dumb) or b) we stick
a warning and a backtrace in the failing function (better).
