Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWJMUsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWJMUsz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbWJMUsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:48:55 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48337 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751887AbWJMUsy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:48:54 -0400
Date: Fri, 13 Oct 2006 22:48:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Adam Belay <abelay@MIT.EDU>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] Bug in PCI core
Message-ID: <20061013204843.GA2542@elf.ucw.cz>
References: <1160729427.26091.98.camel@localhost.localdomain> <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0610131024340.6460-100000@iolanthe.rowland.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The PCI configuration space cache was originally introduced to support
> > power management.  However, it's mostly incorrect, as it unnecessarily
> > stores the values of read only registers (and even BIST which is
> > potentially dangerous).  A while back I posted a series of patches that
> > address this issue, and the net result was that the config cache stays
> > around wasting memory because of the pci_block_user_cfg_access()
> > dependency despite being useless to PCI PM.
> > 
> > I'd like to propose that we have the pci config sysfs interface return
> > -EIO  when it's blocked (e.g. active BIST or D3cold).  This accurately
> > reflects the state of the device to userspace, reduces complexity, and
> > could potentially save some memory per PCI device instance.
> 
> Could you resubmit your old patches and include a corresponding fix for 
> this access problem?
> 
> BTW, is it possible for userspace to try accessing a device in D3cold?  
> Doesn't the fact that it is D3cold rather than D3hot mean the computer is 
> turned off?  Or have I been missing out on new developments?

I'm not sure about D3cold vs. D3hot... IIRC D3hot means that it is
possible to wake up the system, while D3cold means slot is completely
powered down.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
