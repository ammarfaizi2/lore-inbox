Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVHYRG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVHYRG3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 13:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbVHYRG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 13:06:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5806 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751207AbVHYRG2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 13:06:28 -0400
Date: Thu, 25 Aug 2005 10:06:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Chris Wright <chrisw@osdl.org>, Greg Kroah <greg@kroah.com>,
       Kurt Garloff <garloff@suse.de>, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] Remove unnecesary capability hooks in rootplug.
Message-ID: <20050825170617.GW7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <20050825012150.490797000@localhost.localdomain> <20050825143807.GA8590@sergelap.austin.ibm.com> <1124982836.3873.78.camel@moss-spartans.epoch.ncsc.mil> <20050825162101.GU7762@shell0.pdx.osdl.net> <1124987036.3873.106.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124987036.3873.106.camel@moss-spartans.epoch.ncsc.mil>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> On Thu, 2005-08-25 at 09:21 -0700, Chris Wright wrote:
> > * Stephen Smalley (sds@epoch.ncsc.mil) wrote:
> > > On Thu, 2005-08-25 at 09:38 -0500, serue@us.ibm.com wrote:
> > > > Ok, with the attached patch SELinux seems to work correctly.  You'll
> > > > probably want to make it a little prettier  :)  Note I have NOT ran the
> > > > ltp tests for correctness.  I'll do some performance runs, though
> > > > unfortunately can't do so on ppc right now.
> > > 
> > > Note that the selinux tests there _only_ test the SELinux checking.  So
> > > if these changes interfere with proper stacking of SELinux with
> > > capabilities, that won't show up there.  
> > 
> > Sorry, I'm not parsing that?
> 
> e.g. if secondary_ops->capable is null, the SELinux tests aren't going
> to show that, because they will still see that the SELinux permission
> checks are working correctly.  They only test failure/success for the
> SELinux permission checks, not for the capability checks, so if you
> unhook capabilities, they won't notice.

Yes, I see.  I thought the tests you were referring to were 
"if (secondary_ops->capable)" not LTP tests.  Capability is still a
module that can be loaded (or built-in).  So the only issue is it's
security_ops is now NULL where it was a trivial return 0 function.
Aside from the oversight Serge fixed, I don't think there's any issue.

thanks,
-chris
