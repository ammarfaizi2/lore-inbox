Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265520AbTIEXaa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 19:30:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265527AbTIEXa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 19:30:29 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:39176
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S265520AbTIEXa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 19:30:27 -0400
Date: Fri, 5 Sep 2003 16:30:31 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Chad Kitching <CKitching@powerlandcomputers.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030905233031.GH19041@matchmail.com>
Mail-Followup-To: Chad Kitching <CKitching@powerlandcomputers.com>,
	linux-kernel@vger.kernel.org
References: <18DFD6B776308241A200853F3F83D50727B4@pl6w2kex.lan.powerlandcomputers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18DFD6B776308241A200853F3F83D50727B4@pl6w2kex.lan.powerlandcomputers.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 03:53:27PM -0500, Chad Kitching wrote:
> 
> From: Mike Fedyk [mailto:mfedyk@matchmail.com]
> > Here is one thing we don't have standardized across the entire Linux
> > distribution landscape.
> > 
> > What you need is a project that will take the top 10 
> > distributions, and do
> > this however each distribution does their thing:
> > 
> >  o identify the current kernel running (you're going to use the kernel
> >    you're running, right?)
> 
> Not to mention on boot-up check to make sure the module still loads 
> without warnings on the current kernel (or make sure the module exists 
> in the current /lib/modules directory.
>    

Not a problem. and /lib/modules is /lib/modules/`uname -r`
You have to compile the driver for the new kernel.  see below

> >  o download the kernel source for the running kernel
> 
> Problem: Most distributors modify their kernel somewhat.  Some enough 
> to cause binary module incompatibility with the 'stock' kernel.  
> Matching running kernel and source code kernel would be tricky, to
> say the least.
>  

That is why it has to be modified to detect and work with the 10 most
popular distributions.  You work with the distribution kernel...

> >  o install the source in some temporary location
> 
> Why not just make the includes directory get installed somewhere.  
> Somewhere like /lib/modules/`uname -r`/build/includes (especially since
> make install puts a symlink at /lib/modules/`uname -r`/build anyway)
> You also need to prep the extracted kernel with the proper .config, etc.
> which isn't always in the source package from some distributors.
> 

Because that takes up more space, and some people don't like that.  Though
the distributions could make it an option to do that on install.  It's up to
the individual distribution though...

> >  o compile against the downloaded kernel source
> > 
> >  o install the module under /lib/modules

should have been /lib/modules/`uname -r`

> > 
> >  o load the module (with the corect optional parameters)
> 
> The biggest problem is people not having installed the C compiler, and 
> related tools.  Or having not installed the kernel headers matching 
> their version of the kernel.
> 

 o identify gcc generation (2.95x, 3.0x, 3.1x, etc) to build current kernel
 
 o install gcc version to match

There are tools already to add patches to kernels in debian (wheather it's a
debian kernel or not).  We just need to have something the other way around.
No need to patch the kernel, just compile against it.

I say that it should adapt to the individual distribution because it takes
so much longer to make a standard, and that can always come later, and the
project can adjust to the new standard (instead of complaining to each
distribution whenever they change their kernel packaging technique).
