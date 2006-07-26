Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751695AbWGZQmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751695AbWGZQmh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751690AbWGZQmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:42:37 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:37834 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1751695AbWGZQmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:42:36 -0400
Date: Wed, 26 Jul 2006 10:42:36 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@suse.de>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726164235.GH22822@parisc-linux.org>
References: <20060725203028.GA1270@kroah.com> <44C6B881.7030901@s5r6.in-berlin.de> <20060726073132.GE6249@suse.de> <20060726112948.GA13490@parisc-linux.org> <20060726161647.GA9675@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726161647.GA9675@kroah.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 09:16:47AM -0700, Greg KH wrote:
> However, almost all distros now use persistant names for network devices
> due to the PCI Hotplug issue, so it isn't probably as bad as you might
> think.

Oh, for people using a distro, I'm sure it's no problem at all.  It's
the homebrew people I'm worried about ;-)

> > I still think we need a method of renaming block devices, but haven't
> > looked into it in enough detail yet.
> 
> That could get "interesting"...
> 
> But now that we all are using /dev/disk/ and it has persistant device
> names for block devices, I really don't think it's that big of a deal.

Actually, that's exactly why it's a big deal.  The kernel spits out
messages like:

                printk(KERN_DEBUG "%s: Mode Sense: %02x %02x %02x %02x\n",
                       diskname, buffer[0], buffer[1], buffer[2], buffer[3]);

where diskname is something like sda.  Now the user has to figure out
what sda means in terms of /dev/disk/ and in terms of scsi h:c:t:l and
in terms of which sticky label is on which drive.  If we let userspace
change the gendev's disk_name, that printk can be meaningful to the user
in at least one of those senses.

