Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936132AbWK3CSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936132AbWK3CSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 21:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936130AbWK3CSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 21:18:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:32955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S936127AbWK3CSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 21:18:32 -0500
Date: Wed, 29 Nov 2006 18:18:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, tulip-users@lists.sourceforge.net,
       netdev@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       Valerie Henson <val_henson@linux.intel.com>
Subject: Re: 2.6.19-rc6-mm2: uli526x only works after reload
Message-Id: <20061129181809.c55da5e8.akpm@osdl.org>
In-Reply-To: <200611300204.16507.rjw@sisk.pl>
References: <20061128020246.47e481eb.akpm@osdl.org>
	<200611300008.21434.rjw@sisk.pl>
	<20061129152619.0d1ac361.akpm@osdl.org>
	<200611300204.16507.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 02:04:15 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> > > 
> > > git-netdev-all.patch
> > > git-netdev-all-fixup.patch
> > > libphy-dont-do-that.patch
> > 
> > Are you able to eliminate libphy-dont-do-that.patch?
> > 
> > > Is a broken-out version of git-netdev-all.patch available from somewhere?
> > 
> > Nope, and my few fumbling attempts to generate the sort of patch series
> > which you want didn't work out too well.  One has to downgrade to
> > git-bisect :(
> > 
> > What does "doesn't work" mean, btw?
> 
> Well, it turns out not to be 100% reproducible.  I can only reproduce it after
> a soft reboot (eg. shutdown -r now).
> 
> Then, while configuring network interfaces the system says the interface name
> is ethxx0, but it should be eth1 (eth0 is an RTL-8139, which is not used).  Now
> if I run ifconfig, it says:
> 
> eth0: error fetching interface information: Device not found
> 
> and that's all (normally, ifconfig would show the information for lo and eth1,
> without eth0).  Moreover, 'ifconfig eth1' says:
> 
> eth1: error fetching interface information: Device not found
> 
> Next, I run 'rmmod uli526x' and 'modprobe uli526x' and then 'ifconfig' is
> still saying the above (about eth0), but 'ifconfig eth1' seems to work as
> it should.  However, the interface often fails to transfer anything after
> that.

Lovely.  Sounds like some startup race, perhaps against userspace.

Is CONFIG_PCI_MULTITHREAD_PROBE set?  (err, we meant to disable that for
2.6.19 but forgot).

