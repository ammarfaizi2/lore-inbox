Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWFZB3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWFZB3M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 21:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWFZB3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 21:29:12 -0400
Received: from mga02.intel.com ([134.134.136.20]:33870 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S964972AbWFZB3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 21:29:10 -0400
X-IronPort-AV: i="4.06,173,1149490800"; 
   d="scan'208"; a="56504481:sNHT17910816"
Subject: Re: [PATCH] swsuspend breakage in 2.6.17-git
From: Shaohua Li <shaohua.li@intel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Ritz <daniel.ritz-ml@swissonline.ch>, Pavel Machek <pavel@ucw.cz>,
       "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606250943580.3747@g5.osdl.org>
References: <200606251605.10956.daniel.ritz-ml@swissonline.ch>
	 <Pine.LNX.4.64.0606250943580.3747@g5.osdl.org>
Content-Type: text/plain
Date: Mon, 26 Jun 2006 09:26:53 +0800
Message-Id: <1151285213.21189.28.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-25 at 09:46 -0700, Linus Torvalds wrote:
> 
> On Sun, 25 Jun 2006, Daniel Ritz wrote:
> > 
> > commit b6370d96e09944c6e3ae8d5743ca8a8ab1f79f6c:
> > 	[PATCH] swsusp: i386 mark special saveable/unsaveable pages
> > breaks swsusp for me with a page fault in kernel/power/snapshot.c:save_arch_mem()
> > 
> > the following patch makes suspend-resume working again, but some
> > problems still remain: fan goes on and stays on after resume (same as
> > in bug #5000). i guess this is a due to a change in ACPI which i still
> > have to track down along with the problem that acpi is not powering-off
> > my other laptop anymore...
> > 
> > comments?
> 
> Looking at that whole commit, it looks bogus.
> 
> The rule about ACPI memory (whether NVS or not) according to what I have 
> seen is that the OS is _not_ supposed to touch that memory except through 
> ACPI routines.
> 
> So saving and restoring those pages sounds really really wrong in the 
> first place. We have no idea what current state it could screw up.
Below is from ACPI spec 3.0 (p405). From my understanding, OS should
save/restore NVS memory ?

ACPI Non-Volatile-Sleeping Memory (NVS). Memory identified by the BIOS
as being reserved by the BIOS for its use. OSPM is required to tag this
memory as cacheable, and to save and restore its image before entering
an S4 state. Except as directed by control methods, OSPM is not allowed
to use this physical memory. OSPM will call the _PTS control method some
time before entering a sleeping state, to allow the platforms AML code
to update this memory image before entering the sleeping state. After
the system awakes from an S4 state, OSPM will restore this memory area
and call the _WAK control method to enable the BIOS to reclaim its
memory image.

Thanks,
Shaohua
