Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967785AbWK3BIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967785AbWK3BIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967784AbWK3BIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:08:55 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:28365 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S967782AbWK3BIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:08:53 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2: uli526x only works after reload
Date: Thu, 30 Nov 2006 02:04:15 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, tulip-users@lists.sourceforge.net,
       netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       Valerie Henson <val_henson@linux.intel.com>
References: <20061128020246.47e481eb.akpm@osdl.org> <200611300008.21434.rjw@sisk.pl> <20061129152619.0d1ac361.akpm@osdl.org>
In-Reply-To: <20061129152619.0d1ac361.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611300204.16507.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 30 November 2006 00:26, Andrew Morton wrote:
> On Thu, 30 Nov 2006 00:08:21 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Wednesday, 29 November 2006 22:31, Rafael J. Wysocki wrote:
> > > On Wednesday, 29 November 2006 22:30, Andrew Morton wrote:
> > > > On Wed, 29 Nov 2006 21:08:00 +0100
> > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > 
> > > > > On Wednesday, 29 November 2006 20:54, Rafael J. Wysocki wrote:
> > > > > > On Tuesday, 28 November 2006 11:02, Andrew Morton wrote:
> > > > > > > 
> > > > > > > Temporarily at
> > > > > > > 
> > > > > > > http://userweb.kernel.org/~akpm/2.6.19-rc6-mm2/
> > > > > > > 
> > > > > > > Will appear eventually at
> > > > > > > 
> > > > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc6/2.6.19-rc6-mm2/
> > > > > > 
> > > > > > A minor issue: on one of my (x86-64) test boxes the uli526x driver doesn't
> > > > > > work when it's first loaded.  I have to rmmod and modprobe it to make it work.
> > > > 
> > > > That isn't a minor issue.
> > > > 
> > > > > > It worked just fine on -mm1, so something must have happened to it recently.
> > > > > 
> > > > > Sorry, I was wrong.  The driver doesn't work at all, even after reload.
> > > > > 
> > > > 
> > > > tulip-dmfe-carrier-detection-fix.patch was added in rc6-mm2.  But you're
> > > > not using that (corrent?)
> > > > 
> > > > git-netdev-all changes drivers/net/tulip/de2104x.c, but you're not using
> > > > that either.
> > > > 
> > > > git-powerpc(!) alters drivers/net/tulip/de4x5.c, but you're not using that.
> > > > 
> > > > Beats me, sorry.  Perhaps it's due to changes in networking core.  It's
> > > > presumably a showstopper for statically-linked-uli526x users.  If you could
> > > > bisect it, please?  I'd start with git-netdev-all, then tulip-*.
> > > 
> > > OK, but it'll take some time.
> > 
> > OK, done.
> > 
> > It's one of these (the first one alone doesn't compile):
> > 
> > git-netdev-all.patch
> > git-netdev-all-fixup.patch
> > libphy-dont-do-that.patch
> 
> Are you able to eliminate libphy-dont-do-that.patch?
> 
> > Is a broken-out version of git-netdev-all.patch available from somewhere?
> 
> Nope, and my few fumbling attempts to generate the sort of patch series
> which you want didn't work out too well.  One has to downgrade to
> git-bisect :(
> 
> What does "doesn't work" mean, btw?

Well, it turns out not to be 100% reproducible.  I can only reproduce it after
a soft reboot (eg. shutdown -r now).

Then, while configuring network interfaces the system says the interface name
is ethxx0, but it should be eth1 (eth0 is an RTL-8139, which is not used).  Now
if I run ifconfig, it says:

eth0: error fetching interface information: Device not found

and that's all (normally, ifconfig would show the information for lo and eth1,
without eth0).  Moreover, 'ifconfig eth1' says:

eth1: error fetching interface information: Device not found

Next, I run 'rmmod uli526x' and 'modprobe uli526x' and then 'ifconfig' is
still saying the above (about eth0), but 'ifconfig eth1' seems to work as
it should.  However, the interface often fails to transfer anything after
that.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
