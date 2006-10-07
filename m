Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423119AbWJGDUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423119AbWJGDUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 23:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWJGDTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 23:19:48 -0400
Received: from isilmar.linta.de ([213.239.214.66]:1977 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932694AbWJGDTq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 23:19:46 -0400
Date: Fri, 6 Oct 2006 23:19:10 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>,
       Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] CPUFreq PowerOP integration, Centrino PM Core and OPs registration 2/3
Message-ID: <20061007031910.GA1494@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	"Eugeny S. Mints" <eugeny.mints@gmail.com>,
	pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>,
	Amit Kucheria <amit.kucheria@nokia.com>,
	Igor Stoppa <igor.stoppa@nokia.com>,
	kernel list <linux-kernel@vger.kernel.org>
References: <45096C1A.7010008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45096C1A.7010008@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 14, 2006 at 06:50:02PM +0400, Eugeny S. Mints wrote:

> +static int 
> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
> +		  int va_arg)
> +{
> +	int cpu = 0;
> +	char buf[8];
> +
> +	for (cpu = 0; cpu < NR_CPUS; cpu++)
> +	{
> +		sprintf(buf, "v%d", cpu);
> +
> +		if (strcmp(param_name, buf) == 0) {
> +			if (op == PWR_PARAM_SET)
> +				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V] = 
> +									va_arg;
> +			else if (opt != NULL)
> +				*(int *)va_arg = 
> +				     opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V];
> +			else if ((*(int *)va_arg = get_vtg(cpu)) <= 0)
> +				return -EINVAL;
> +			return 0;
> +		}
> +
> +		sprintf(buf, "freq%d", cpu);
> +
> +		if (strcmp(param_name, buf) == 0) {
> +			if (op == PWR_PARAM_SET)
> +				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ] = 
> +									va_arg;
> +			else if (opt != NULL)
> +				*(int *)va_arg = 
> +				  opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ];
> +			else if ((*(int *)va_arg = get_freq(cpu)) <= 0)
> +				return -EINVAL;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

Ouch. IIRC Pavel had some fine comments about such string parsing deep in
arch code... Other than that I see lots of indirection, lots of code being
added (~400 lines) for no gain in functionality for the x86 case.

Thanks,
	Dominik
