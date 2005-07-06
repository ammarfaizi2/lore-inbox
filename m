Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262142AbVGFJGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbVGFJGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 05:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVGFJGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 05:06:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:33669 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262142AbVGFHNE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 03:13:04 -0400
Date: Wed, 6 Jul 2005 00:04:02 -0700
From: Greg KH <greg@kroah.com>
To: James Morris <jmorris@redhat.com>
Cc: Tony Jones <tonyj@suse.de>, serge@hallyn.com, serue@us.ibm.com,
       lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050706070402.GA9537@kroah.com>
References: <20050703204423.GA17418@kroah.com> <Xine.LNX.4.44.0507060243500.6302-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0507060243500.6302-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 02:52:47AM -0400, James Morris wrote:
> On Sun, 3 Jul 2005, Greg KH wrote:
> 
> > Good idea.  Here's a patch to do just that (compile tested only...)
> > 
> > Comments?
> 
> Looks promising so far.
> 
> I'm currently porting selinuxfs funtionality to securityfs, although I'm
> not sure if we'll be ok during early initialization.  selinuxfs is
> currently kern_mounted via an initcall.  We may need an initcall
> kern_mount() of securityfs before SELinux kicks in.

Sure, I don't mind moving this if needed.

> Otherwise, it looks like it'll allow SELinux to drop some code.  Generally 
> it will mean that other LSM components won't have to create their own 
> filesystems, and their subdirectories will be hanging off /security (or 
> wherever selinuxfs is mounted), rather than scattered across /

The code creates /sys/kernel/security as a mount point for securityfs.
This will make the LSB people happy that every LSM does not create a new
fs in / :)

> Some of the SELinux code may be useful as part of securityfs later, as 
> well.

That would be fine.

> How about having all API functions which return a pointer be converted to 
> use ERR_PTR() ?
> 
> This will allow errors to be propagated to the calling code.

Good point, will change that.

thanks,

greg k-h
