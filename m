Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269435AbUKAQ1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269435AbUKAQ1m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 11:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267194AbUKAPv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 10:51:28 -0500
Received: from fsmlabs.com ([168.103.115.128]:35970 "EHLO musoma.fsmlabs.com")
	by vger.kernel.org with ESMTP id S262823AbUKAOCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:02:46 -0500
Date: Mon, 1 Nov 2004 07:00:07 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Dominik Brodowski <linux@dominikbrodowski.de>
cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
In-Reply-To: <20041101084337.GA7824@dominikbrodowski.de>
Message-ID: <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
References: <20041101084337.GA7824@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Nov 2004, Dominik Brodowski wrote:

> [CPU-HOTPLUG] Use a rw-semaphore for serializing and locking
> 
> Currently, lock_cpu_hotplug serializes multiple calls to cpufreq->target()
> on multiple CPUs even though that's unneccessary. Even further, it
> serializes these calls with totally unrelated other parts of the kernel...
> some ppc64 event reporting, some cache management, and so on. In my opinion
> locking should be done subsystem (and normally data-)specific, and disabling
> CPU hotplug should just do that.
> 
> This patch converts the semaphore cpucontrol to be a rwsem which allows us 
> to use it for _both_ variants: locking (write) and (multiple) other parts 
> disabling CPU hotplug (read).
> 
> Only problem I see with this approach is that lock_cpu_hotplug_interruptible()
> needs to disappear as there is no down_write_interruptible() for rw-semaphores.
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.de>

Agreed it makes a lot more sense, i think there could be some places where 
we use preempt_disable to protect against cpu offline which could 
converted, but that can come later.

Thanks,
	Zwane

