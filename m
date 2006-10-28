Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWJ1Ff7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWJ1Ff7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 01:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWJ1Ff7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 01:35:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35515 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751840AbWJ1Ff6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 01:35:58 -0400
Date: Fri, 27 Oct 2006 22:32:28 -0700
From: Andrew Morton <akpm@osdl.org>
To: Grant Grundler <grundler@parisc-linux.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>,
       Greg KH <greg@kroah.com>, Stephen Hemminger <shemminger@osdl.org>,
       Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [patch] drivers: wait for threaded probes between initcall
 levels
Message-Id: <20061027223228.e1679147.akpm@osdl.org>
In-Reply-To: <20061027221925.1041cc5e.akpm@osdl.org>
References: <20061027012058.GH5591@parisc-linux.org>
	<20061026182838.ac2c7e20.akpm@osdl.org>
	<20061026191131.003f141d@localhost.localdomain>
	<20061027170748.GA9020@kroah.com>
	<20061027172219.GC30416@elf.ucw.cz>
	<20061027113908.4a82c28a.akpm@osdl.org>
	<20061027114144.f8a5addc.akpm@osdl.org>
	<20061027114237.d577c153.akpm@osdl.org>
	<1161989970.16839.45.camel@localhost.localdomain>
	<20061027160626.8ac4a910.akpm@osdl.org>
	<20061028050905.GB5560@colo.lackof.org>
	<20061027221925.1041cc5e.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 22:19:25 -0700
Andrew Morton <akpm@osdl.org> wrote:

> The simplest implementation of "A needs B to have run" is for A to simply
> call B, and B arranges to not allow itself to be run more than once.
> 
> But that doesn't work in the case "A needs B to be run, but only if B is
> present".  Resolving this one would require something like a fancy
> "synchronisation object" against which dependers and dependees can register
> interest, and a core engine which takes care of the case where a depender
> registers against something which no dependees have registered.

otoh, we could stick with the simple "A calls B" solution, and A also
provides an attribute-weak implementation of B to cover the "A needs B but
only if B is present" problems.

Had to say, really - one would need to study some specific problem cases.
