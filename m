Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262864AbVA2GYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbVA2GYU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 01:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262865AbVA2GYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 01:24:20 -0500
Received: from one.firstfloor.org ([213.235.205.2]:9698 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262864AbVA2GYR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 01:24:17 -0500
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: rohit.seth@intel.com, asit.k.mallick@intel.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [Discuss][i386] Platform SMIs and their interferance with tsc
 based delay calibration
References: <20050128185101.A19117@unix-os.sc.intel.com>
From: Andi Kleen <ak@muc.de>
Date: Sat, 29 Jan 2005 07:24:15 +0100
In-Reply-To: <20050128185101.A19117@unix-os.sc.intel.com> (Venkatesh
 Pallipadi's message of "Fri, 28 Jan 2005 18:51:01 -0800")
Message-ID: <m1wttwlpm8.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Venkatesh Pallipadi <venkatesh.pallipadi@intel.com> writes:
> +
> +	/*
> +	 * If the upper limit and lower limit of the tsc_rate is more than
> +	 * 12.5% apart.
> +	 */
> +	if (pre_start == 0 || pre_end == 0 ||
> +	    (tsc_rate_max - tsc_rate_min) > (tsc_rate_max >> 3)) {
> +		printk(KERN_WARNING "TSC calibration may not be precise. " 
> +		       "Too many SMIs? "
> +		       "Consider running with \"lpj=\" boot option\n");
> +		return 0;
> +	}

I think it would be better to rerun it a few times automatically
before giving up. This way it would hopefully work transparently but slower
for most users. The message is too obscure too to be usable and needs
more explanation.

And also in case the platforms in questions support EM64T 
x86-64 would need to be changed too :)

-Andi
