Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263743AbUGWCZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbUGWCZs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 22:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267494AbUGWCZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 22:25:47 -0400
Received: from c-67-171-146-69.client.comcast.net ([67.171.146.69]:22405 "EHLO
	kryten.internal.splhi.com") by vger.kernel.org with ESMTP
	id S263743AbUGWCZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 22:25:43 -0400
Subject: Re: New dev model (was [PATCH] delete devfs)
From: Tim Wright <timw@splhi.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, corbet@lwn.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040722232540.GH19329@fs.tum.de>
References: <40FEEEBC.7080104@quark.didntduck.org>
	 <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de>
	 <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de>
	 <20040722152839.019a0ca0.pj@sgi.com>  <20040722232540.GH19329@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Splhi
Message-Id: <1090549329.6113.21.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 22 Jul 2004 19:22:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-22 at 16:25, Adrian Bunk wrote:
> On Thu, Jul 22, 2004 at 03:28:39PM -0700, Paul Jackson wrote:
> 
> > > There's much worth in having a very stable kernel.
> >...
> > Now, I repeat, this is at the head end.  End users who want stability
> > aren't feeding directly off kernel.org anyway.
> 
> It depend on your definition of "end users" and "stability".
> 
> You might be right for people buying for many $$$ distributions with 
> support to run Oracle on it.
> 
> But I know many people who run ftp.kernel.org kernels on many 
> workstations and small servers e.g. in universities.
> 

That is their choice, but there's no particular need to run a kernel.org
kernel. Unless you're messing around with the kernel or have a hot
requirement for some new feature, why would running a stable kernel from
e.g. Debian not suffice? Debian is free and freely available, and it's
not the only distribution that is that way.

You can't have it both ways. If all you care about is stability, you can
run Debian stable, and be rock solid. If you want to play with the
latest code, you can download a kernel.org kernel. There is no shortage
of sources of kernels. It would simply mean that the kernel.org one
would have slightly less of a guarantee to be "stable", although as was
originally reported, 2.6 is going very well, and despite the flow of
changes, there isn't a lot of terrible breakage happening.

[...]

> 
> And what happens if you are a distribution, kernel 2.6.15 is the current 
> kernel containing many important updates, but $nontrivial_feature added 
> in 2.6.10 broke $architecture your distribution supports. This means you 
> have to support both kernel versions with security updates creating  
> expenses that must be passed on to the end user.
> 

No, you have several choices. For instance, you can continue to ship
2.6.10, or you can fix the problem. The reason Red Hat shipped a
different gcc back in the 7.x days and were subjected to much flamage
was because they wanted a c++ compiler that worked on architectures
other than x86 (alpha), and they put in effort to obtain such. Using Red
Hat as an example again, RHEL3 is based on 2.4.21. The current update is
still labelled as 2.4.21. It has fixes from later kernels but it isn't
based on 2.4.26. So this doesn't involve a radical change from how
things are today. They backport security fixes as do pretty much all
distros.

[...]

> 
> > Yes - damming up the flow of changes creates stability.  But if you're a
> > middleman, you don't need Linus to choose where to build the dam, and
> > when to open the flood gates.  It's more efficient for you to choose for
> > yourself when to do that damming, based on your particular resources and
> > customer needs, rather than have to deal with hundred year floods and
> > draughts imposed on you by Zeus.
> > 
> > The end user always gets their stability, if only because they won't
> > upgrade a system that is "working".
> 
> How do such end users get security updates?
> 

>From the middleman. That's no different to users of any distros today.
The distros apply security fixes and make updated kernels available on a
regular basis.

> > And every change at the head end is disruptive for some poor slob.
> > The only perfectly compatible change is no change at all.  We delude
> > ourselves if we think we can separate the "safe" fixes and additions
> > from the "unsafe" incompatible changes.  Better that we should expend
> > some energy on smoothing out and minimizing the cost of change to those
> > downstream from us.  This needs to be done the old-fashioned way, one
> > change at a time.
> > 
> > The question is whether we impose, on all those downstream from us,
> > occasional hundred year floods, or do we provide a steady stream, and
> > let them build their own little beaver dams, as suits their various and
> > diverse needs and business cycles.
> >...
> 
> But what to do if some part of the kernel (let's call it "XFS") has some 
> problems (let's call it "Oops") with a new feature (let's call it "4kb 
> stacks on i386") introduced in a kernel during a stable kernel series 
> (let's call it "2.6.6") and this isn't fixed by the maintainers (let's  
> call them "SGI") for some time (let's call it "until now")?
> 

Umm... compile the kernel with 8k stacks? Nobody is forcing you to use
the new option. And as has been pointed out by Chris, you are still at
risk of a stack overflow even with the 8k stacks if you take an
interrupt at the wrong time and it happens to be a heavy stack user. Or
you could run 2.4.26. Or...

The reasoning is that the advantages are heavily outweighing the
disadvantages, and I have to agree.

Regards,

Tim

-- 
Tim Wright <timw@splhi.com>
Splhi
