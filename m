Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWJRGfF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWJRGfF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 02:35:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWJRGfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 02:35:05 -0400
Received: from holoclan.de ([62.75.158.126]:25241 "EHLO mail.holoclan.de")
	by vger.kernel.org with ESMTP id S1751440AbWJRGfE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 02:35:04 -0400
Date: Wed, 18 Oct 2006 08:34:31 +0200
From: Martin Lorenz <martin@lorenz.eu.org>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: un/shared IRQ problem (was: Re: 2.6.18 - another DWARF2)
Message-ID: <20061018063431.GE20238@gimli>
Mail-Followup-To: Jesse Brandeburg <jesse.brandeburg@gmail.com>,
	linux-kernel@vger.kernel.org
References: <20061017063710.GA27139@gimli> <4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0610171152tfea31c1v3f907dcaf0a58509@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "www.holoclan.de", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  On Tue, Oct 17, 2006 at 11:52:16AM -0700, Jesse
	Brandeburg wrote: > On 10/16/06, Martin Lorenz <martin@lorenz.eu.org>
	wrote: > >just got the following on resume: > > > >[87026.706000]
	[<c0251745>] e1000_open+0xcd/0x1a4 > >[87026.714000] DWARF2 unwinder
	stuck at syscall_call+0x7/0xb > >[87026.715000] Leftover inexact
	backtrace: > >[87026.715000] e1000: eth0: e1000_request_irq: Unable to
	allocate interrupt > >Error: -16 > > I'm pretty sure this isn't an e1000
	problem. you need to talk to > whoever is maintaining the IRQ subsystem
	for x86. E1000 is attempting > to register a shared interrupt and
	someone has already registered that > interrupt unshared. [...] 
	Content analysis details:   (-1.4 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2006 at 11:52:16AM -0700, Jesse Brandeburg wrote:
> On 10/16/06, Martin Lorenz <martin@lorenz.eu.org> wrote:
> >just got the following on resume:
> >
> >[87026.706000]  [<c0251745>] e1000_open+0xcd/0x1a4
> >[87026.714000] DWARF2 unwinder stuck at syscall_call+0x7/0xb
> >[87026.715000] Leftover inexact backtrace:
> >[87026.715000] e1000: eth0: e1000_request_irq: Unable to allocate interrupt
> >Error: -16
> 
> I'm pretty sure this isn't an e1000 problem.  you need to talk to
> whoever is maintaining the IRQ subsystem for x86.  E1000 is attempting
> to register a shared interrupt and someone has already registered that
> interrupt unshared.

interestingly though it always involves e1000 when I see dumps like this.
I already reported more of those :-)
this one dosen't seem to do any harm to system stability. it occurs on every
suspend/resume and I can circumvent it by disabling msi

> 
> looks like several devices are sharing IRQ 201 (aka GSI 16) and ahci
> or usb uhci_hcd is likely the problem, or the (acpi) power management
> subsystem.
> 
> Hope this helps get the right people involved.

thank you

gruss
  mlo
--
Dipl.-Ing. Martin Lorenz

            They that can give up essential liberty 
	    to obtain a little temporary safety 
	    deserve neither liberty nor safety.
                                   Benjamin Franklin

please encrypt your mail to me
GnuPG key-ID: F1AAD37D
get it here:
http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0xF1AAD37D

ICQ UIN: 33588107
