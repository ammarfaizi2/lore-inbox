Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161224AbWALTwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161224AbWALTwK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161223AbWALTwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:52:09 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:5302 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1161217AbWALTwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:52:08 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: soft lockup detected in acpi_processor_idle() -- false positive?
Date: Thu, 12 Jan 2006 20:54:13 +0100
User-Agent: KMail/1.9
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
References: <20060112184305.GA7068@isilmar.linta.de>
In-Reply-To: <20060112184305.GA7068@isilmar.linta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601122054.14128.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 12 January 2006 19:43, Dominik Brodowski wrote:
> Latest git, fresh after resuming from suspend-to-disk (in-kernel variant):
> 
> [4294914.586000] Restarting tasks... done
> [4294922.657000] BUG: soft lockup detected on CPU#0!
> [4294922.657000] 
> [4294922.657000] Pid: 0, comm:              swapper
> [4294922.657000] EIP: 0060:[<f003084c>] CPU: 0
> [4294922.657000] EIP is at acpi_processor_idle+0x1f3/0x2d5 [processor]
> [4294922.657000]  EFLAGS: 00000282    Not tainted  (2.6.15)
> [4294922.657000] EAX: fffff000 EBX: 005543a8 ECX: 00000000 EDX: 00000000
> [4294922.657000] ESI: edcc3064 EDI: edcc2f60 EBP: c041cfdc DS: 007b ES: 007b
> [4294922.657000] CR0: 8005003b CR2: 080c3000 CR3: 2d530000 CR4: 000006d0
> 
> 
> As acpi_processor_idle doesn't take any locks AFAIK, it seems to me to be a
> false positive -- or do I miss something obvious?

I think it's a false-positive.

This "soft lockup" message has been appearing for me for quite some time now
(actually since the softlockup patch made it into -mm ;-)), in a
non-reproducible manner, but I haven't been able to nail it down.

Still, I thought it was x86-64-specific, but your machine is an i386,
so there's more to it, apparently.  Probably there's missing
touch_softlockup_watchdog() somewhere, or the timer .suspend()/.resume()
routines need some additional review.

Greetings,
Rafael
