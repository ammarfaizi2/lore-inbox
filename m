Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVETR5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVETR5W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 13:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261525AbVETR5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 13:57:22 -0400
Received: from soundwarez.org ([217.160.171.123]:47577 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S261522AbVETR47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 13:56:59 -0400
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
From: Kay Sievers <kay.sievers@vrfy.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050520171808.GM3771@smtp.west.cox.net>
References: <20050519164323.GK3771@smtp.west.cox.net>
	 <1116573175.7647.4.camel@dhcp-188.off.vrfy.org>
	 <20050520171808.GM3771@smtp.west.cox.net>
Content-Type: text/plain
Date: Fri, 20 May 2005 19:56:42 +0200
Message-Id: <1116611802.12975.19.camel@dhcp-188>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-20 at 10:18 -0700, Tom Rini wrote:
> On Fri, May 20, 2005 at 09:12:55AM +0200, Kay Sievers wrote:
> > On Thu, 2005-05-19 at 09:43 -0700, Tom Rini wrote:
> > > If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
> > > not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.
> > > 
> > > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> > > 
> > > Index: lib/kobject_uevent.c
> > > ===================================================================
> > > --- c7d7a187a2125518e655dfeadffd38156239ffc3/lib/kobject_uevent.c  (mode:100644)
> > > +++ uncommitted/lib/kobject_uevent.c  (mode:100644)
> > > @@ -21,6 +21,7 @@
> > >  #include <linux/string.h>
> > >  #include <linux/kobject_uevent.h>
> > >  #include <linux/kobject.h>
> > > +#include <linux/module.h>
> > >  #include <net/sock.h>
> > >  
> > >  #define BUFFER_SIZE	1024	/* buffer for the hotplug env */
> > > @@ -178,6 +179,7 @@
> > >  
> > >  #ifdef CONFIG_HOTPLUG
> > >  char hotplug_path[HOTPLUG_PATH_LEN] = "/sbin/hotplug";
> > > +EXPORT_SYMBOL(hotplug_path);
> > >  u64 hotplug_seqnum;
> > >  static DEFINE_SPINLOCK(sequence_lock);
> > 
> > Please don't export it again. We're on the way to make it private.
> > Nobody should ever have access to it outside of the driver core. The
> > input layer event stuff is completely broken and we are already working
> > on fixing this to use the driver core instead of calling /sbin/hotplug,
> > which is completely nonsense these days.
> 
> So Greg said he's ACK this since the "make it private" stuff isn't done
> yet.  Will this go in or no?

Well, it doesn't depend on "make it private" it depends on Dimitry, who
wanted to tweak our patch for the input layer. But we wait for weeeks
for that. The SUSE kernel already ships a driver-core input layer
without the /sbin/hotplug stuff.

Kay

