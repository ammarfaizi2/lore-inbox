Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWFHFpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWFHFpA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 01:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbWFHFpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 01:45:00 -0400
Received: from ns2.suse.de ([195.135.220.15]:32473 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932521AbWFHFo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 01:44:59 -0400
From: Andi Kleen <ak@suse.de>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: 2.6.17-rc6-mm1
Date: Thu, 8 Jun 2006 07:43:44 +0200
User-Agent: KMail/1.9.3
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kraxel@suse.de,
       jamagallon@ono.com
References: <20060607104724.c5d3d730.akpm@osdl.org> <p73irnctmcc.fsf@verdi.suse.de> <20060607194640.19f41f52.rdunlap@xenotime.net>
In-Reply-To: <20060607194640.19f41f52.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200606080743.44168.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 08 June 2006 04:46, Randy.Dunlap wrote:
> On 08 Jun 2006 04:25:39 +0200 Andi Kleen wrote:
> 
> > Andrew Morton <akpm@osdl.org> writes:
> > 
> > > On Thu, 8 Jun 2006 00:31:53 +0200
> > > "J.A. Magallón" <jamagallon@ono.com> wrote:
> > > 
> > > > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
> > > > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
> > > > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)
> > > 
> > > Yes, that's a false positive - doing locking from within an __init section.
> > > We need to shut that up somehow.
> > 
> > Are you sure it's false? 
> > 
> > I don't see an explicit check in alternatives.c for the main kernel
> > vs init sections and with CPU hotplug the alternatives can be applied
> > arbitarily after the system has booted.  So it would just stomp
> > over the init text pages which are used for something else now.
> > 
> > I guess to make it safe you would need to teach alternative.c to
> > ignore init sections.
> 
> for i386 (arch/i386/alternative.c and module.c):
> 
> static void alternatives_smp_lock(u8 **start, u8 **end, u8 *text, u8 *text_end)
> {...}
> 
> only replaces code between text and text_end.


You're right - for smp_lock it should be ok, but for other alternatives() 
there is no such check. But then they are ok because they shouldn't change
after bootup.

I retract the objection.

> I've cced Gerd on this before.  Maybe you can get her to repsond
> to confirm or deny.

Him.

-Andi
 
