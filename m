Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262237AbVAOIAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbVAOIAF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 03:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbVAOIAE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 03:00:04 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:58272 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262237AbVAOH7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 02:59:48 -0500
Date: Sat, 15 Jan 2005 08:59:46 +0100
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       manpreet@fabric7.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       discuss@x86-64.org
Subject: Re: [PATCH] i386/x86-64: Fix timer SMP bootup race
Message-ID: <20050115075946.GA28981@wotan.suse.de>
References: <20050115040951.GC13525@wotan.suse.de> <1105765760.12263.12.camel@localhost.localdomain> <20050115052311.GC22863@wotan.suse.de> <1105774495.12263.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1105774495.12263.21.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2005 at 06:34:54PM +1100, Rusty Russell wrote:
> > I shortly considered redoing the boot process, but then it looked 
> > too risky to me. 
> > 
> > e.g. I guess on x86-64 it wouldn't be that difficult, just a bit of work,
> > but on i386 with all the weird hardware it could be quite destabilizing.
> > But doing it on x86-64 only is not a good solution.
> 
> Well, architectures which support CPU hotplug have had to fix their boot
> process anyway, and most are fairly trivial.

The problem is not doing the work, but testing it.

> > If you had done it properly in 2.5 it would be working and tested
> > by now ;-) , but doing it in the middle of 2.6 would seem a bit misplaced
> > to me.
> 
> Linus would not have taken the patch, because it would have broken too
> much.  Cleaning up the x86 boot sequence is a project in itself, which
> needs to be done, but not by me 8)

I think my patch is better. It at least keeps all the 
baggage out of the normal run paths. Doing this check at each timer interrupt
doesn't make much sense.

-Andi
