Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbVAZQmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbVAZQmm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVAZQkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:40:45 -0500
Received: from news.suse.de ([195.135.220.2]:5268 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262383AbVAZQjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:39:05 -0500
Subject: Re: [PATCH 2.6.11-rc2] modules: add version and srcversion to sysfs
From: Andreas Gruenbacher <agruen@suse.de>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <greg@kroah.com>,
       Christoph Hellwig <hch@infradead.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050126140935.GA27641@lists.us.dell.com>
References: <20050119171357.GA16136@lst.de>
	 <20050119234219.GA6294@kroah.com>
	 <20050126060541.GA16017@lists.us.dell.com>
	 <200501261022.30292.agruen@suse.de>
	 <20050126140935.GA27641@lists.us.dell.com>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1106757530.13004.220.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 Jan 2005 17:38:51 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-26 at 15:09, Matt Domsch wrote:
> On Wed, Jan 26, 2005 at 10:22:29AM +0100, Andreas Gruenbacher wrote:
> > On Wednesday 26 January 2005 07:05, Matt Domsch wrote:
> > > Module:  Add module version and srcversion to the sysfs tree
> > 
> > why do you need this?
> 
> a) Tools like DKMS, which deal with changing out individual kernel
> modules without replacing the whole kernel, can behave smarter if they
> can tell the version of a given module.

They can look at the modules in /lib/modules/$(uname -r).

> The autoinstaller feature,
> for example, which determines if your system has a "good" version of a
> driver (i.e. if the one provided by DKMS has a newer verson than that
> provided by the kernel package installed), and to automatically
> compile and install a newer version if DKMS has it but your kernel
> doesn't yet have that version.

I find the autoinstaller feature quite scary.

> b) Because tools like DKMS can switch out modules, you can't count on
> 'modinfo foo.ko', which looks at
> /lib/modules/${kernelver}/... actually matching what is loaded into
> the kernel already.  Hence asking sysfs for this.

DKMS doesn't manage loading modules, does it? If it does, then at least
it shouldn't; that's even more scary than the autoinstaller. From the
point of view of the kernel, the modules relevant for the running kernel
are those below /lib/modules/$(uname -r)/. If DKMS replaces things
there, it'd better keep proper track of what it did.

I never want to see DKMS try to remove a module from the running kernel
or insmod a new one.

> c) as the unbind-driver-from-device work takes shape, it will be
> possible to rebind a driver that's built-in (no .ko to modinfo for the
> version) to a newly loaded module.  sysfs will have the
> currently-built-in version info, for comparison.
>
> d) tech support scripts can then easily grab the version info for
> what's running presently - a question I get often.

That's something you can do entirely in userspace by looking at the *.ko
files.

Regards,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX GMBH

