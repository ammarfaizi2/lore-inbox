Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265715AbTL3KVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 05:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265716AbTL3KVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 05:21:38 -0500
Received: from mx2.it.wmich.edu ([141.218.1.94]:44496 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S265715AbTL3KVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 05:21:36 -0500
Message-ID: <3FF151AD.1080703@wmich.edu>
Date: Tue, 30 Dec 2003 05:21:33 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: manfred@colorfullife.com, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optimize ia32 memmove
References: <200312300713.hBU7DGC4024213@hera.kernel.org> <3FF129F9.7080703@pobox.com>
In-Reply-To: <3FF129F9.7080703@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this the entire patch?  When was the original post since I cant find 
the message going back over a month ago in the archives or any current 
posts.


Jeff Garzik wrote:
> Linux Kernel Mailing List wrote:
> 
>> ChangeSet 1.1496.22.32, 2003/12/29 21:45:30-08:00, akpm@osdl.org
>>
>>     [PATCH] optimize ia32 memmove
>>     
>>     From: Manfred Spraul <manfred@colorfullife.com>
>>     
>> diff -Nru a/include/asm-i386/string.h b/include/asm-i386/string.h
>> --- a/include/asm-i386/string.h    Mon Dec 29 23:13:20 2003
>> +++ b/include/asm-i386/string.h    Mon Dec 29 23:13:20 2003
>> @@ -299,14 +299,9 @@
>>  static inline void * memmove(void * dest,const void * src, size_t n)
>>  {
>>  int d0, d1, d2;
>> -if (dest<src)
>> -__asm__ __volatile__(
>> -    "rep\n\t"
>> -    "movsb"
>> -    : "=&c" (d0), "=&S" (d1), "=&D" (d2)
>> -    :"0" (n),"1" (src),"2" (dest)
>> -    : "memory");
>> -else
>> +if (dest<src) {
>> +    memcpy(dest,src,n);
>> +} else
>>  __asm__ __volatile__(
>>      "std\n\t"
>>      "rep\n\t"
> 

