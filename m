Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030466AbVLHF0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030466AbVLHF0j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:26:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030467AbVLHF0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:26:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:65002 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030466AbVLHF0i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:26:38 -0500
Date: Thu, 8 Dec 2005 06:26:32 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: for_each_online_cpu broken ?
Message-ID: <20051208052632.GF11190@wotan.suse.de>
References: <20051208050738.GE24356@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208050738.GE24356@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 12:07:39AM -0500, Dave Jones wrote:
> Whilst debugging a memory leak, I hit sysrq meminfo,
> and got hot/cold info for CONFIG_NR_CPUS rather than 4 cpus
> I fixed a bug recently in mm/page_alloc.c to change this from
> a for_each_cpu to a for_each_online_cpu and I'm pretty certain
> I tested that it worked, but for reasons unknown, it's now
> misbehaving again.
> 
> I've only tried reproducing this on x86-64 so far.

If the online map is wrong all kinds of things would go wrong.

Most likely your kernel doesn't have the fix.

The possible map is fixed kind of BTW in 2.6.15rc*. It was a side effect
of CPU hotplug, which now uses a better algorithm to guess the 
number of possible CPUs. In 2.6.15 you will just get half the number
of available CPUs in addition by default

-Andi
