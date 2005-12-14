Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbVLNUJi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbVLNUJi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:09:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVLNUJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:09:38 -0500
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:2535 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S964773AbVLNUJh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:09:37 -0500
In-Reply-To: <Pine.LNX.4.64.0512141129090.1678@montezuma.fsmlabs.com>
References: <439EE742.5040909@suse.de> <Pine.LNX.4.64.0512141129090.1678@montezuma.fsmlabs.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <865100f9f39bd64c72af67447023b1cd@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: Gerd Knorr <kraxel@suse.de>,
       Xen merge mainline list <xen-merge@lists.xensource.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [Xen-merge] Re: [patch] SMP alternatives for i386
Date: Wed, 14 Dec 2005 20:15:01 +0000
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Dec 2005, at 19:35, Zwane Mwaikambo wrote:

> diff -urN -x 'build-*' -x '*~' -x Make -x scripts 
> linux-2.6.15-rc5/arch/i386/kernel/smpboot.c 
> work-2.6.15-rc5/arch/i386/kernel/smpboot.c
> --- linux-2.6.15-rc5/arch/i386/kernel/smpboot.c	2005-12-06 
> 17:00:36.000000000 +0100
> +++ work-2.6.15-rc5/arch/i386/kernel/smpboot.c	2005-12-06 
> 17:06:48.000000000 +0100
> @@ -1351,6 +1352,9 @@
>  	fixup_irqs(map);
>  	/* It's now safe to remove this processor from the online map */
>  	cpu_clear(cpu, cpu_online_map);
> +
> +	if (1 == num_online_cpus())
> +		alternatives_smp_switch(0);
>  	return 0;
>  }
>
> Is that really safe there? Ideally you want to do the switch when the
> processor going offline is no longer executing kernel code.

Perhaps that check belongs at the end of __cpu_die()? That's where it 
lives in xen's smpboot.c.

  -- Keir

