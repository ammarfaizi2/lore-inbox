Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132314AbRAKH5Y>; Thu, 11 Jan 2001 02:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132023AbRAKH5O>; Thu, 11 Jan 2001 02:57:14 -0500
Received: from marine.sonic.net ([208.201.224.37]:52065 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S131513AbRAKH5I>;
	Thu, 11 Jan 2001 02:57:08 -0500
X-envelope-info: <dhinds@sonic.net>
Message-ID: <20010110235648.C390@sonic.net>
Date: Wed, 10 Jan 2001 23:56:49 -0800
From: David Hinds <dhinds@sonic.net>
To: Miles Lane <miles@megapathdsl.net>
Cc: Aaron Eppert <eppertan@rose-hulman.edu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 Patch for 3c575
In-Reply-To: <20010110204420.A7699@rose-hulman.edu> <3A5D20D6.6090906@megapathdsl.net> <20010110201537.F12593@sonic.net> <3A5D5F16.1030707@megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A5D5F16.1030707@megapathdsl.net>; from Miles Lane on Wed, Jan 10, 2001 at 11:21:58PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 11:21:58PM -0800, Miles Lane wrote:
> 
> There are at least two things that need to happen.

...

I think you're not clear on what PCMCIA support is in the 2.4 kernel
tree.  The pcnet_cs driver has been in the kernel tree as long as
anything else.  Most PCMCIA drivers are already in the kernel tree;
the ones that are not are: the memory card drivers (rarely used now),
parport_cs, and wvlan_cs.  The hot plug PCI drivers (3c59x, tulip,
epic100) subsume the 3c575_cb, tulip_cb, and epic_cb drivers
completely.

> 	   For the case where drivers don't exist yet,
> 	   the /etc/pcmcia/config* files could be migrated
> 	   into the kernel tree, so that when a kernel is
> 	   installed that is configured to use the kernel
> 	   drivers instead of pcmcia-cs drivers, then
> 	   install the modified /etc/pcmcia/config* files.

I don't like this idea one bit; multiple sets of config files for
different kernel versions is not workable.  People want to be able to
boot different kernel releases.  I want a way for cardmgr to figure
out on the fly, based on some feedback from the PCMCIA modules, what
the right thing to do is.

> 	   This seems kind of heinous.  But, these
> 	   configuration files sometimes get tweaked for
> 	   a particular machine's hardware configuration,
> 	   so it's important not to lose them.

/etc/pcmcia/config should never be tweaked for anything.  That's what
the config.opts file is for.

> I should note that I once before I modified my /etc/pcmcia/config
> file so that cardmgr loaded 3c59x for my 3c575 card.  I got some
> errors during the card detection phase and I never got "ifup eth0"
> to run automatically when I inserted the card.

Getting "ifup eth0" to run when you insert a CardBus card in the new
2.4 scheme is going to be an issue with the /sbin/hotplug script, and
out of the PCMCIA subsystem's control.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
