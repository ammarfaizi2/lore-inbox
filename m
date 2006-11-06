Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753086AbWKFNcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086AbWKFNcK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:32:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753092AbWKFNcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:32:10 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:54751 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1753087AbWKFNcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:32:08 -0500
Subject: Re: [PATCH 1/1] security: introduce fs caps
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       20060906182719.GB24670@sergelap.austin.ibm.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <04A6CE5F-C68B-4F1A-B3CB-F3BB77D9EA9A@mac.com>
References: <20061103175730.87f55ff8.chris@friedhoff.org>
	 <20061103200011.GA2206@sergelap.austin.ibm.com>
	 <1162585797.5519.175.camel@moss-spartans.epoch.ncsc.mil>
	 <20061103204706.GA31398@sergelap.austin.ibm.com>
	 <04A6CE5F-C68B-4F1A-B3CB-F3BB77D9EA9A@mac.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Mon, 06 Nov 2006 08:31:13 -0500
Message-Id: <1162819873.5519.250.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-11-03 at 21:08 -0500, Kyle Moffett wrote:
> On Nov 03, 2006, at 15:47:06, Serge E. Hallyn wrote:
> >  Quoting Stephen Smalley (sds@tycho.nsa.gov):
> >> On Fri, 2006-11-03 at 14:00 -0600, Serge E. Hallyn wrote:
> >>> One question is, if this were to be tested in -mm, do we want to  
> >>> keep
> >>> this mutually exclusive from selinux through config, or should  
> >>> selinux
> >>> stack on top of this?
> >>
> >> Given that SELinux already stacks with capability and you aren't  
> >> using
> >> the security fields (last I looked), it would seem trivial to enable
> >> stacking with fscaps (just add a few secondary_ops calls to the  
> >> SELinux
> >> hooks, right?).
> >
> > Yup, I just wasn't sure if there would be actual objections to the  
> > idea of enabling both at once.
> >
> > I'll send out a patch - just as soon as I figure out where I left  
> > the src to begin with :)
> 
> To be honest from my understanding of SELinux there is no need at all  
> to use FS caps on an SELinux system.  Anything that could be done  
> with FS caps would be done in a much more fine-grained method with  
> SELinux, and the inheritance of filesystem-based capabilities should  
> be masked by SELinux-allowed capabilities anyways.  I guess it _can_  
> be done, but why?  It's possible to set up an SELinux system so that  
> there aren't even any SUID binaries, right?  /etc/passwd can run as  
> whatever random user and it will automatically transition to the  
> appropriate domain such that it can read and modify /etc/shadow.

Not currently, no.  SELinux typically applies its MAC checks after any
DAC checks have already been applied, and will only further restrict
access.  Hence, you can use SELinux to limit what a process with
capabilities can do, since it must also have the corresponding SELinux
permissions, but you still need a way of gaining those capabilities in
order to pass the usual Linux checks.

Using SELinux to authoritatively grant capabilities based on role/domain
would be useful, and has been done by some people (via custom kernels),
but doing so safely requires quite a bit of work in userspace and policy
configuration.  That wasn't viewed as practical for an initial
deployment of MAC, and we didn't want to expose systems to greater risk.

-- 
Stephen Smalley
National Security Agency

