Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbULTXVm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbULTXVm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULTXOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:14:52 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10406 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261683AbULTXB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:01:59 -0500
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] add PCI API to sysfs
Date: Mon, 20 Dec 2004 15:01:12 -0800
User-Agent: KMail/1.7.1
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, willy@debian.org,
       benh@kernel.crashing.org
References: <200412201450.47952.jbarnes@engr.sgi.com> <20041220225817.GA21404@kroah.com>
In-Reply-To: <20041220225817.GA21404@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412201501.12575.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, December 20, 2004 2:58 pm, Greg KH wrote:
> On Mon, Dec 20, 2004 at 02:50:46PM -0800, Jesse Barnes wrote:
> > Ok, how does this one look?  It needs some obvious work, but is the
> > approach of adding functionality to sysfs instead of /proc the right way
> > to go?  What I've done:
> >
> >   o add mmap support to bin files in sysfs
> >   o make PCI resources available via mmap
> >   o make legacy I/O and memory space available in sysfs
>
> How about splitting this up into the different patches that each do one
> thing?

Sure, I forgot the diffstat too (doh!).

> > +static int mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > + struct dentry *dentry = file->f_dentry;
> > + struct bin_attribute *attr = to_bin_attr(dentry);
> > + struct kobject *kobj = to_kobj(dentry->d_parent);
> > +
> > + return attr->mmap(kobj, attr, vma);
> > +}
> > +
>
> What happens if mmap is not set?  oops...

Yeah, I mentioned that in "things to do" at the bottom, but I'm really looking 
for an "ack, this is a sane way to go" before I sink much more time into it.

Thanks,
Jesse
