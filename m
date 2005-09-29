Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVI2X7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVI2X7Y (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVI2X7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:59:24 -0400
Received: from fmr24.intel.com ([143.183.121.16]:3768 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932386AbVI2X7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:59:24 -0400
Date: Thu, 29 Sep 2005 16:59:06 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>, Andi Kleen <ak@suse.de>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>, discuss@x86-64.org
Subject: Re: [PATCH][Fix][Resend] Fix Bug #4959: Page tables corrupted during resume on x86-64 (take 3)
Message-ID: <20050929165905.B15943@unix-os.sc.intel.com>
References: <200509281624.29256.rjw@sisk.pl> <200509300001.10258.rjw@sisk.pl> <20050929152914.A15943@unix-os.sc.intel.com> <200509300104.36454.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200509300104.36454.rjw@sisk.pl>; from rjw@sisk.pl on Fri, Sep 30, 2005 at 01:04:35AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 01:04:35AM +0200, Rafael J. Wysocki wrote:
> On Friday, 30 of September 2005 00:29, Siddha, Suresh B wrote:
> > Did you try just only my patch on top of 2.6.14-rc2? You can get that
> > patch from http://www.x86-64.org/lists/discuss/msg07313.html
> 
> The patch that I tested is attached.  I think it's the same one.  I've just applied
> it on top of 2.6.14-rc2-git7, and it doesn't boot.

It works fine for me. Only thing I see though is a warning for UP configuration.
Other than that UP, SMP(with and without hotplug) kernels boot fine. I will
send the warning fix to Andrew.

> The problem (as I see it) is this:
> In x86_64_start_kernel() you copy boot_level4_pgt[] into init_level4_pgt[],
> and you make the latter your current PGD by loading cr3 with its address.
> Fine.  With this PGD you call start_kernel() which calls setup_arch(), which
> calls zap_low_mappings(0) that fills init_level4_pgt[] (which at this moment
> is still your current PGD) with zeros ...

It clears only the zeroth entry. Not the whole pgd.

Please send me your .config so that I can try reproducing the issue locally
here.

thanks,
suresh
