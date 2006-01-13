Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161330AbWAMA4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161330AbWAMA4U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:56:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWAMA4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:56:20 -0500
Received: from fmr20.intel.com ([134.134.136.19]:38817 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030428AbWAMA4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:56:18 -0500
Subject: Re: soft lockup detected in acpi_processor_idle() -- false
	positive?
From: Shaohua Li <shaohua.li@intel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
In-Reply-To: <200601122054.14128.rjw@sisk.pl>
References: <20060112184305.GA7068@isilmar.linta.de>
	 <200601122054.14128.rjw@sisk.pl>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 08:55:24 +0800
Message-Id: <1137113724.5750.113.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 20:54 +0100, Rafael J. Wysocki wrote:
> On Thursday, 12 January 2006 19:43, Dominik Brodowski wrote:
> > Latest git, fresh after resuming from suspend-to-disk (in-kernel variant):
> > 
> > [4294914.586000] Restarting tasks... done
> > [4294922.657000] BUG: soft lockup detected on CPU#0!
> > [4294922.657000] 
> > [4294922.657000] Pid: 0, comm:              swapper
> > [4294922.657000] EIP: 0060:[<f003084c>] CPU: 0
> > [4294922.657000] EIP is at acpi_processor_idle+0x1f3/0x2d5 [processor]
> > [4294922.657000]  EFLAGS: 00000282    Not tainted  (2.6.15)
> > [4294922.657000] EAX: fffff000 EBX: 005543a8 ECX: 00000000 EDX: 00000000
> > [4294922.657000] ESI: edcc3064 EDI: edcc2f60 EBP: c041cfdc DS: 007b ES: 007b
> > [4294922.657000] CR0: 8005003b CR2: 080c3000 CR3: 2d530000 CR4: 000006d0
> > 
> > 
> > As acpi_processor_idle doesn't take any locks AFAIK, it seems to me to be a
> > false positive -- or do I miss something obvious?
> 
> I think it's a false-positive.
> 
> This "soft lockup" message has been appearing for me for quite some time now
> (actually since the softlockup patch made it into -mm ;-)), in a
> non-reproducible manner, but I haven't been able to nail it down.
> 
> Still, I thought it was x86-64-specific, but your machine is an i386,
> so there's more to it, apparently.  Probably there's missing
> touch_softlockup_watchdog() somewhere, or the timer .suspend()/.resume()
> routines need some additional review.
I got some similar reports for S3:
http://bugzilla.kernel.org/show_bug.cgi?id=5825
I guess x86-64 lacks .suspend/.resume for timer. Last time I looked at
such issue in ia32, and I fixed it, but I didn't fix x86-64.

Thanks,
Shaohua

