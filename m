Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbTILSBD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 14:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTILSBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 14:01:03 -0400
Received: from ns.suse.de ([195.135.220.2]:36225 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261765AbTILSA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 14:00:58 -0400
To: jbarnes@sgi.com (Jesse Barnes)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
References: <20030911192550.7dfaf08c.ak@suse.de.suse.lists.linux.kernel>
	<1063308053.4430.37.camel@huykhoi.suse.lists.linux.kernel>
	<20030912162713.GA4852@sgi.com.suse.lists.linux.kernel>
	<20030912174807.GA629@sgi.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Sep 2003 20:00:03 +0200
In-Reply-To: <20030912174807.GA629@sgi.com.suse.lists.linux.kernel>
Message-ID: <p73y8wtlwf0.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbarnes@sgi.com (Jesse Barnes) writes:

> Ok, Andi asked for benchmarks, so I ran some.  Let this should be a
> lesson on why you shouldn't use port I/O :)  I ran these on an SGI Altix
> w/900 MHz McKinley processors.
> 
> Just straight calls to the routines (all of these are based on the
> average of 100 iterations):
>   writeq(val, reg) time: 64 cycles
>   outl(val, reg) time: 2126 cycles
                         ^^^^^
> 
> A simple branch:
>   if (use_mmio)
> 	writeq(val, reg) time: 132 cycles
>   else
> 	outl(val, reg) time: 1990 cycles
                             ^^^^^
Something seems to be wrong in your numbers.

Surely the outl in the if () cannot be faster than the pure outl() ?

-Andi

