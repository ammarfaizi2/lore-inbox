Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVLMAar@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVLMAar (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVLMAar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:30:47 -0500
Received: from cantor2.suse.de ([195.135.220.15]:12176 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932265AbVLMAaq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:30:46 -0500
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch 2/4] i386/x86-64: Implement fallback for PCI mmconfig to type1
References: <20051212192030.873030000@press.kroah.org>
	<20051212200123.GC27657@kroah.com>
	<20051212202643.GG9286@parisc-linux.org>
	<20051212211553.GA29112@suse.de>
From: Andi Kleen <ak@suse.de>
Date: 12 Dec 2005 22:02:19 -0700
In-Reply-To: <20051212211553.GA29112@suse.de>
Message-ID: <p734q5da8tg.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry Greg, Linus,

I also submitted the two PCI patches on my own with the x86-64
patchkit, hopefully the duplication doesn't cause too much trouble.

Greg KH <gregkh@suse.de> writes:
> 
> From what I can tell, it's too late in the callstack for us to change
> the read ops for this device to be the other one.  The problem is (and
> Andi can correct me if I'm wrong), some boxes basically have incomplete
> MCFG acpi tables (the tables do not describe all PCI busses that are
> present in the box).  But we don't realize this until we are about to do
> the read function.

It can happen with perfectly legal MCFG tables. If a bus is not listed
in MCFG then we must fallback to type1. This happens on AMD K8 systems
because the busses in the builtin northbridge don't support mmconfig,
only busses on external bridges do. In theory it could happen on
other systems too (although external northbridges typically support
mmconfig for everything if they do at all) 

In addition we have some boxes with broken MCFG tables who don't get
the tables right, this is what the next patch was trying to fix.

> I remember I looked into trying to set this up at probe/init time, and
> it was almost impossible to do so, due to the structure of the code.

Yes, I also didn't see an easy way to do it, although it would be probably DTRT. 

-Andi
