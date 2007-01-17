Return-Path: <linux-kernel-owner+w=401wt.eu-S932658AbXAQTWA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbXAQTWA (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 14:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbXAQTWA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 14:22:00 -0500
Received: from mx1.suse.de ([195.135.220.2]:45164 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932658AbXAQTV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 14:21:59 -0500
Date: Wed, 17 Jan 2007 11:21:15 -0800
From: Greg KH <gregkh@suse.de>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: grundler@parisc-linux.org, akpm@osdl.org, greg@kroah.com,
       kaneshige.kenji@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       seto.hidetoshi@jp.fujitsu.com
Subject: Re: patch pci-rework-documentation-pci.txt.patch added to gregkh-2.6 tree
Message-ID: <20070117192114.GB14485@suse.de>
References: <20070116222721.EA942B41673@imap.suse.de> <45ADE7CB.2080701@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45ADE7CB.2080701@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2007 at 10:09:08AM +0059, Jiri Slaby wrote:
> gregkh@suse.de wrote:
> [...]
> > +Tips on when/where to use the above attributes:
> > +	o The module_init()/module_exit() functions (and all
> > +	  initialization functions called _only_ from these)
> > +	  should be marked __init/__exit.
> > +
> > +	o Do not mark the struct pci_driver.
> > +
> > +	o The ID table array should be marked __devinitdata.
> 
> Is that correct? It panics somewehere IIRC?

If it's marked __initdata it can panic if we try to access the data when
adding a new PCI device after the system is up and running (pci hotplug
or dynamic pci ids support.)  That's why it needs to be either no
marking or __devinitdata (which resolves to nothing if CONFIG_HOTPLUG is
enabled.)

thanks,

greg k-h
