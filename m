Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbUKEBDs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbUKEBDs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262535AbUKEBAX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:00:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:47327 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262533AbUKEA4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 19:56:52 -0500
Date: Thu, 4 Nov 2004 16:56:50 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [6/6] LSM Stacking: temporary setprocattr hack
Message-ID: <20041104165650.F2357@build.pdx.osdl.net>
References: <1099609471.2096.10.camel@serge.austin.ibm.com> <1099609971.2096.26.camel@serge.austin.ibm.com> <20041104144839.C2357@build.pdx.osdl.net> <20041105005224.GB3792@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041105005224.GB3792@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Thu, Nov 04, 2004 at 06:52:24PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Quoting Chris Wright (chrisw@osdl.org):
> > * Serge Hallyn (serue@us.ibm.com) wrote:
> > > Stacker assumes that data written to /proc/<pid>/attr/* is of the
> > > form:
> > > 
> > > module_name: data
> > 
> > This breaks current tools where fields are space-delimited.  procps does
> > filtering that way, and I believe libselinux does as well.
> 
> Oh, are you talking about the output of getprocattr?  Perhaps the output
> should (temporarily) be default list the selinux info on the first line,
> without a "selinux: " prepended, and list any other modules after?

Ah, yeah, getprocattr, not the stacker setprocattr, sorry.  For quick
testing, something like that is sufficient.  But for longterm it's got
to be less hackish.

> You mentioned a common LSM sysfs framework.  Does it offer support for
> both per-module and per-pid-per-module files?  If so, then I suppose it
> would be fair to force LSMs to use those, and reserve the existing
> {gs}etprocattr files for selinux use (or nuke them).

Right now it's just per-module files.  The latter adds extra expense per
fork that would be nice to avoid.  Could be a sort of transaction file,
write the pid, get back the assoiciated data, and thus be static with
the directory.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
