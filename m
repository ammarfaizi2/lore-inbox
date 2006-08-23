Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751444AbWHWHtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751444AbWHWHtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 03:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWHWHtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 03:49:47 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:60775 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751444AbWHWHtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 03:49:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=bTJNWZGOCzdb9yHbJFUpef7fZgY8Z2YEXR63pBPHEDYsTk9o2/0GRv4sJzuLDRiokaHnJwRKFqg+tX+FimT6Wk52+TI9EivELluT122bwW0UdKK8ixyAO5YsIERcMIrh1byRk84/oLHWKVVuhW7kpUJBdT0fsgNrHLpuCXaa8zE=
Message-ID: <44EC0887.10402@innova-card.com>
Date: Wed, 23 Aug 2006 09:49:27 +0200
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
CC: Franck <vagabon.xyz@gmail.com>, rusty@rustcorp.com.au,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] kallsyms_lookup always requires buffers
References: <44EAFDCA.1080002@innova-card.com> <44EB5A73.9080206@grupopie.com>
In-Reply-To: <44EB5A73.9080206@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Paulo Marques wrote:
> Franck Bui-Huu wrote:
>>
>> This simple patch adds a new entry "kallsyms_lookup_gently()". The
>> name actually sucks but I can't figure out a coherent name with the
>> rest of the file. If someone could give me a better idea...
> 
> kallsyms_lookup_size_offset() ?
> 
> Granted it is a little bigger, but it tells exactly what it does and
> there are not that many users that we have to write this name all that
> often.
> 

ok.

>> This new entry does exactly the same as kallsyms_lookup() but does
>> not require any buffers to store any names. It returns 0 if it fails
>> otherwise 1.
>>
>> Do you think this can be usefull ?
> 
> You tell me, since you're proposing the change ;)
> 

:)
actually the question was rather "does this change look sensible to you ?"

>> +static int is_kernel_addr(unsigned long addr)
> 
> Maybe change the name to kallsyms_is_kernel_addr, because this function
> does more things than what the generic name implies.
> 

it sounds like a public function name. Maybe is_ksym_addr() is better ?

>> + * Lookup an address but don't bother to find any names.
>> + */
>> +int kallsyms_lookup_gently(unsigned long addr, unsigned long
>> *symbolsize,
>> +               unsigned long *offset)
>> +{
>> +    int rv;
>> +
>> +    if (is_kernel_addr(addr))
>> +        rv = !!get_symbol_pos(addr, symbolsize, offset);
>> +    else
>> +        rv = !!module_address_lookup(addr, symbolsize, offset, NULL);
>> +
>> +    return rv;
>> +}
> 
> <minor nitpick>
> 
> Why not just:
> 
>> if (is_kernel_addr(addr))
>>    return !!get_symbol_pos(addr, symbolsize, offset);
>>
>> return !!module_address_lookup(addr, symbolsize, offset, NULL);
> 
> and just get rid of "rv" completely?
> 
> </minor nitpick>
> 

No problem.

>> +EXPORT_SYMBOL_GPL(kallsyms_lookup_gently);
> 
> I agree with Arjan here. If kallsyms_lookup wasn't exported, I don't see
> a reason to export this either.
> 

Already removed.

thanks
		Franck
