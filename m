Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751927AbWCFVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbWCFVyA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbWCFVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:54:00 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:462 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751669AbWCFVyA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:54:00 -0500
Date: Mon, 6 Mar 2006 13:53:44 -0800
From: Greg KH <greg@kroah.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Dave Peterson <dsp@llnl.gov>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] EDAC: core EDAC support code
Message-ID: <20060306215344.GB16825@kroah.com>
References: <200601190414.k0J4EZCV021775@hera.kernel.org> <200603061052.57188.dsp@llnl.gov> <20060306195348.GB8777@kroah.com> <200603061301.37923.dsp@llnl.gov> <20060306213203.GJ27946@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060306213203.GJ27946@ftp.linux.org.uk>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 09:32:03PM +0000, Al Viro wrote:
> On Mon, Mar 06, 2006 at 01:01:37PM -0800, Dave Peterson wrote:
> > Regarding the above problem with the kobject reference count, this
> > was recently fixed in the -mm tree (see edac-kobject-sysfs-fixes.patch
> > in 2.6.16-rc5-mm2).  The fix I implemented was to add a call to
> > complete() in edac_memctrl_master_release() and then have the module
> > cleanup code wait for the completion.  I think there were a few other
> > instances of this type of problem that I also fixed in the
> > above-mentioned patch.
> 
> This is not a fix, this is a goddamn deadlock.
> 	rmmod your_turd </sys/spew/from/your_turd
> and there you go.  rmmod can _NOT_ wait for sysfs references to go away.

To be fair, the only part of the kernel that supports the above process,
is the network stack.  And they implemented a special kind of lock to
handle just this kind of thing.

That is not something that I want the rest of the kernel to have to use.
If your code blocks when doing the above thing, that's fine with me.

Note, you better have the module owner reference right for the above to
not oops the kernel, deadlock is fine.  There is no rule that we _have_
to allow rmmod to always succeed.

thanks,

greg k-h
