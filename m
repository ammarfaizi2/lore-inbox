Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUGXDCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUGXDCi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 23:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbUGXDCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 23:02:38 -0400
Received: from gort.metaparadigm.com ([203.117.131.12]:56812 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id S264655AbUGXDCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 23:02:36 -0400
Message-ID: <4101D14D.6090007@metaparadigm.com>
Date: Sat, 24 Jul 2004 11:02:37 +0800
From: Michael Clark <michael@metaparadigm.com>
Organization: Metaparadigm Pte Ltd
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040715 Debian/1.7.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@ximian.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
References: <1090604517.13415.0.camel@lucy>
In-Reply-To: <1090604517.13415.0.camel@lucy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/24/04 01:41, Robert Love wrote:

> @@ -59,9 +60,15 @@
>  	if (l & 0x1) {
>  		printk(KERN_EMERG "CPU%d: Temperature above threshold\n", cpu);
>  		printk(KERN_EMERG "CPU%d: Running in modulated clock mode\n",
> -				cpu);
> +			cpu);
> +		send_kmessage(KMSG_POWER,
> +			"/org/kernel/devices/system/cpu/temperature", "high",
> +			"Cpu: %d\n", cpu);

Should there be some sharing with the device naming of sysfs or are
will we introduce a new one? ie sysfs uses:

devices/system/cpu/cpu0/<blah>

Would it be a better way to have a version that takes struct kobject
to enforce consistency in the device naming scheme. This also means
userspace would automatically know where to look in /sys if futher
info was needed.

Question is does it make sense to use this infrastructure without sysfs
as hald, etc require it. ie depends CONFIG_SYSFS

Perhaps a send_kmessage_kobject ?

~mc
