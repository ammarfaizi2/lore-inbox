Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264181AbUDBVDJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUDBVDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:03:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:15835 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264181AbUDBVDF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:03:05 -0500
Date: Fri, 2 Apr 2004 13:03:04 -0800
From: Chris Wright <chrisw@osdl.org>
To: Andy Lutomirski <luto@stanford.edu>
Cc: Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, luto@myrealbox.com,
       linux-kernel@vger.kernel.org
Subject: Re: capabilitiescompute_cred
Message-ID: <20040402130304.F21045@build.pdx.osdl.net>
References: <20040402033231.05c0c337.akpm@osdl.org> <1080912069.27706.42.camel@moss-spartans.epoch.ncsc.mil> <20040402111554.E21045@build.pdx.osdl.net> <406DCB32.8070403@stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <406DCB32.8070403@stanford.edu>; from luto@stanford.edu on Fri, Apr 02, 2004 at 10:21:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski (luto@stanford.edu) wrote:
> Chris Wright wrote:
> > I have the same dislike for capabilities.  It's more like a wart than
> > a feature.  I get requests to have RBAC be the core priv system rather
> > than capabilities.
> 
> I agree in principle, but it would still be nice to have a simple way to 
> have useful capabilities without setting up a MAC system.  I don't see a 
> capabilities fix adding any significant amount of code; it just takes 
> some effort to get it right.

Main problem is the granularity and poorly defined semantics.  You have
no context when making a capability decision.  In some cases it
overrides normal DAC checks, and in other cases it's a stand alone
privilege.  Then there's CAP_SYS_ADMIN...

> > In the meantime, I've often idly wondered why we don't simply inherit as
> > advertised.  The patch below does this, but I haven't even started
> > looking for security sensitive failure modes.
> 
> I'm not sure that introduces security problems, but I'm also not sure it 
> fixes much.  You can find my attempts to get it right in the 
> linux-kernel archives, and I'll probably try to get something into 2.7 
> when it forks.  With or without MAC, having a functioning capability 
> system wouldn't hurt security.

It simply allows one to properly inherit.  As it stands inherit is
totally broken.  Once you execve() the capabilities get reset to all or
nothing.  So if you want to drop privs and execve() bash (as a login
utility might do), you'll need something like this.  Only hesitance I
have is being sure it doesn't introduce some subtle bug.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
