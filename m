Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751650AbWBWIYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbWBWIYl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 03:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbWBWIYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 03:24:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:54981 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751646AbWBWIYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 03:24:40 -0500
Subject: Re: [ PATCH 2.6.16-rc3-xen 3/3] sysfs: export
	Xen	hypervisor	attributes to sysfs
From: Arjan van de Ven <arjan@infradead.org>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: "Mike D. Day" <ncmike@us.ibm.com>,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, xen-devel@lists.xensource.com,
       lkml <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>
In-Reply-To: <43FD3971.7070703@us.ibm.com>
References: <43FB2642.7020109@us.ibm.com>
	 <1140542130.8693.18.camel@localhost.localdomain>
	 <20060222123250.GB9295@osiris.boeblingen.de.ibm.com>
	 <43FC5B1D.5040901@us.ibm.com>
	 <1140612969.2979.20.camel@laptopd505.fenrus.org>
	 <43FC61C4.30002@us.ibm.com>
	 <20060222131918.GC9295@osiris.boeblingen.de.ibm.com>
	 <43FC6A86.90901@us.ibm.com>
	 <1140616911.2979.22.camel@laptopd505.fenrus.org>
	 <43FD3971.7070703@us.ibm.com>
Content-Type: text/plain
Date: Thu, 23 Feb 2006 09:24:25 +0100
Message-Id: <1140683065.2972.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-22 at 22:26 -0600, Anthony Liguori wrote:
> Arjan van de Ven wrote:
> > On Wed, 2006-02-22 at 08:43 -0500, Mike D. Day wrote:
> >   
> >> Heiko Carstens wrote:
> >>     
> >>> On Wed, Feb 22, 2006 at 08:06:12AM -0500, Mike D. Day wrote:
> >>>
> >>> If it's not needed, why include it at all?
> >>>       
> >> Sorry for not being clear. It *is* needed for control tools and agents 
> >> running in the privileged domain. 
> >>     
> >
> > but again those tools and agents *already* have a way of talking to the
> > hypervisor themselves. Why can't they just first ask this info? Why does
> > that need to be in the kernel, in unswappable memory?
> >   
> Hypercalls have to be done in ring 0 for security reasons)  There has to 
> be some kernel interface for making hypercalls.

sure but you need that ANYWAY; the management tools will want a generic
"THIS hypercall" thing

> 
> The current interface is a ioctl() on a /proc file (which is awful).  
> The ioctl just pretty much passes 5 word arguments to the hypervisor.  
> It was suggested previously here that a hypercall pass-through interface 
> isn't the right approach.  One suggestion that came up was a syscall 
> interface.

yeah a syscall sounds right for this



> Also, there are some kernel-level drivers, like the memory ballooning 
> driver, that only exist in the kernel.  Controlling the balloon driver 
> requires some sort of interface.  That was the original point of this 
> effort (since it's currently exposed as a /proc file).  I think it's 
> quite clear that the balloon driver should expose itself through sysfs 
> but I'm not personally convinced that this information (hypervisor 
> version information) ought to be exposed in sysfs.

that's a different thing; the ballooning driver obviously has to be in
kernel due to how it interacts with the VM, and having it's 1 or 2
controls in sysfs (hint: make it writable module parameters, so that the
defaults can be set at module load time, and you'll also get the rest
for free ;)

pure hypervisor info... no. "only" 8Kb of code + all data structures..
for something just as easily done in the management layer. In fact I
suspect the management layer will do the hypercalls anyway just because
it's easier to do than parsing sysfs !

