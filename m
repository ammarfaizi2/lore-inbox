Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031708AbWLABVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031708AbWLABVF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 20:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031707AbWLABVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 20:21:04 -0500
Received: from mx1.suse.de ([195.135.220.2]:230 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031704AbWLABVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 20:21:01 -0500
Date: Thu, 30 Nov 2006 17:20:49 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       tulip-users@lists.sourceforge.net, netdev@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>,
       Valerie Henson <val_henson@linux.intel.com>
Subject: Re: 2.6.19-rc6-mm2: uli526x only works after reload
Message-ID: <20061201012049.GA20352@kroah.com>
References: <20061128020246.47e481eb.akpm@osdl.org> <200611300008.21434.rjw@sisk.pl> <20061129152619.0d1ac361.akpm@osdl.org> <200611300204.16507.rjw@sisk.pl> <20061129181809.c55da5e8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061129181809.c55da5e8.akpm@osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 06:18:09PM -0800, Andrew Morton wrote:
> On Thu, 30 Nov 2006 02:04:15 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > > > 
> > > > git-netdev-all.patch
> > > > git-netdev-all-fixup.patch
> > > > libphy-dont-do-that.patch
> > > 
> > > Are you able to eliminate libphy-dont-do-that.patch?
> > > 
> > > > Is a broken-out version of git-netdev-all.patch available from somewhere?
> > > 
> > > Nope, and my few fumbling attempts to generate the sort of patch series
> > > which you want didn't work out too well.  One has to downgrade to
> > > git-bisect :(
> > > 
> > > What does "doesn't work" mean, btw?
> > 
> > Well, it turns out not to be 100% reproducible.  I can only reproduce it after
> > a soft reboot (eg. shutdown -r now).
> > 
> > Then, while configuring network interfaces the system says the interface name
> > is ethxx0, but it should be eth1 (eth0 is an RTL-8139, which is not used).  Now
> > if I run ifconfig, it says:
> > 
> > eth0: error fetching interface information: Device not found
> > 
> > and that's all (normally, ifconfig would show the information for lo and eth1,
> > without eth0).  Moreover, 'ifconfig eth1' says:
> > 
> > eth1: error fetching interface information: Device not found
> > 
> > Next, I run 'rmmod uli526x' and 'modprobe uli526x' and then 'ifconfig' is
> > still saying the above (about eth0), but 'ifconfig eth1' seems to work as
> > it should.  However, the interface often fails to transfer anything after
> > that.
> 
> Lovely.  Sounds like some startup race, perhaps against userspace.
> 
> Is CONFIG_PCI_MULTITHREAD_PROBE set?  (err, we meant to disable that for
> 2.6.19 but forgot).

No, I disabled it for 2.6.19, -mm turns it back on :)

thanks,

greg k-h
