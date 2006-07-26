Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbWGZQue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWGZQue (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 12:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWGZQue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 12:50:34 -0400
Received: from ns.suse.de ([195.135.220.2]:36074 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932251AbWGZQud (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 12:50:33 -0400
Date: Wed, 26 Jul 2006 09:46:20 -0700
From: Greg KH <gregkh@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Greg KH <greg@kroah.com>, Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Multi-threaded device probing
Message-ID: <20060726164620.GF9871@suse.de>
References: <20060725203028.GA1270@kroah.com> <44C6B881.7030901@s5r6.in-berlin.de> <20060726073132.GE6249@suse.de> <20060726112948.GA13490@parisc-linux.org> <20060726161647.GA9675@kroah.com> <20060726164235.GH22822@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726164235.GH22822@parisc-linux.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 10:42:36AM -0600, Matthew Wilcox wrote:
> On Wed, Jul 26, 2006 at 09:16:47AM -0700, Greg KH wrote:
> > > I still think we need a method of renaming block devices, but haven't
> > > looked into it in enough detail yet.
> > 
> > That could get "interesting"...
> > 
> > But now that we all are using /dev/disk/ and it has persistant device
> > names for block devices, I really don't think it's that big of a deal.
> 
> Actually, that's exactly why it's a big deal.  The kernel spits out
> messages like:
> 
>                 printk(KERN_DEBUG "%s: Mode Sense: %02x %02x %02x %02x\n",
>                        diskname, buffer[0], buffer[1], buffer[2], buffer[3]);
> 
> where diskname is something like sda.  Now the user has to figure out
> what sda means in terms of /dev/disk/ and in terms of scsi h:c:t:l and
> in terms of which sticky label is on which drive.  If we let userspace
> change the gendev's disk_name, that printk can be meaningful to the user
> in at least one of those senses.

No, this comes up all the time.  Userspace has at least 3 different
mappings to /dev/sda in /dev/disk right now.  Which one do you want the
kernel to use?:

	$ tree /dev/disk/ | grep sda1
	|   |-- scsi-SATA_Maxtor_7L250S0_L59FRPQH_L59FRPQH-part1 -> ../../sda1
	|   |-- boot -> ../../sda1
	    `-- 9c0ef40c-6de9-46f6-ac79-32296c667cf1 -> ../../sda1

Userspace should be doing the reverse mapping if it wants to, the kernel
should not care about this at all.

thanks,

greg k-h
