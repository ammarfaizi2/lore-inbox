Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUFICuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUFICuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 22:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbUFICuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 22:50:32 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:29432 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265510AbUFICua (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 22:50:30 -0400
Date: Tue, 8 Jun 2004 22:52:09 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Hanna Linder <hannal@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.6-rc2 RFT] Add's class support to cpuid.c
In-Reply-To: <10660000.1086732946@dyn318071bld.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0406082248360.23469@montezuma.fsmlabs.com>
References: <98460000.1086215543@dyn318071bld.beaverton.ibm.com>
 <40BE6CA9.9030403@zytor.com> <20040603193256.GD23564@kroah.com>
 <7430000.1086729016@dyn318071bld.beaverton.ibm.com>
 <10660000.1086732946@dyn318071bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jun 2004, Hanna Linder wrote:

> +static void cpuid_class_simple_device_remove(void)
> +{
> +	int i = 0;
> +	for_each_online_cpu(i)
> +		class_simple_device_remove(MKDEV(CPUID_MAJOR, i));
> +	return;
> +}

My understanding is that the above removes the class for each online cpu.

> +static int __devinit cpuid_class_cpu_callback(struct notifier_block *nfb, unsigned long action, void *hcpu)
> +{
> +	unsigned int cpu = (unsigned long)hcpu;
> +
> +	switch(action) {
> +	case CPU_ONLINE:
> +		cpuid_class_simple_device_add(cpu);
> +		break;
> +	case CPU_DEAD:
> +		cpuid_class_simple_device_remove();
> +		break;

So the above will remove the class for all online processors when one
processor goes down? By the way, you can use i386 SMP to test cpu hotplug
code paths.

	Zwane

