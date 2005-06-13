Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbVFMTzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbVFMTzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261275AbVFMTzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:55:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22225 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261258AbVFMTvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:51:10 -0400
Message-ID: <42ADE2FF.5020604@redhat.com>
Date: Mon, 13 Jun 2005 15:48:15 -0400
From: Ananth N Mavinakayanahalli <amavin@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rusty.lynch@intel.com
CC: akpm@osdl.org, systemtap@sources.redhat.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, Hien Nguyen <hien@us.ibm.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>, Andi Kleen <ak@suse.de>,
       linuxppc64-dev@ozlabs.org
Subject: Re: [patch 5/5] [kprobes] Tweak to the function return probe design
References: <20050613190207.954385000@tuna.jf.intel.com> <20050613190323.672988000@tuna.jf.intel.com>
In-Reply-To: <20050613190323.672988000@tuna.jf.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty.lynch@intel.com wrote:

Hi Rusty,

Thanks for doing this. However...

> +
> +		orig_ret_address = (unsigned long)ri->ret_addr;
> +		recycle_rp_inst(ri);
> +
> +		if (orig_ret_address != (unsigned long) &kretprobe_trampoline)
> +			/*
> +			 * This is the real return address. Any other
> +			 * instances associated with this task are for
> +			 * other calls deeper on the call stack
> +			 */
> +			break;
> +	}
> +
> +	BUG_ON(!orig_ret_address);
> +	regs->nip = orig_ret_address;
> +
> +	unlock_kprobes();
> +	preempt_enable_no_resched();
         ^^^^^^^

We don't need this here - on ppc64, we do a preempt_disable/enable in
kprobe_exceptions_notify() and so this will cause a spurious 
preempt_enable().

Thanks,
Ananth
