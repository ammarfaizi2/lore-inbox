Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbULJQWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbULJQWV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:22:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbULJQWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:22:21 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39593 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261192AbULJQWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:22:04 -0500
Subject: Re: [RFC PATCH] convert uhci-hcd to use debugfs
From: Josh Boyer <jdub@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20041210152728.GA5827@kroah.com>
References: <20041210005055.GA17822@kroah.com>
	 <20041210005514.GB17822@kroah.com>
	 <1102688117.26320.7.camel@weaponx.rchland.ibm.com>
	 <20041210152728.GA5827@kroah.com>
Content-Type: text/plain
Message-Id: <1102695710.26320.48.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 10 Dec 2004 10:21:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 09:27, Greg KH wrote:
> 
> > > -#ifdef CONFIG_PROC_FS
> > > -	ent = create_proc_entry(hcd->self.bus_name, S_IFREG|S_IRUGO|S_IWUSR, uhci_proc_root);
> > > -	if (!ent) {
> > > -		dev_err(uhci_dev(uhci), "couldn't create uhci proc entry\n");
> > > +	dentry = debugfs_create_file(hcd->self.bus_name, S_IFREG|S_IRUGO|S_IWUSR, uhci_debugfs_root, uhci, &uhci_proc_operations);
> > > +	if (!dentry) {
> > 
> > That won't work if debugfs is not configured.  You'll get back (void *)
> > -ENODEV, which is not NULL.
> 
> That's exactly correct.  We do _not_ want NULL to be returned if debugfs
> is not configured in.  We want to be able to detect if an error
> happened, not if the feature was just not configured.  Otherwise, if we
> did return NULL if debugfs was not enabled, this code would just fail
> and the uhci startup would never happen.
> 
> This is why people have to wrap proc functions in #ifdef, and why no one
> ever checks the return values from devfs calls.  It's a real problem and
> I don't want to duplicate that again.

Ah, ok I see now.  Good point.  I should have looked at the code instead
of just trying to infer everything from the patch ;).

josh

