Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbUKAJF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUKAJF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 04:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbUKAJF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 04:05:27 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:36942 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261644AbUKAJFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 04:05:22 -0500
Message-ID: <4185FC4B.30804@yahoo.com.au>
Date: Mon, 01 Nov 2004 20:05:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.de>
CC: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
References: <20041101084337.GA7824@dominikbrodowski.de>
In-Reply-To: <20041101084337.GA7824@dominikbrodowski.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
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

I think I've got a patch somewhere to implement _interruptible operations
on rwsems.
