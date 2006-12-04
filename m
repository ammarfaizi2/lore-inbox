Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937148AbWLDQ5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937148AbWLDQ5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937149AbWLDQ5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:57:10 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:41012 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S937148AbWLDQ5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:57:08 -0500
Date: Mon, 4 Dec 2006 11:57:07 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Oliver Neukum <oliver@neukum.org>
cc: Maneesh Soni <maneesh@in.ibm.com>, <gregkh@suse.com>,
       <linux-usb-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: race in sysfs between sysfs_remove_file() and read()/write() #2
In-Reply-To: <200612041735.13615.oliver@neukum.org>
Message-ID: <Pine.LNX.4.44L0.0612041153160.3642-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006, Oliver Neukum wrote:

> > Also, Oliver, it looks like the latest version of your patch makes an 
> > unnecessary change to sysfs_remove_file().
> 
> Code like:
> 
> int d(int a, int b)
> {
> 	return a + b;
> }
> 
> int c(int a, int b)
> {
> 	return d(a, b);
> }
> 
> is a detrimental to correct understanding and thence coding.
> In fact reading sysfs source code is like jumping all around the kernel
> tree. Such changes made it readable by normal people. I have to
> understand which method I am coding on to do reasonable work. ;-)

I was referring to sysfs_remove_file(), not sysfs_open_file() -- I agree 
that getting rid of the check_perm() routine is good.  But this isn't:

>  void sysfs_remove_file(struct kobject * kobj, const struct attribute * attr)
>  {
> -       sysfs_hash_and_remove(kobj->dentry,attr->name);
> +       struct dentry *d = kobj->dentry;
> +
> +       sysfs_hash_and_remove(d, attr->name);
>  }

There's no apparent advantage to introducing the local variable d, either 
in terms of execution speed or readability.  (Although the original source 
line should have a space after the comma.)

Alan Stern

