Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932818AbWJINmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932818AbWJINmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 09:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWJINmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 09:42:36 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:63636 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932818AbWJINmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 09:42:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=gDDETt4e3iEUgATCScOTQNrHWRTXhKKpnQcE8MRSeJZsCMzUd4AA/9m/P0xFYCuUqRSj9QNnNGw/uOm+fzxxEzOVY85AIzTHCP6237nfbzTgDpJXXDmY8NOEOmniU/0+BXQLrOJGTjD9mmfvRYgSpXDPc8K4uAhawv5fyFun2yU=
Message-ID: <452A51C2.2010106@gmail.com>
Date: Mon, 09 Oct 2006 17:42:26 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Dominik Brodowski <linux@dominikbrodowski.net>,
       "Eugeny S. Mints" <eugeny.mints@gmail.com>,
       pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>,
       Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] CPUFreq PowerOP integration, Centrino PM Core and OPs registration
 2/3
References: <45096C1A.7010008@gmail.com> <20061007031910.GA1494@dominikbrodowski.de>
In-Reply-To: <20061007031910.GA1494@dominikbrodowski.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Brodowski wrote:
> Hi,
> 
> On Thu, Sep 14, 2006 at 06:50:02PM +0400, Eugeny S. Mints wrote:
> 
>> +static int 
>> +process_pwr_param(struct pm_core_point *opt, int op, char *param_name,
>> +		  int va_arg)
>> +{
>> +	int cpu = 0;
>> +	char buf[8];
>> +
>> +	for (cpu = 0; cpu < NR_CPUS; cpu++)
>> +	{
>> +		sprintf(buf, "v%d", cpu);
>> +
>> +		if (strcmp(param_name, buf) == 0) {
>> +			if (op == PWR_PARAM_SET)
>> +				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V] = 
>> +									va_arg;
>> +			else if (opt != NULL)
>> +				*(int *)va_arg = 
>> +				     opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_V];
>> +			else if ((*(int *)va_arg = get_vtg(cpu)) <= 0)
>> +				return -EINVAL;
>> +			return 0;
>> +		}
>> +
>> +		sprintf(buf, "freq%d", cpu);
>> +
>> +		if (strcmp(param_name, buf) == 0) {
>> +			if (op == PWR_PARAM_SET)
>> +				opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ] = 
>> +									va_arg;
>> +			else if (opt != NULL)
>> +				*(int *)va_arg = 
>> +				  opt->opt[cpu].pwpr[_I386_PM_CORE_POINT_FREQ];
>> +			else if ((*(int *)va_arg = get_freq(cpu)) <= 0)
>> +				return -EINVAL;
>> +
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	return -EINVAL;
>> +}
> 
> Ouch. IIRC Pavel had some fine comments about such string parsing deep in
> arch code... Other than that I see lots of indirection, lots of code being
> added (~400 lines) for no gain in functionality for the x86 case.
THis code is no longer anyhow relevant to the latest take of PowerOP. Please 
check to make sure that you are looking at the very latest PowerOP code 
submitted for discussion. Latest PowerOP take gets rid of all parsing. Latest 
patches do not contain x86 patch yet but omap PM core reference code is 
supplied.  So please use  omap code for the discussion. FYI, forward porting of 
x86 patches to the latest POwerOP is on the way.

Thanks,
	Eugeny
> 
> Thanks,
> 	Dominik
> 

