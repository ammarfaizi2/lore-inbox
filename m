Return-Path: <linux-kernel-owner+w=401wt.eu-S932995AbWLSW5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932995AbWLSW5m (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 17:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932996AbWLSW5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 17:57:42 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:41946 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932995AbWLSW5l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 17:57:41 -0500
Date: Tue, 19 Dec 2006 22:57:29 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Message-ID: <20061219225729.GA15777@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191322.13378.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612191322.13378.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to sysfs PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 01:22:12PM -0800, David Brownell wrote:

> Stop trying to use broken and deprecated APIs; and realize that "previously
> working" meant you just hadn't tripped over the serious bugs yet.

I'm happy to stop using broken and deprecated APIs, providing that 
there's *actually a replacement*.

> Drivers can and should know how to do that sort of stuff themselves,
> so the power savings are reliable and consistent no matter what user
> space tools are (or aren't) used.

To the extent that that's possible, I entirely agree - however, it 
clearly isn't always. Not all hardware can be powered down without 
losing functionality, and so in those cases it's important that there be 
a mechanism to allow that decision to be made by userspace.

> Drivers know how to get power savings a lot better than any userspace
> code ever could ... with the exception of hints like "ifdown eth0"
> letting the driver know that right now is a good time to power down
> almost everything, since it's not going to be used until "ifup".

But in the cases where you don't have fine grained power management in 
the hardware, it's still desirable to be able to suspend an unused 
network agent. The driver can't do it by default, because that would 
break existing behaviour.

> As a generic mechanism, that interface has *ALWAYS* been "broken
> by design"; I'd call it unfixable.  It's deprecated, and scheduled
> to vanish; see Documentation/feature-removal-schedule.txt ...

The fact that something is scheduled to be removed in July 2007 does 
*not* mean it's acceptable to break it in 2006. We need to find a way to 
fix this functionality in the meantime.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
