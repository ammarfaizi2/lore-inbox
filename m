Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVHYQYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVHYQYJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 12:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932292AbVHYQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 12:24:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2975 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932283AbVHYQYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 12:24:07 -0400
Date: Thu, 25 Aug 2005 09:24:03 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kurt Garloff <garloff@suse.de>, Chris Wright <chrisw@osdl.org>,
       linux-security-module@wirex.com,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] Call security hooks conditionally if the security_op is filled out.
Message-ID: <20050825162403.GV7762@shell0.pdx.osdl.net>
References: <20050825012028.720597000@localhost.localdomain> <20050825012149.330707000@localhost.localdomain> <20050825085039.GW12218@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825085039.GW12218@tpkurt.garloff.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kurt Garloff (garloff@suse.de) wrote:
> You did not like my macro abuse, apparently.
> That's too bad, as it allowed you to do changes without changing
> hundreds of lines of code.

It was handy that way, but I think this way is just cleaner and simpler.
Esp. when checking against the function ptr, not the security_ops ptr.

> Just one remark:
> Make sure you don't set security_ops->XXX ever back to NULL or you
> might take an oops.
> Security module unloading is racy and always has been. It's not well
> defined at what point in time the new functions become effective.
> And we certainly don't want to use locking for performance reasons.
> One could think of using RCU, though, thus the security_ops pointer
> would only be changed after all CPUs schedule()d ...

Removing a security module has always been unsafe.

> In my version of the patches, I maintained the capability_security_ops
> structure fully filled-in and pointed security_ops to it, so you'll
> always have a valid function pointer. If you wanted to avoid a pointer
> compare, I had an integer to look at ...

Yes, that's how 2/5 is.  At KS, there was specific mention of not doing
unconditional call.  Comparing against security_ops only helps the case
where a module is not loaded.  Checking the function ptr should help any
module with sparse ops.
