Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVEIL50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVEIL50 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 07:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbVEIL5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 07:57:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:8882 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261289AbVEIL5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 07:57:14 -0400
Date: Mon, 9 May 2005 17:25:44 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, sharada@in.ibm.com, torvalds@osdl.org,
       paulus@samba.org, anton@samba.org, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, miltonm@bga.com
Subject: Re: [Fastboot] Re: [PATCH] ppc64: kexec support for ppc64
Message-ID: <20050509115544.GA3813@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <17019.3752.917407.742713@cargo.ozlabs.ibm.com> <20050506124158.GA2741@in.ibm.com> <20050506124409.GB2741@in.ibm.com> <20050506160546.388aeed4.akpm@osdl.org> <20050507164941.GA3963@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050507164941.GA3963@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 07, 2005 at 10:19:41PM +0530, Suparna Bhattacharya wrote:
> On Fri, May 06, 2005 at 04:05:46PM -0700, Andrew Morton wrote:
> > R Sharada <sharada@in.ibm.com> wrote:
> > >
> > > This patch implements the kexec support for ppc64
> > 
> > Well that's pretty neat.   How well does this work?
> > 
> > I assume you'll be working on kdump-via-kexec for ppc64?
> > 
> > 
> > This kdump/kexec stuff has been hanging around for far too long, IMO.  I'd
> > like to think about what we can do to get things moving along a bit more.
> > 
> > I have two issues with it:
> > 
> > a) Vague feelings that the low-level ia32 changes may cause APIC/etc
> >    breakage with some PCs.
> 
> Do you suspect impact during normal operation, or only upon kexec-on-panic ?
> If its the former, then wider testing with CONFIG_KEXEC turned on is
> really important.

Following are the kexec patches which modify the concerned area and 
are _not_ under CONFIG_KEXEC. So it is also important to test such 
codepath with and without CONFIG_KEXEC. We have been testing various 
x86 machines with these patches and so far we have not observed any 
problems related to machine shutdown or APIC/IOAPIC shutdown.

x86-rename-apic_mode_exint.patch
x86-local-apic-fix.patch
x86-i8259-shutdown.patch
x86_64-i8259-shutdown.patch
x86-apic-virtwire-on-shutdown.patch
x86_64-apic-virtwire-on-shutdown.patch
x86-machine_shutdown.patch
x86_64-machine_shutdown.patch

> > b) Much more significantly: I still do not believe that it has been
> >    demonstrated that the whole kdump-via-kexec scheme will have a
> >    sufficiently high success rate for this to become Linux's way of doing
> >    crashdumps.
> > 

Following are the links to kdump testing results and kexec-tools patches

http://lse.sourceforge.net/kdump/kdump-test.html

http://lse.sourceforge.net/kdump/patches/kexec-tools-1.101-kdump.patch

> >    And it would not be good if in six months time we decide that the
> >    practical problems in getting it all working sufficiently well are
> >    insurmountable and we have to revert it all and start working on
> >    something else.

At this point of time we have device initialisation problem in hand which
causes intermittent failures in second kernel boot in case of kexec-on-panic.

> >    Recently I've seem a couple of "kdump worked for me" reports, which are
> >    greatly appreciated, but I don't think they're statistically
> >    significant.
> > 
> >    So am I right to have this concern?  If so, how can we settle this? 
> >    (ie: who's going to do it?  ;))
> > 
> 
>
[..]
> > 
> > Perhaps we could declare that kexec is sufficiently useful and mature in
> > its own right and just merge up those bits while we work on kdump.  This
> > also gives us a bit of pipelining: continue to test and stabilise kexec
> > while kdump remains in development.
> 
> Several months back, I would likely have agreed with that.
> 
> Now, I'm not so sure. After the kdump redesign, a large part of the kdump
> support is actually provided by kexec-on-panic which is an integral part
> of kexec. The additional bits for dump capture alone may not be a whole
> lot ... But, I'd let Maneesh/Vivek comment on that.

That's right. After the kexec rework, significant chunk of kdump 
functionality particularly related to panic codepath, which halts 
other CPU's and saves register states, is merged with kexec, as 
kexec-on-panic functionality.

kdump code in kernel is mainly reduced to dump capturing functionality 
only. If kexec-on-panic can successfully boot second kernel, there are 
remote chances of /proc/vmcore or /dev/oldmem not getting generated.


Thanks
Maneesh


-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
