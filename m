Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVAMSlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVAMSlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbVAMSdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:33:32 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:24001 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261246AbVAMSVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:21:43 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] release_pcibus_dev() crash
Date: Thu, 13 Jan 2005 10:21:19 -0800
User-Agent: KMail/1.7.1
Cc: John Rose <johnrose@austin.ibm.com>, lkml <linux-kernel@vger.kernel.org>
References: <1105576756.8062.17.camel@sinatra.austin.ibm.com> <1105638551.30960.16.camel@sinatra.austin.ibm.com> <20050113181850.GA24952@kroah.com>
In-Reply-To: <20050113181850.GA24952@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131021.19434.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 13, 2005 10:18 am, Greg KH wrote:
> On Thu, Jan 13, 2005 at 11:49:11AM -0600, John Rose wrote:
> > > Maybe, did you read Documentation/filesystems/sysfs-pci.c?  You need to
> > > do more than just enable HAVE_PCI_LEGACY, you also need to implement
> > > some functions.
> >
> > This sounds like more than I bargained for.  I'll leave the patch as-is,
> > since I don't currently have the means to test a fix for the legacy IO
> > stuff.  Also because it doesn't crash on my architecture :)
> >
> > If you get some time, my suggestion is to scrap
> > pci_remove_legacy_files(), and free the pci_bus->legacy_io field in
> > pci_remove_bus().  The binary sysfs files will be cleaned up
> > automatically as the class device is deleted, as described in the
> > parent.
>
> No, don't rely on this please.  Explicitly clean up the files, it's
> nicer that way, and when sysfs changes to not clean them up for you, it
> will be less changes then.

So does the crash indicate that something is removing the directory, 
containing the attributes to be removed, before it should?  How should the 
oops be fixed?

Thanks,
Jesse
