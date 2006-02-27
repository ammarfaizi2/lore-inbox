Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751511AbWB0RSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbWB0RSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWB0RSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:18:50 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48871 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751502AbWB0RSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:18:49 -0500
Date: Mon, 27 Feb 2006 09:18:37 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: woho@woho.de
Cc: pomac@vapor.com,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>,
       Jeff Garzik <jeff@garzik.org>, netdev@vger.kernel.org,
       Pavel Volkovitskiy <int@mtx.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert sky2 to 0.13a
Message-ID: <20060227091837.3c214435@localhost.localdomain>
In-Reply-To: <200602271738.38675.woho@woho.de>
References: <4400FC28.1060705@gmx.net>
	<200602270003.46353.woho@woho.de>
	<20060227080042.0cf3f05d@localhost.localdomain>
	<200602271738.38675.woho@woho.de>
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.6; i486-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006 17:38:38 +0100
Wolfgang Hoffmann <woho@woho.de> wrote:

> On Monday 27 February 2006 17:00, Stephen Hemminger wrote:
> > On Mon, 27 Feb 2006 00:03:45 +0100
> >
> > Wolfgang Hoffmann <woho@woho.de> wrote:
> > > > Bisect done:
> > > >
> > > > 4d52b48b43d0d1d5959fa722ee0046e3542e5e1b is first bad commit
> > > >     [PATCH] sky2: support msi interrupt (revised)
> > > >
> > > > Reverting this commit in git head seems to work, at least the driver
> > > > builds and loads. Is that sane?
> > > >
> > > Ok, no hangs yet.
> > >
> > > Looking at the reverted commit, I wonder if modprobing sky2 with
> > > disable_msi=1 is equivalent to reverting the commit?
> >
> > Could you try the current code with the disable_msi option?
> > 	modprobe sky2 disable_msi=1
> >
> > That will run existing code without MSI.
> 
> 2.6.16-rc5 with disable_msi=1 works for me, no hangs seen so far. I rsynced 80 
> GB of data, thats about 5-10 times more than I typically need to reproduce a 
> hang, so it seems to be solid. For the record: 2.6.16-rc5 with disable_msi=0 
> does hang.
> 
> I have not seen the memory trashing others reported, with no version I tested 
> so far. Maybe my scenario is not likely to trigger this, so I can't tell.
> 
> Unless a fix for msi is at hand, may I suggest for 2.6.16 to revert the msi 
> commit or switch the default to disable_msi=1?
> 
> I've updated bugzilla #6084 accordingly.

Okay, then what I need is lspci -v of all systems that have the problem, I'll make
a blacklist (or update PCI quirks). I suspect that MSI doesn't work for any devices
on these systems, or MSI changes the timing enough to expose existing races. 
