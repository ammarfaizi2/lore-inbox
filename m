Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964954AbWAMLPB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbWAMLPB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 06:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964923AbWAMLPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 06:15:00 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:33211 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964897AbWAMLO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 06:14:59 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Shaohua Li <shaohua.li@intel.com>
Subject: Re: soft lockup detected in acpi_processor_idle() -- false positive?
Date: Fri, 13 Jan 2006 12:17:04 +0100
User-Agent: KMail/1.9
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Pavel Machek <pavel@suse.cz>
References: <20060112184305.GA7068@isilmar.linta.de> <200601122054.14128.rjw@sisk.pl> <1137113724.5750.113.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1137113724.5750.113.camel@sli10-desk.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131217.05512.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 13 January 2006 01:55, Shaohua Li wrote:
> On Thu, 2006-01-12 at 20:54 +0100, Rafael J. Wysocki wrote:
> > On Thursday, 12 January 2006 19:43, Dominik Brodowski wrote:
> > > Latest git, fresh after resuming from suspend-to-disk (in-kernel variant):
> > > 
> > > [4294914.586000] Restarting tasks... done
> > > [4294922.657000] BUG: soft lockup detected on CPU#0!
> > > [4294922.657000] 
> > > [4294922.657000] Pid: 0, comm:              swapper
> > > [4294922.657000] EIP: 0060:[<f003084c>] CPU: 0
> > > [4294922.657000] EIP is at acpi_processor_idle+0x1f3/0x2d5 [processor]
> > > [4294922.657000]  EFLAGS: 00000282    Not tainted  (2.6.15)
> > > [4294922.657000] EAX: fffff000 EBX: 005543a8 ECX: 00000000 EDX: 00000000
> > > [4294922.657000] ESI: edcc3064 EDI: edcc2f60 EBP: c041cfdc DS: 007b ES: 007b
> > > [4294922.657000] CR0: 8005003b CR2: 080c3000 CR3: 2d530000 CR4: 000006d0
> > > 
> > > 
> > > As acpi_processor_idle doesn't take any locks AFAIK, it seems to me to be a
> > > false positive -- or do I miss something obvious?
> > 
> > I think it's a false-positive.
> > 
> > This "soft lockup" message has been appearing for me for quite some time now
> > (actually since the softlockup patch made it into -mm ;-)), in a
> > non-reproducible manner, but I haven't been able to nail it down.
> > 
> > Still, I thought it was x86-64-specific, but your machine is an i386,
> > so there's more to it, apparently.  Probably there's missing
> > touch_softlockup_watchdog() somewhere, or the timer .suspend()/.resume()
> > routines need some additional review.
> I got some similar reports for S3:
> http://bugzilla.kernel.org/show_bug.cgi?id=5825
> I guess x86-64 lacks .suspend/.resume for timer.

No, it doesn't.  They are similar to i386 ones.

Greetings,
Rafael
