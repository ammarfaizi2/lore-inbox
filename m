Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbWIVFvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbWIVFvL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 01:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWIVFvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 01:51:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:46773 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750979AbWIVFvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 01:51:08 -0400
From: Andi Kleen <ak@suse.de>
To: Dmitriy Zavin <dmitriyz@google.com>
Subject: Re: [PATCH 4/4] therm_throt: Add a cumulative thermal throttle event counter.
Date: Fri, 22 Sep 2006 07:51:02 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <11588860842488-git-send-email-dmitriyz@google.com> <11588860852885-git-send-email-dmitriyz@google.com> <11588860852260-git-send-email-dmitriyz@google.com>
In-Reply-To: <11588860852260-git-send-email-dmitriyz@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220751.02216.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +	preempt_disable();         /* CPU hotplug */
> +	for_each_online_cpu(cpu) {
> +		/* connect live CPUs to sysfs */
> +		thermal_throttle_add_dev(get_cpu_sysdev(cpu));
> +	}
> +	preempt_enable();

There was still one problem in there: sysfs_create_group can 
sleep and that's not ok with preemption disabled.

I changed it to register the notifier first and do the necessary
locking in there using a private lock (that the new akpm-recommended(tm)
way to do this) 

-Andi
