Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWHaQL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWHaQL7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 12:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHaQL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 12:11:59 -0400
Received: from gw.goop.org ([64.81.55.164]:2221 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932351AbWHaQL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 12:11:58 -0400
Message-ID: <44F70A4B.4090803@goop.org>
Date: Thu, 31 Aug 2006 09:11:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: cpu_init is called during resume
References: <20060831135545.GM3923@elf.ucw.cz>
In-Reply-To: <20060831135545.GM3923@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> cpu_init() is called during resume, at time when GFP_KERNEL is not
> available. This silences warning, and adds few small cleanups.
>   

I presume this is resume from disk.  If you're doing resume from RAM, 
all the CPU-related stuff should already be allocated, unless you're 
bringing up a new CPU which wasn't previously there, right?

What's the call path for this on resume?  In my i386-pda patches, I've 
rearranged this so that the secondary CPU's GDT (and PDA) are 
pre-allocated on the boot CPU.  Does this help this case, or would they 
still need to be atomic allocations?

And wouldn't making these allocations atomic make real CPU hotplug (ie, 
on an active, running system) more likely to fail?  This code doesn't 
deal with allocation failure very elegantly.

    J
