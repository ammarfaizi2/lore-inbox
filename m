Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262762AbVAKBDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbVAKBDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 20:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262683AbVAKBAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 20:00:12 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:3581 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262691AbVAJVdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 16:33:20 -0500
Message-ID: <41E2F49F.4090503@us.ibm.com>
Date: Mon, 10 Jan 2005 13:33:19 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040804 Netscape/7.2 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Kevin P. Fleming" <kpfleming@starnetworks.us>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] 2.4.19-rc1 number() stack reduction
References: <1105378550.4000.132.camel@dyn318077bld.beaverton.ibm.com> <1105378775.4000.138.camel@dyn318077bld.beaverton.ibm.com> <41E2DC8C.6080101@starnetworks.us>
In-Reply-To: <41E2DC8C.6080101@starnetworks.us>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yep. My bad. I got little carried away...

But I remember seeing this on earlier distros..

Thanks,
Badari

Kevin P. Fleming wrote:

> Badari Pulavarty wrote:
> 
>> + /* Move these off of the stack for number().  This way we reduce the
>> +  * size of the stack and don't have to copy them every time we are 
>> called.
>> +  */
>> +const char small_digits[] = "0123456789abcdefghijklmnopqrstuvwxyz";
>> +const char large_digits[] = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
>> +
>>  static char * number(char * buf, char * end, long long num, int base, 
>> int size, int precision, int type)
>>  {
>>      char c,sign,tmp[66];
>>      const char *digits;
>> -    static const char small_digits[] = 
>> "0123456789abcdefghijklmnopqrstuvwxyz";
>> -    static const char large_digits[] = 
>> "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
> 
> 
> Is this actually correct? Since these are declared "static const", they 
> are not on the stack anyway, because they have to persist between calls 
> to this function and cannot be changed. I'd be very surprised if the 
> compiler was copying this data from the static data segment to the stack 
> on every entry to this function.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

