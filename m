Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754800AbWKNLNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800AbWKNLNE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 06:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbWKNLND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 06:13:03 -0500
Received: from mx1.suse.de ([195.135.220.2]:46772 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1754812AbWKNLNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 06:13:00 -0500
From: Andi Kleen <ak@suse.de>
To: Suleiman Souhlal <ssouhlal@freebsd.org>
Subject: Re: [PATCH 1/2] Make the TSC safe to be used by gettimeofday().
Date: Tue, 14 Nov 2006 12:12:40 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
References: <455916A5.2030402@FreeBSD.org> <200611140344.00407.ak@suse.de> <45593DD8.80301@FreeBSD.org>
In-Reply-To: <45593DD8.80301@FreeBSD.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141212.40978.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I initially had it after the HLT in the idle loop, but realized there 
> would be a small race: We could get switched away from the idle thread 
> after the HLT but before doing the resynch.

idle threads are pinned to CPUs of course.

> It seems like idle notifiers would do the trick, except that they don't 
> appear to include the id of the CPU that went/exited from idle.

Just use smp_processor_id() 
 
> Does the LSL from the magic GDT entry return the APIC ID or the 
> smp_processor_id?

smp_processor_id

> Another way I could fix this would be to just touch the seqlock, in 
> switch_to(), if we happen to be in vgettimeofday. Would this be acceptable?

Hmm, i'm not sure that would cover all cases with multiple cpu switches.
You would need to do it for all CPUs, which might get tricky.
I would also prefer to not do anything complicated in switch_to

-Andi
