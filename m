Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751508AbWIRLcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751508AbWIRLcP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 07:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWIRLcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 07:32:15 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:57000 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751508AbWIRLcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 07:32:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=U4n06nBwdz9xQP9EiqqYPaZUNM7/FM2b/f00zSjEoUrWDTeMcdhiccFh992vDYk1ieJFHrNxw0BDbXndY2QoJEOvB/ogKhUoEAOUy6iXCs7G9zGzh/nCx5xHn/YK3OLle09tU0x3UHecbvn3kSopReDsC4SnZ1O2FSeTkORuLgM=
Message-ID: <450E83DC.4050503@gmail.com>
Date: Mon, 18 Sep 2006 15:32:44 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: pm list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
References: <45096933.4070405@gmail.com> <20060918104437.GA4973@elf.ucw.cz>
In-Reply-To: <20060918104437.GA4973@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> The PowerOP Core provides completely arch independent interface
>> to create and control operating points which consist of arbitrary
>> subset of power parameters available on a certain platform.
>> Also, PowerOP Core provides optional SysFS interface to access
>> operating point from userspace.
> 
> Please inline patches and sign them off.

hmm, seems my bad. will double check.

> 
> Also if you are providing new userland interface, describe it... in
> Documentation/ABI.

seems already discussed

>> +struct powerop_driver {
>> +	char *name;
>> +	void *(*create_point) (const char *pwr_params, va_list args);
>> +	int (*set_point) (void *md_opt);
>> +	int (*get_point) (void *md_opt, const char *pwr_params, va_list args);
>> +};
> 
> We can certainly get better interface than va_list, right?

Please elaborate.

> 
>> +
>> +#
>> +# powerop
>> +#
>> +
>> +menu "PowerOP (Power Management)"
>> +
>> +config POWEROP
>> +	tristate "PowerOP Core"
>> +	help
> 
> Hohum, this is certainly going to be clear to confused user...

please elaborate.

>> +	list_add_tail(&opt->node, &named_opt_list);
>> +	strcpy(registered_names[registered_opt_number], id);
>> +	registered_opt_number++;
>> +	up(&named_opt_list_mutex);
>> +
>> +	blocking_notifier_call_chain(&powerop_notifier_list,
>> +				     POWEROP_REGISTER_EVENT, id);
>> +	return 0;
>> +
>> +      fail_set_name:
>> +	kfree(opt->md_opt);
>> +
>> +      fail_opt_create:
>> +	kfree(registered_names[registered_opt_number]);
>> +
>> +      fail_name_nomem:
>> +	kfree(opt);
>> +	return err;
>> +}
> 
> Careful about spaces vs. tabs...

will double check but I'm pretty sure I ran all files thru lindent.


> ...so, you got support for 20 operating points... And this should
> include devices, too, right? 

sorry, don't understand the question. an operating point is a set of platform 
power parameters.

>How is it going to work on 8cpu box? will
> you have states like cpu1_800MHz_cpu2_1600MHz_cpu3_800MHz_... ?

i do not operate with term 'state' so I don't understand what it means here.

	Eugeny

> 								Pavel

