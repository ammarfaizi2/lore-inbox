Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVH1SJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVH1SJs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 14:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbVH1SJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 14:09:48 -0400
Received: from isilmar.linta.de ([213.239.214.66]:9136 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1750729AbVH1SJr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 14:09:47 -0400
Date: Sun, 28 Aug 2005 20:09:41 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>
Subject: Re: [PATCH] acpi-cpufreq: Remove P-state read after a P-state write in normal path
Message-ID: <20050828180941.GB28994@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Len Brown <len.brown@intel.com>
References: <20050826171052.B27226@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050826171052.B27226@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Aug 26, 2005 at 05:10:52PM -0700, Venkatesh Pallipadi wrote:
>  	/*
> -	 * Then we read the 'status_register' and compare the value with the
> -	 * target state's 'status' to make sure the transition was successful.
> -	 * Note that we'll poll for up to 1ms (100 cycles of 10us) before
> -	 * giving up.
> +	 * Assume the write went through when acpi_pstate_strict is not used.
> +	 * As read status_register is an expensive operation and there 
> +	 * are no specific error cases where an IO port write will fail.
>  	 */

Well, the IO port write itself might not fail, but the transition itself --
and we're reading the _status_ register here, not the control register where
we've written to. And 8.4.4.1 of ACPI-sepc 3.0 does specifically mention
that transitions _can_ fail, so I think we should handle this possibility.

	Dominik
