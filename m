Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWGCFrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWGCFrk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 01:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWGCFrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 01:47:40 -0400
Received: from xenotime.net ([66.160.160.81]:15594 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751352AbWGCFrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 01:47:39 -0400
Date: Sun, 2 Jul 2006 22:50:24 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: akpm@osdl.org, rjw@sisk.pl, davej@redhat.com, linux-kernel@vger.kernel.org,
       sekharan@us.ibm.com, rusty@rustcorp.com.au, sam@ravnborg.org
Subject: Re: 2.6.17-mm2
Message-Id: <20060702225024.73c7fe91.rdunlap@xenotime.net>
In-Reply-To: <20060702101146.GA26924@flint.arm.linux.org.uk>
References: <20060624061914.202fbfb5.akpm@osdl.org>
	<20060624172014.GB26273@redhat.com>
	<20060624143440.0931b4f1.akpm@osdl.org>
	<200606251051.55355.rjw@sisk.pl>
	<20060625032243.fcce9e2e.akpm@osdl.org>
	<20060625081610.9b0a775a.akpm@osdl.org>
	<20060630003813.e1003a93.rdunlap@xenotime.net>
	<20060702101146.GA26924@flint.arm.linux.org.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jul 2006 11:11:46 +0100 Russell King wrote:

> On Fri, Jun 30, 2006 at 12:38:13AM -0700, Randy.Dunlap wrote:
> > Until modpost (or whatever) can do this, here are a few that
> > a shell script has found for me by examing source code only --
> > may contain some false reports:
> > 
...
> > ./arch/arm/mach-imx/generic.c:196:EXPORT_SYMBOL(imx_set_mmc_info);
> > ./arch/arm/mach-imx/generic.c:192:void __init imx_set_mmc_info(struct imxmmc_platform_data *info)
> > 
> > ./arch/arm/mach-imx/generic.c:204:EXPORT_SYMBOL(set_imx_fb_info);
> > ./arch/arm/mach-imx/generic.c:200:void __init set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info)
> >
> These are definitely buggy.

Um, well, I could blindly remove those __init sections, but in
looking at the code, set_imx_fb_info() is not ever used, and
imx_set_mmc_info() is called from some __init code...

It looks like this code can only be built-in, not as a loadable
module.  (so someone who knows it should jump in here)
If that's correct, then the EXPORT_SYMBOL() isn't even needed
and the function can remain as __init (right?).

---
~Randy
