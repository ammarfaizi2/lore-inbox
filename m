Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161331AbWJSG0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161331AbWJSG0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 02:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161333AbWJSG0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 02:26:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161331AbWJSG0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 02:26:16 -0400
Date: Wed, 18 Oct 2006 23:26:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Lorenz <martin@lorenz.eu.org>
Cc: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
       linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: un/shared IRQ problem (was: Re: 2.6.18 - another DWARF2)
Message-Id: <20061018232603.585d14c3.akpm@osdl.org>
In-Reply-To: <20061018063431.GE20238@gimli>
References: <20061017063710.GA27139@gimli>
	<4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com>
	<20061018063431.GE20238@gimli>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2006 08:34:31 +0200
Martin Lorenz <martin@lorenz.eu.org> wrote:

> On Tue, Oct 17, 2006 at 11:52:16AM -0700, Jesse Brandeburg wrote:
> > On 10/16/06, Martin Lorenz <martin@lorenz.eu.org> wrote:
> > >just got the following on resume:
> > >
> > >[87026.706000]  [<c0251745>] e1000_open+0xcd/0x1a4
> > >[87026.714000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> > >[87026.715000] Leftover inexact backtrace:
> > >[87026.715000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
> > >Error: -16
> > 
> > I'm pretty sure this isn't an e1000 problem.  you need to talk to
> > whoever is maintaining the IRQ subsystem for x86.  E1000 is attempting
> > to register a shared interrupt and someone has already registered that
> > interrupt unshared.
> 
> interestingly though it always involves e1000 when I see dumps like this.
> I already reported more of those :-)
> this one dosen't seem to do any harm to system stability. it occurs on every
> suspend/resume and I can circumvent it by disabling msi
> 
> > 
> > looks like several devices are sharing IRQ 201 (aka GSI 16) and ahci
> > or usb uhci_hcd is likely the problem, or the (acpi) power management
> > subsystem.
> > 
> > Hope this helps get the right people involved.
> 
> thank you

Could we see the /proc/interrupts please, so we can find out where the
clash is happening?
