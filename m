Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932474AbWFHCny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932474AbWFHCny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932476AbWFHCny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:43:54 -0400
Received: from xenotime.net ([66.160.160.81]:13263 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932474AbWFHCny convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:43:54 -0400
Date: Wed, 7 Jun 2006 19:46:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, kraxel@suse.de,
       jamagallon@ono.com
Subject: Re: 2.6.17-rc6-mm1
Message-Id: <20060607194640.19f41f52.rdunlap@xenotime.net>
In-Reply-To: <p73irnctmcc.fsf@verdi.suse.de>
References: <20060607104724.c5d3d730.akpm@osdl.org>
	<20060608003153.36f59e6a@werewolf.auna.net>
	<20060607154054.cf4f2512.akpm@osdl.org>
	<p73irnctmcc.fsf@verdi.suse.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Jun 2006 04:25:39 +0200 Andi Kleen wrote:

> Andrew Morton <akpm@osdl.org> writes:
> 
> > On Thu, 8 Jun 2006 00:31:53 +0200
> > "J.A. Magallón" <jamagallon@ono.com> wrote:
> > 
> > > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x3c)
> > > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x40)
> > > WARNING: drivers/block/floppy.o - Section mismatch: reference to .init.text: from .smp_locks after '' (at offset 0x44)
> > 
> > Yes, that's a false positive - doing locking from within an __init section.
> > We need to shut that up somehow.
> 
> Are you sure it's false? 
> 
> I don't see an explicit check in alternatives.c for the main kernel
> vs init sections and with CPU hotplug the alternatives can be applied
> arbitarily after the system has booted.  So it would just stomp
> over the init text pages which are used for something else now.
> 
> I guess to make it safe you would need to teach alternative.c to
> ignore init sections.

for i386 (arch/i386/alternative.c and module.c):

static void alternatives_smp_lock(u8 **start, u8 **end, u8 *text, u8 *text_end)
{...}

only replaces code between text and text_end.

I've cced Gerd on this before.  Maybe you can get her to repsond
to confirm or deny.

---
~Randy
