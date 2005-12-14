Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbVLNWaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVLNWaU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVLNWaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:30:20 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9489 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965031AbVLNWaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:30:17 -0500
Date: Wed, 14 Dec 2005 22:30:03 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20051214223003.GA31955@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Adrian Bunk <bunk@stusta.de>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <20051214142216.57d1900a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214142216.57d1900a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 02:22:16PM -0800, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> >
> > CC_OPTIMIZE_FOR_SIZE is still an experimental feature that doesn't work 
> > with all supported gcc/architecture combinations.
> > 
> > 
> > Signed-off-by: Adrian Bunk <bunk@stusta.de>
> > 
> > --- linux-git/init/Kconfig.old	2005-12-14 23:08:51.000000000 +0100
> > +++ linux-git/init/Kconfig	2005-12-14 23:09:09.000000000 +0100
> > @@ -257,7 +257,7 @@
> >  source "usr/Kconfig"
> >  
> >  config CC_OPTIMIZE_FOR_SIZE
> > -	bool "Optimize for size"
> > +	bool "Optimize for size (EXPERIMENTAL)" if EXPERIMENTAL
> >  	default y if ARM || H8300
> >  	help
> >  	  Enabling this option will pass "-Os" instead of "-O2" to gcc
> 
> This will cause arm and h8300 to accidentally stop using -Os if they have
> !EXPERIMENTAL.

In effect, the total change effectively replaces EMBEDDED with
EXPERIMENTAL - since the original was:

        bool "Optimize for size" if EMBEDDED

and that had the desired result for ARM with the !EMBEDDED case.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
