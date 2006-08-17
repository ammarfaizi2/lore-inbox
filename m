Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWHQM0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWHQM0U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbWHQM0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:26:19 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:16004 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S932296AbWHQM0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:26:15 -0400
Subject: Re: [RFC] [PATCH] file posix capabilities
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, "Serge E. Hallyn" <serge@hallyn.com>,
       Nicholas Miell <nmiell@comcast.net>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org
In-Reply-To: <44E45A70.8090801@gentoo.org>
References: <20060730011338.GA31695@sergelap.austin.ibm.com>
	 <20060814220651.GA7726@sergelap.austin.ibm.com>
	 <m1r6zirgst.fsf@ebiederm.dsl.xmission.com>
	 <20060815020647.GB16220@sergelap.austin.ibm.com>
	 <m13bbyr80e.fsf@ebiederm.dsl.xmission.com>
	 <1155615736.2468.12.camel@entropy> <20060815114946.GA7267@vino.hallyn.com>
	 <1155658688.1780.33.camel@moss-spartans.epoch.ncsc.mil>
	 <20060816024200.GD15241@sergelap.austin.ibm.com>
	 <1155734401.18911.33.camel@moss-spartans.epoch.ncsc.mil>
	 <44E45A70.8090801@gentoo.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 17 Aug 2006 08:28:18 -0400
Message-Id: <1155817698.21070.18.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-17 at 08:00 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Tue, 2006-08-15 at 21:42 -0500, Serge E. Hallyn wrote:
> >   
> > <snip>
> >> Very good point.  Preventing communication channels i.e. through signals
> >> isn't a concern, but user hallyn ptracing himself running /bin/passwd
> >> certainly is.
> >>     
> >
> > Actually, ptrace already performs a capability comparison (cap_ptrace).
> > Wrt signals, it wasn't the communication channel that concerned me but
> > the ability to interfere with the operation of a process running in the
> > same uid but different capabilities, like stopping it at a critical
> > point.  Likewise with many other task hooks - you wouldn't want to be
> > able to depress the priority of a process running with greater
> > capabilities.
> >
> >   
> On this point, what about environment tampering of processes with caps? 
> LD_PRELOAD=my_bad_lib.so /usr/bin/passwd. glibc atsecure logic would 
> have to be updated to do a capability comparison.

That's the bprm_secureexec logic change that has already been mentioned;
that determines the AT_SECURE value, and glibc then just acts based on
that value provided by the kernel.  Just a matter of extending
cap_bprm_secureexec to compare the capability sets.  Already on Serge's
todo list, but it is necessary for this to be a safe change, and should
happen before this patch goes anywhere (even -mm), IMHO.

-- 
Stephen Smalley
National Security Agency

