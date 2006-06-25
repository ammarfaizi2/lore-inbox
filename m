Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWFYQqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWFYQqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 12:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWFYQqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 12:46:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751168AbWFYQqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 12:46:19 -0400
Date: Sun, 25 Jun 2006 09:46:09 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
cc: Shaohua Li <shaohua.li@intel.com>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] swsuspend breakage in 2.6.17-git
In-Reply-To: <200606251605.10956.daniel.ritz-ml@swissonline.ch>
Message-ID: <Pine.LNX.4.64.0606250943580.3747@g5.osdl.org>
References: <200606251605.10956.daniel.ritz-ml@swissonline.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Jun 2006, Daniel Ritz wrote:
> 
> commit b6370d96e09944c6e3ae8d5743ca8a8ab1f79f6c:
> 	[PATCH] swsusp: i386 mark special saveable/unsaveable pages
> breaks swsusp for me with a page fault in kernel/power/snapshot.c:save_arch_mem()
> 
> the following patch makes suspend-resume working again, but some
> problems still remain: fan goes on and stays on after resume (same as
> in bug #5000). i guess this is a due to a change in ACPI which i still
> have to track down along with the problem that acpi is not powering-off
> my other laptop anymore...
> 
> comments?

Looking at that whole commit, it looks bogus.

The rule about ACPI memory (whether NVS or not) according to what I have 
seen is that the OS is _not_ supposed to touch that memory except through 
ACPI routines.

So saving and restoring those pages sounds really really wrong in the 
first place. We have no idea what current state it could screw up.

Shaohua?

		Linus
