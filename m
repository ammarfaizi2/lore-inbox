Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262514AbULOXsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262514AbULOXsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 18:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262526AbULOXsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 18:48:05 -0500
Received: from fw.osdl.org ([65.172.181.6]:11755 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262514AbULOXsB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 18:48:01 -0500
Date: Wed, 15 Dec 2004 15:47:57 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, James Morris <jmorris@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Properly split capset_check+capset_set
Message-ID: <20041215154757.H2357@build.pdx.osdl.net>
References: <20041215194812.GA3080@IBM-BWN8ZTBWA01.austin.ibm.com> <1103142857.32732.13.camel@moss-spartans.epoch.ncsc.mil> <20041215232222.GD888@IBM-BWN8ZTBWA01.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041215232222.GD888@IBM-BWN8ZTBWA01.austin.ibm.com>; from serue@us.ibm.com on Wed, Dec 15, 2004 at 05:22:22PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge E. Hallyn (serue@us.ibm.com) wrote:
> Quoting Stephen Smalley (sds@epoch.ncsc.mil):
> > necessary to preserve any error return in the cases where capset() is
> > being applied to multiple processes, but in the case where it is being
> > applied to a single specific process, it would be nice if any error
> > return from security_capset_check() would be returned to the caller.
> 
> In the case of pid<0, would we want to do something like "return an error
> if none of the sets was allowed, else return 0", or is that too ugly?

The signal code returns an error if any delivery failed.  So, there's at
least precedence for that type of behaviour.

> > I also wonder whether the existing hardcoded checks should be moved into
> > the new security_capset_check() hook function for dummy and commoncap so
> > that they will be applied to the real target, even when pid < 0. 
> > Otherwise, those hardcoded checks seem bogus in the pid < 0 case, as
> > they are then applied to current rather than to the true targets.
> 
> True, this (testing applicability of caps to the real targets in pid<0 case)
> certainly seems like a good thing, so the attached patch leaves that
> check in cap_capset_check, and just removes it from sys_capset() instead.

Yeah, it is inconsistent right now.  Don't forget, the dummy code doesn't
even allow for capability setting.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
