Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbVFOVDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbVFOVDA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 17:03:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVFOVBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 17:01:35 -0400
Received: from zombie.ncsc.mil ([144.51.88.131]:40439 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S261564AbVFOU7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:59:10 -0400
Subject: Re: [PATCH] 3 of 5 IMA: LSM-based measurement code
From: Stephen Smalley <sds@tycho.nsa.gov>
To: serue@us.ibm.com
Cc: James Morris <jmorris@redhat.com>, Tom Lendacky <toml@us.ibm.com>,
       Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Chris Wright <chrisw@osdl.org>,
       Reiner Sailer <sailer@watson.ibm.com>,
       Emily Rattlif <emilyr@us.ibm.com>, Kylene Hall <kylene@us.ibm.com>
In-Reply-To: <20050615204936.GA3517@serge.austin.ibm.com>
References: <1118846413.2269.18.camel@secureip.watson.ibm.com>
	 <Xine.LNX.4.44.0506151601310.27162-100000@thoron.boston.redhat.com>
	 <20050615204936.GA3517@serge.austin.ibm.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Wed, 15 Jun 2005 16:58:10 -0400
Message-Id: <1118869090.16874.46.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-06-15 at 15:49 -0500, serue@us.ibm.com wrote:
> A long, long time ago, Crispin defined LSM's purpose as:
> 
> >> Main goal : we have to design a generic framework to be able to use
> >> better
> >> security policies than the current ones (DAC and capabilities).
> >
> >Sort of. We have to design a generic interface that exports enough
> >kernel
> >functionality to allow security developers to go off and create these
> >better
> >security policy modules. 
> 
> Since IMA provides support for a new type of security policy,
> specifically remote system integrity verification, I don't see
> where LSM shouldn't necessarily be used.

IMA isn't an access control model.  Also, LSM is overkill for its needs
in many ways (IMA only needs a few LSM hooks) and is inadequate in other
ways (LSM lacks a hook needed by IMA for measuring modules, although one
might argue that there could be benefit in adding such a hook to LSM
itself for access control purposes).  

> I'm also curious about the current kernel development approach:
> On the one hand, when filesystem auditing was introduced, Christoph
> asked whether inotify and audit should be merged because they hook
> some of the same places.  Can someone reconcile these points of view
> for me, please?  If Reiner goes ahead and moves the IMA code straight
> into the kernel, does anyone doubt that he'll be asked to merge it
> with LSM?
> 
> I'm not pushing one way or the other - I don't care whether IMA is
> an LSM or not :)  I just don't understand the current climate.

If you look at the inotify patch, I think that they've moved the dnotify
hooks into a more generic set of fsnotify hooks that are leveraged by
both dnotify and inotify to reduce duplication in the core kernel.  The
same approach could be used for hooks that would be co-located by audit
and LSM or by integrity measurement and LSM.  Of course, you don't want
to blindly place the integrity measurement hooks at the same locations
if a different placement would be more optimal for your purposes, so
you'd want to give it some thought.

-- 
Stephen Smalley
National Security Agency

