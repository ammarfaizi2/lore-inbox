Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVJLALE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVJLALE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVJLALE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:11:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932371AbVJLALC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:11:02 -0400
Date: Tue, 11 Oct 2005 17:10:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
Message-Id: <20051011171052.3e1d00b6.akpm@osdl.org>
In-Reply-To: <1128404215.31063.32.camel@gaston>
References: <1128404215.31063.32.camel@gaston>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> +	/* First, locate the params for this model */
> +	for (i = 0; i < WF_SMU_SYS_FANS_NUM_CONFIGS; i++)
> +		if (wf_smu_sys_all_params[i].model_id == mach_model) {

The loop control is a bit scary here.  If you were to do

	#define WF_SMU_SYS_FANS_NUM_CONFIGS ARRAY_SIZE(wf_smu_sys_all_params)

then we wouldn't need duplicated into in two places.

> +			param = &wf_smu_sys_all_params[i];
> +			break;
> +		}
> +	/* No params found, put fans to max */
> +	if (param == NULL) {
> +		printk(KERN_WARNING "windfarm: System fan config not found "
> +		       "for this machine model, max fan speed\n");
> +		goto fail;
> +	}
> +
> +	/* Alloc & initialize state */
> +	wf_smu_sys_fans = kmalloc(sizeof(struct wf_smu_sys_fans_state),
> +					GFP_KERNEL);
> +	if (wf_smu_sys_fans == NULL) {
> +		printk(KERN_WARNING "windfarm: Memory allocation error"
> +		       " max fan speed\n");
> +		goto fail;
> +	}
> +       	wf_smu_sys_fans->ticks = 1;

whitespace broke.
