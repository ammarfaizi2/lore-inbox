Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTKZPrm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 10:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTKZPrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 10:47:42 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:1664 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264233AbTKZPrl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 10:47:41 -0500
Date: Wed, 26 Nov 2003 10:46:25 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Kai Bankett <kbankett@aol.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq_balance does not make sense with HT but single
 physical CPU
In-Reply-To: <3FC4B5C8.6020405@aol.com>
Message-ID: <Pine.LNX.4.58.0311261042540.1683@montezuma.fsmlabs.com>
References: <3FC4B5C8.6020405@aol.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-1; FORMAT=flowed
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.58.0311261042542.1683@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Nov 2003, Kai Bankett wrote:

> this patch should disable irq_balance threat in case of only one
> installed physical cpu thats running in HyperThreading-mode (so reported
> as 2 cpus).
> I think it should make no sense to run irq_blanance in that special case
> - please correct me if i´m wrong.

+#ifdef CONFIG_X86_HT
+	/* On Hyper-Threading CPUs - if only one physical installed
+	   balance does not make sense */
+	if (cpu_has_ht && smp_num_siblings == 2 && num_online_cpus() == 2) {
+		irqbalance_disabled = 1;
+		return 0;
+	}
+#endif

Further down, i believe the following would have the same effect;

	/*
	 * Enable physical balance only if more than 1 physical processor
	 * is present
	 */
	if (smp_num_siblings > 1 && !cpus_empty(tmp))
		physical_balance = 1;


tmp = cpu_online_map >> 2;

so we drop the first two processors (logical or physical) and only enable
physical balance if there are still processors present in the map. Or are
you observing something else?

