Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbVI2W3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbVI2W3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 18:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932299AbVI2W3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 18:29:37 -0400
Received: from fmr23.intel.com ([143.183.121.15]:4551 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932150AbVI2W3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 18:29:36 -0400
Date: Thu, 29 Sep 2005 15:29:14 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Message-ID: <20050929152914.A15943@unix-os.sc.intel.com>
References: <200509281624.29256.rjw@sisk.pl> <200509282224.43397.rjw@sisk.pl> <20050928170031.D30088@unix-os.sc.intel.com> <200509300001.10258.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200509300001.10258.rjw@sisk.pl>; from rjw@sisk.pl on Fri, Sep 30, 2005 at 12:01:08AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 12:01:08AM +0200, Rafael J. Wysocki wrote:
> On Thursday, 29 of September 2005 02:00, Siddha, Suresh B wrote:
> > 
> > My patch as such shouldn't change the behavior of the existing swsup
> > code. I am making only boot_level4_pgt as initdata. But not the 
> > init_level4_pgt.
> 
> Suresh, unfortunately the kernel does not boot with your patch, because

Did you try just only my patch on top of 2.6.14-rc2? You can get that
patch from http://www.x86-64.org/lists/discuss/msg07313.html

> it clears init_level4_pgt.

what is wrong with zapping low mappings? Looks like someother change
you are trying assumes that low mappings are always present in init_level4_pgt,
which is wrong..

> +++ linux-2.6.14-rc2-git7/arch/x86_64/mm/init.c	2005-09-29 22:13:55.000000000 +0200
> @@ -313,7 +313,7 @@
>  void __cpuinit zap_low_mappings(int cpu)
>  {
>  	if (cpu == 0) {
> -		pgd_t *pgd = pgd_offset_k(0UL);
> +		pgd_t *pgd = boot_level4_pgt;
>  		pgd_clear(pgd);

Don't do this. Its wrong.

Please send me your patch that you are having problems with. I can take 
a look at it.

thanks,
suresh
