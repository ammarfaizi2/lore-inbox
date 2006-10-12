Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422855AbWJLQFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422855AbWJLQFz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 12:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWJLQFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 12:05:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:60255 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422855AbWJLQFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 12:05:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=UCWSl4j8MPAx5dw+DPrY94ia6FaHS/MamMquxov9UG0i7hlOQ1Crb1s+IExvM0rZtSeSXotUhg3+ZAu7QfI3euHJ0bEiofRLhLnl5qTDjrGEJayQQulFhn9rnspIJliyc/lW3k3bstwfklf1GFJQ8l17e3dzw7Fi+Rytkrlo1YI=
Date: Thu, 12 Oct 2006 18:05:53 +0200
From: Luca Tettamanti <kronos.it@gmail.com>
To: Andreas Schwab <schwab@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2.6.19-rc1] radeonfb: check return value of sysfs_create_bin_file
Message-ID: <20061012160553.GA7382@dreamland.darkstar.lan>
References: <20061011235328.GA13264@dreamland.darkstar.lan> <1160611646.4792.24.camel@localhost.localdomain> <20061012154505.GA6014@dreamland.darkstar.lan> <jey7rlo7g0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jey7rlo7g0.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Thu, Oct 12, 2006 at 05:54:55PM +0200, Andreas Schwab ha scritto: 
> Luca Tettamanti <kronos.it@gmail.com> writes:
> 
> > Il Thu, Oct 12, 2006 at 10:07:26AM +1000, Benjamin Herrenschmidt ha scritto: 
> >> On Thu, 2006-10-12 at 01:53 +0200, Luca Tettamanti wrote:
> >> > sysfs_create_bin_file() is marked as warn_unused_result but we don't
> >> > actually check the return value.
> >> > Error is not fatal, the driver can operate fine without the files so
> >> > just print a notice on failure.
> >> 
> >> I find this whole business of must check return value for sysfs files to
> >> be gratuitous bloat. There are many cases (like this one) where we don't
> >> really care and a printk will just increase the kernel size for no good
> >> reason.
> >> 
> >> Maybe we can have a macro we can use to silence the warning when we
> >> don't care about the result ? Can gcc do that ?
> >
> > Ugly macro:
> >
> > #define UNCHECKED(func) do { if (func) {} } while(0)
> 
> Better, but only marginally:
> 
> #define UNCHECKED(func) (void)(func)

Nope, I tried[1] before sending the mail ;) warn_unused_result requires
that you _use_ the result.

Luca
[1] kronos:~$ gcc --version
gcc (GCC) 4.1.2 20061007 (prerelease) (Debian 4.1.1-16)
-- 
"It is more complicated than you think"
                -- The Eighth Networking Truth from RFC 1925
