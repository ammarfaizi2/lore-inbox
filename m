Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVAZOKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVAZOKx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 09:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVAZOKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 09:10:52 -0500
Received: from lists.us.dell.com ([143.166.224.162]:45240 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262306AbVAZOKJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 09:10:09 -0500
Date: Wed, 26 Jan 2005 08:09:35 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Andreas Gruenbacher <agruen@suse.de>
Cc: rusty@rustcorp.com.au, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.11-rc2] modules: add version and srcversion to sysfs
Message-ID: <20050126140935.GA27641@lists.us.dell.com>
References: <20050119171357.GA16136@lst.de> <20050119234219.GA6294@kroah.com> <20050126060541.GA16017@lists.us.dell.com> <200501261022.30292.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501261022.30292.agruen@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2005 at 10:22:29AM +0100, Andreas Gruenbacher wrote:
> On Wednesday 26 January 2005 07:05, Matt Domsch wrote:
> > Module:  Add module version and srcversion to the sysfs tree
> 
> why do you need this?

a) Tools like DKMS, which deal with changing out individual kernel
modules without replacing the whole kernel, can behave smarter if they
can tell the version of a given module.  The autoinstaller feature,
for example, which determines if your system has a "good" version of a
driver (i.e. if the one provided by DKMS has a newer verson than that
provided by the kernel package installed), and to automatically
compile and install a newer version if DKMS has it but your kernel
doesn't yet have that version.

b) Because tools like DKMS can switch out modules, you can't count on
'modinfo foo.ko', which looks at
/lib/modules/${kernelver}/... actually matching what is loaded into
the kernel already.  Hence asking sysfs for this.

c) as the unbind-driver-from-device work takes shape, it will be
possible to rebind a driver that's built-in (no .ko to modinfo for the
version) to a newly loaded module.  sysfs will have the
currently-built-in version info, for comparison.

d) tech support scripts can then easily grab the version info for
what's running presently - a question I get often.

Thanks,
Matt


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
