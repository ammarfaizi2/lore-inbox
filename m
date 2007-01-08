Return-Path: <linux-kernel-owner+w=401wt.eu-S1751465AbXAHHER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXAHHER (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 02:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbXAHHER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 02:04:17 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:43702 "EHLO
	mail6.sea5.speakeasy.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbXAHHEQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 02:04:16 -0500
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Amit Choudhary <amit2030@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <60237.99836.qm@web55612.mail.re4.yahoo.com>
References: <60237.99836.qm@web55612.mail.re4.yahoo.com>
Content-Type: text/plain
Date: Sun, 07 Jan 2007 23:04:12 -0800
Message-Id: <1168239852.6202.15.camel@dsl081-166-245.sea1.dsl.speakeasy.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2007-01-07 at 20:09 -0800, Amit Choudhary wrote:
> I have already explained it earlier. I will try again. You will not need free_2: and free_1: with
> KFREE(). You will only need one free: with KFREE.

So, to rephrase, your stated goal is to get rid of any non-singular goto
labels in function error handling paths? Aside from sounding trippy in a
non-conformist kind of way, what benefits will this give to the kernel?

I ask this because there's already one easy-to-spot downside: you'll end
up calling kfree(NULL) a bunch of times that can be, and should be,
avoided. Whereas turning my computer into a better space-heater using
noops (like repeated kfree(NULL) calls) may be a noble goal, I'd much
rather not waste this planet's limited resources unnecessarily.

> Also, let's say that count is different for each array? Then how do you propose that memory be
> allocated in one pass?

The parameters to a '+' operator need not be equivalent.

> I have scanned the whole kernel to check whether people are checking for return values of kmalloc,
> I found that at many places they don't and have sent patches for them. Now, this too is brain
> damaged code. And during the scan I saw examples of what I described earlier.

These cases should be fixed independently of any particular KFREE()
agenda.

> KFREE() can fix some of those cases.

I am curious as to how a KFREE() macro can fix cases where people don't
check the kmalloc() return value.

> Below are some examples where people are doing KFREE() kind of stuff:

I glanced at one instance, and...

> arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c:				kfree(acpi_perf_data[j]);
> arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c-				acpi_perf_data[j] = NULL;

'acpi_perf_data' is a global and persistent data structure, where a NULL
value actually has a specific and distinct meaning (as in
acpi_cpufreq_cpu_init()). How you think this helps your argument with
setting a local pointer to NULL after free is beyond me.

-- Vadim Lobanov


