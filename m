Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVKGTUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVKGTUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 14:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965053AbVKGTUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 14:20:20 -0500
Received: from ojjektum.uhulinux.hu ([62.112.194.64]:27589 "EHLO
	ojjektum.uhulinux.hu") by vger.kernel.org with ESMTP
	id S964965AbVKGTUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 14:20:19 -0500
Date: Mon, 7 Nov 2005 20:20:15 +0100
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Greg KH <greg@kroah.com>
Cc: rusty@rustcorp.com.au, "Marco d'Itri" <md@Linux.IT>,
       linux-kernel@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: 2.6.14, udev: unknown symbols for ehci_hcd
Message-ID: <20051107192014.GD22737@ojjektum.uhulinux.hu>
References: <436CD1BC.8020102@t-online.de> <20051105162503.GC20686@kroah.com> <436D9BDE.3060404@t-online.de> <20051106215158.GB3603@kroah.com> <20051107113329.GA7632@wonderland.linux.it> <20051107173157.GA16465@kroah.com> <20051107190738.GC22737@ojjektum.uhulinux.hu> <20051107191214.GA20364@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107191214.GA20364@kroah.com>
User-Agent: Mutt/1.5.7i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:12:14AM -0800, Greg KH wrote:
> On Mon, Nov 07, 2005 at 08:07:38PM +0100, Pozsar Balazs wrote:
> > On Mon, Nov 07, 2005 at 09:31:57AM -0800, Greg KH wrote:
> > > On Mon, Nov 07, 2005 at 12:33:29PM +0100, Marco d'Itri wrote:
> > > > On Nov 06, Greg KH <greg@kroah.com> wrote:
> > > > 
> > > > > This seems to be a Debian issue for some odd reason, I suggest filing a
> > > > > bug against the udev package (or just tagging onto the existing bug for
> > > > > this problem, I've seen it in there already...)
> > > > The reason this is usually seen only on Debian systems is that I am the
> > > > first one who shipped an udev package which runs many parallel modprobe
> > > > commands, but this is a genuine kernel/modprobe bug.
> > > 
> > > I'm pretty sure OpenSuSE 10.0 does the same thing, and I don't think
> > > anyone has reported the same kind of bugs there.  Makes me wonder what
> > > is really happening here...
> > 
> > If module A depends on module B, and "modprobe A" and "modprobe B" are 
> > run parallel
> 
> Why would they be run in parallel?  modprobe doesn't do this, why would
> you?

On my machine it happened while loading pcmcia modules. It was two 
modprobes running in parallel (invoked by udev), not 1 modprobe loading 
modules in parallel.

> > , there is time window when module B is already listed in 
> > /proc/modules, but not completely loaded/initialized, it is in the state 
> > "Loading". At this point "modprobe A" checks /proc/modules if module B 
> > is already loaded, but it does not take into account that it is in the 
> > state "Loading" and not yet "Live". So it tries to load module A, but it 
> > fails, because there are missing symbols because module A did not 
> > register them yet.
> 
> Sounds like a locking issue within the module core.  I thought we could
> only load one at a time, otherwise we have other races within the
> kernel.

That's what I thought too, but this is not the case it seems.


-- 
pozsy
