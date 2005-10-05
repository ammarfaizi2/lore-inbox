Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbVJEWxA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbVJEWxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 18:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030409AbVJEWxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 18:53:00 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32902 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030413AbVJEWxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 18:53:00 -0400
Date: Thu, 6 Oct 2005 00:49:59 +0200
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: discuss@x86-64.org, Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][Fix] swsusp: avoid possible page tables corruption during resume on x86-64
Message-ID: <20051005224959.GB22781@elf.ucw.cz>
References: <200510011813.54755.rjw@sisk.pl> <200510041909.00714.ak@suse.de> <200510052344.52198.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510052344.52198.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Summary =========
> The following patch makes swsusp avoid the possible temporary corruption of
> page translation tables during resume on x86-64.  This is achieved by creating
> a copy of the relevant page tables that will not be modified by swsusp and can
> be safely used by it on resume.

Andi, this means swsusp fails 50% of time on x86-64. I believe we even
have one report in suse bugzilla by now... Could we get this somehow
merged?


> Index: linux-2.6.14-rc3-git5/kernel/power/swsusp.c
> ===================================================================
> --- linux-2.6.14-rc3-git5.orig/kernel/power/swsusp.c	2005-10-05 21:12:41.000000000 +0200
> +++ linux-2.6.14-rc3-git5/kernel/power/swsusp.c	2005-10-05 21:24:50.000000000 +0200
> @@ -672,7 +672,6 @@
>  		return 0;
>  
>  	page = pfn_to_page(pfn);
> -	BUG_ON(PageReserved(page) && PageNosave(page));
>  	if (PageNosave(page))
>  		return 0;
>  	if (PageReserved(page) && pfn_is_nosave(pfn)) {

Rafael, are you sure? This will clash with snapshot.c split and
probably belongs to some other patch.
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
