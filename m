Return-Path: <linux-kernel-owner+w=401wt.eu-S1753782AbWLPUaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbWLPUaR (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 15:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753781AbWLPUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 15:30:17 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3306 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753784AbWLPUaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 15:30:15 -0500
Date: Sat, 16 Dec 2006 20:30:01 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "J.H." <warthog9@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-ID: <20061216203000.GB31619@flint.arm.linux.org.uk>
Mail-Followup-To: "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, hpa@zytor.com,
	webmaster@kernel.org
References: <20061214223718.GA3816@elf.ucw.cz> <20061216094421.416a271e.randy.dunlap@oracle.com> <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166297434.26330.34.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 11:30:34AM -0800, J.H. wrote:
> The problem has been hashed over quite a bit recently, and I would be
> curious what you would consider the real problem after you see the
> situation.

One thing which isn't helping you is the way folk inevitably end up
using ftp.kernel.org rather than ftp.<cc>.kernel.org. [*]

Let me illustrate why.  Throw http://ftp.uk.kernel.org/pub/linux/kernel
into a web browser.  The address changes to:

  http://ftp.uk.kernel.org/sites/ftp.kernel.org/pub/linux/kernel/

Hit reload a few times, and eventually be greated by:

Forbidden
You don't have permission to access /sites/ftp.kernel.org/pub/linux/kernel/ on this server.

because one of the IPs which "ftp.uk.kernel.org" resolves to isn't a
part of the UK mirror service (who are providing most of ftp.uk.kernel.org),
and therefore has a different site policy.

Ergo, downloads via http from ftp.uk.kernel.org are at best unreliable
for multiple requests.

I agree that it's not directly your problem, and isn't something you
have direct control over.  However, if you want to round-robin the
<cc>.kernel.org IP addresses between different providers, I suggest
that either the name resolves to just one site, or that kernel.org
adopts a policy with their mirrors that they only become part of
the <cc>.kernel.org DNS entries as long as they do not rewrite their
site-specific URLs in terms of that address.

IOW, that URL above should've been:

  http://hawking-if-b.mirrorservice.org/sites/ftp.kernel.org/pub/linux/kernel/

to ensure that mirrorservice.org's policy isn't uselessly applied to
someone elses mirror site.

Maybe then ftp.<cc>.kernel.org would become slightly more attractive.

* - I gave up with ftp.uk.kernel.org many years ago when it became
unreliable and haven't looked back, despite recent news that it's
improved.  But as illustrated above it does still have issues.  I
certainly would _not_ want to use ftp.uk.linux.org to obtain GIT
updates from as long as the current DNS situation persists - that
would be suicide.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
