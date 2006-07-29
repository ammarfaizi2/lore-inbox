Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWG2FPT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWG2FPT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 01:15:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932638AbWG2FPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 01:15:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50136 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932637AbWG2FPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 01:15:17 -0400
Date: Fri, 28 Jul 2006 22:15:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Message-Id: <20060728221508.9ec9be23.akpm@osdl.org>
In-Reply-To: <200607281015.30048.rjw@sisk.pl>
References: <200607281015.30048.rjw@sisk.pl>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 10:15:29 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> int disable_nonboot_cpus(void)
> +{
> +	int cpu, error = 0;
> +
> +	/* We take all of the non-boot CPUs down in one shot to avoid races
> +	 * with the userspace trying to use the CPU hotplug at the same time
> +	 */
> +	mutex_lock(&cpu_add_remove_lock);
> +	cpus_clear(frozen_cpus);
> +	printk("Disabling non-boot CPUs ...\n");
> +	for_each_online_cpu(cpu) {
> +		if (cpu == 0)
> +			continue;

This is presumably only called on cpu 0, yes?

How can we guarantee that, given that preemption is enabled?

What happens if cpu 0 isn't online?
