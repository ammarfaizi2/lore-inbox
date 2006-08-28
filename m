Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbWH1IK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbWH1IK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 04:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWH1IK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 04:10:26 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:46251 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751418AbWH1IKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 04:10:09 -0400
Date: Mon, 28 Aug 2006 17:08:39 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: mail@renninger.de
Subject: Re: [PATCH 2/2] acpi hotplug cleanups, move install notifier to add function
Cc: trenn@suse.de, akpm@osdl.org, "Brown, Len" <len.brown@intel.com>,
       keith mannthey <kmannth@us.ibm.com>,
       ACPI-ML <linux-acpi@vger.kernel.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>,
       naveen.b.s@intel.com
In-Reply-To: <1156701501.1852.20.camel@linux-1vxn.site>
References: <20060825205423.0778.Y-GOTO@jp.fujitsu.com> <1156701501.1852.20.camel@linux-1vxn.site>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.068
Message-Id: <20060828165449.F61C.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.24.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -390,6 +296,13 @@ static int acpi_memory_device_add(struct
>  	if (!device)
>  		return -EINVAL;
>  
> +	/* Check for _STA and EJ0 func */
> +	if (!device->flags.dynamic_status || !device->flags.ejectable){
> +		printk(KERN_INFO PREFIX "Memory device %s has no _STA or"
> +		       "EJ0/EJD function", acpi_device_bid(device));
> +		return -ENODEV;
> +	}
> +
>  	mem_device = kmalloc(sizeof(struct acpi_memory_device), GFP_KERNEL);
>  	if (!mem_device)
>  		return -ENOMEM;

One comment.

Memory device might not have _EJ0/_EJD, but parent device
(like one NUMA node) might be able to be ejectable.
In this case, only the parent device has _EJ0/_EJD.
So, one more check is necessary.

(If a node is hot-added, container driver of acpi calls acpi_memhotplug
 driver.)


Thanks.

-- 
Yasunori Goto 


