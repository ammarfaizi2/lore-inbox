Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUBYW54 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 17:57:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbUBYWyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 17:54:43 -0500
Received: from gprs151-5.eurotel.cz ([160.218.151.5]:14724 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261622AbUBYWwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 17:52:12 -0500
Date: Wed, 25 Feb 2004 23:51:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: John Lee <johnl@aurema.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] O(1) Entitlement Based Scheduler
Message-ID: <20040225225159.GA1906@elf.ucw.cz>
References: <Pine.GSO.4.03.10402260130140.2680-100000@swag.sw.oz.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.03.10402260130140.2680-100000@swag.sw.oz.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> CPU usage rate caps
> -------------------
> 
> A task's CPU usage rate cap imposes a soft (or hard) upper limit on the rate at
> which it can use CPU resources and can be set/read via the files 
> 
> /proc/<pid>/cpu_rate_cap 
> /proc/<tgid>/task/<pid>/cpu_rate_cap  
> 
> Usage rate caps are expressed as rational numbers (e.g. "1 / 2") and hard caps 
> are signified by a "!" suffix.  The rational number indicates the proportion 
> of a single CPU's capacity that the task may use. The value of the number must 
> be in the range 0.0 to 1.0 inclusive for soft caps. For hard caps there is an 
> additional restriction that a value of 0.0 is not permitted.  Tasks with a 
> soft cap of 0.0 become true background tasks and only get to run when no other 
> tasks are active.

Why not use something like percent, parts per milion or whatever?

> When hard capped tasks exceed their cap they are removed from the run queues 
> and placed in a "sinbin" for a short while until their usage rate decays to
> within limits.

How do you solve this one?

I want to kill your system.

I launch task A, "semaphore grabber", that does filesystem
operations. Those need semaphores. I run it as "true background".

I wait for A to grab some lock, then I run B, which is while(1);

A holds lock that can not be unlocked, and your system is dead.

This may happen randomly, even without me on your system.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
