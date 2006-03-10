Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWCJHhF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWCJHhF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 02:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbWCJHhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 02:37:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:57830 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750785AbWCJHhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 02:37:03 -0500
Subject: Re: [PATCH] EDAC: core EDAC support code
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Peterson <dsp@llnl.gov>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com,
       gregkh@kroah.com, Doug Thompson <dthompson@lnxi.com>,
       bluesmoke-devel@lists.sourceforge.net
In-Reply-To: <200603091746.51686.dsp@llnl.gov>
References: <200601190414.k0J4EZCV021775@hera.kernel.org>
	 <200603091551.25097.dsp@llnl.gov> <20060310000227.GA30236@kroah.com>
	 <200603091746.51686.dsp@llnl.gov>
Content-Type: text/plain
Date: Fri, 10 Mar 2006 08:36:58 +0100
Message-Id: <1141976218.2876.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 17:46 -0800, Dave Peterson wrote:
> > >     Issue #3
> > >     --------
> > >     I am unclear about what to do here.  If the list contents were
> > >     read-only, it would be relatively easy to make
> > >     /sys/devices/system/edac/pci/pci_parity_whitelist into a directory
> > >     containing symlinks, one for each device.  However, the user is
> > >     supposed to be able to modify the list contents.  This would imply
> > >     that the user creates and destroys symlinks.  Does sysfs currently
> > >     support this sort of behavior?  If not, what is the preferred
> > >     means for implementing a user-modifiable set of values?
> >
> > No it doesn't.  How big can this list get?
> 
> It depends on how many PCI devices in your machine you wish to
> blacklist or whitelist.  The motivation for this feature is that
> certain known badly-designed devices report an endless stream of
> spurious PCI bus parity errors.  We want to skip such devices when
> checking for PCI bus parity errors.

ok so this is actually a per pci device property!
I would suggest moving this property to the pci device itself, not doing
it inside an edac directory.

by doing that you get the advantage that 1) it's a more logical place,
and 2) users can do it even for 1 of 2 cards, if they have 2 cards of
the same make and 3) you can use the generic kernel quirk interface for
this and 4) drivers can in principle control this for their hardware in
complex cases 

I understand that on a PC, EDAC is the only user. but ppc has a similar
mechanism I suspect, and they more than likely would be able to share
this property....

