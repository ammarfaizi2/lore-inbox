Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265918AbTIKCBM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTIKCBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:01:12 -0400
Received: from holomorphy.com ([66.224.33.161]:15286 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265918AbTIKCBK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:01:10 -0400
Date: Wed, 10 Sep 2003 19:02:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Maciej <maciej@apathy.killer-robot.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] i386 /proc/irq/.../smp_affinity
Message-ID: <20030911020218.GQ4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Maciej <maciej@apathy.killer-robot.net>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030910191459.GA12099@apathy.black-flower> <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0309101535050.9323@montezuma.fsmlabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 09:55:03PM -0400, Zwane Mwaikambo wrote:
> -	len = 0;
> -	for (k = 0; k < sizeof(cpumask_t)/sizeof(u16); ++k) {
> -		int j = sprintf(page, "%04hx", (u16)cpus_coerce(tmp));
> -		len += j;
> -		page += j;
> -		cpus_shift_right(tmp, tmp, 16);
> -	}
> -	len += sprintf(page, "\n");
> -	return len;
> +	return sprintf(page, "%08x\n", (u32)cpus_coerce(tmp));
>  }
>  
>  static int irq_affinity_write_proc(struct file *file, const char __user *buffer,

This backs out the variable-length cpu bitmask handling.

I appear to be printing out 16-bit chunks of all this in what appears
to be the reverse of the order expected. Why not just reverse the order
of the 16-bit chunks?

-- wli
