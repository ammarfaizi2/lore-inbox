Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVAMS3D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVAMS3D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:29:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVAMSWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:22:44 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:31127 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261430AbVAMSSy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:18:54 -0500
Date: Thu, 13 Jan 2005 10:18:50 -0800
From: Greg KH <greg@kroah.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] release_pcibus_dev() crash
Message-ID: <20050113181850.GA24952@kroah.com>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com> <200501121655.42947.jbarnes@engr.sgi.com> <1105636311.30960.8.camel@sinatra.austin.ibm.com> <200501130933.59041.jbarnes@engr.sgi.com> <1105638551.30960.16.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105638551.30960.16.camel@sinatra.austin.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 11:49:11AM -0600, John Rose wrote:
> > Maybe, did you read Documentation/filesystems/sysfs-pci.c?  You need to do 
> > more than just enable HAVE_PCI_LEGACY, you also need to implement some 
> > functions.
> 
> This sounds like more than I bargained for.  I'll leave the patch as-is,
> since I don't currently have the means to test a fix for the legacy IO
> stuff.  Also because it doesn't crash on my architecture :)
> 
> If you get some time, my suggestion is to scrap
> pci_remove_legacy_files(), and free the pci_bus->legacy_io field in
> pci_remove_bus().  The binary sysfs files will be cleaned up
> automatically as the class device is deleted, as described in the
> parent.

No, don't rely on this please.  Explicitly clean up the files, it's
nicer that way, and when sysfs changes to not clean them up for you, it
will be less changes then.

thanks,

greg k-h
