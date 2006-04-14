Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWDNSIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWDNSIk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 14:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWDNSIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 14:08:40 -0400
Received: from uproxy.gmail.com ([66.249.92.171]:8547 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751375AbWDNSIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 14:08:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qUx5vtYp98hB3Hp+X6ZMJ5rXfUJDaOFD9DMaeRL1Ohl7VXQlgLtx9kvfuLkSNaIPfYezmzo2Eh9wNgUa7DtCXEjciFc6XuNEE8sHbigSVZ74Ec0G2ZQkwqpjXBe0BbRKYw0P5bsjx38wkU7Lb7YStXNZ5y3PTg7IJIjzOGKP278=
Message-ID: <443FE560.6010805@gmail.com>
Date: Fri, 14 Apr 2006 21:09:36 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060401)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Barry K. Nathan" <barryn@pobox.com>, Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH][TAKE 3] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
 limit
References: <443EE4C3.5040409@gmail.com> <443FE1AF.8050507@zytor.com>
In-Reply-To: <443FE1AF.8050507@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Alon Bar-Lev wrote:
>> diff -urNp linux-2.6.16/Documentation/i386/boot.txt 
>> linux-2.6.16.new/Documentation/i386/boot.txt
>> --- linux-2.6.16/Documentation/i386/boot.txt    2006-03-20 
>> 07:53:29.000000000 +0200
>> +++ linux-2.6.16.new/Documentation/i386/boot.txt    2006-04-14 
>> 01:55:47.000000000 +0300
>> @@ -235,11 +235,8 @@ loader to communicate with the kernel.   relevant 
>> to the boot loader itself, see "special command line options"
>>  below.
>>  
>> -The kernel command line is a null-terminated string currently up to
>> -255 characters long, plus the final null.  A string that is too long
>> -will be automatically truncated by the kernel, a boot loader may allow
>> -a longer command line to be passed to permit future kernels to extend
>> -this limit.
>> +The kernel command line is a null-terminated string. A string that is 
>> too
>> +long will be automatically truncated by the kernel.
>>  
>>  If the boot protocol version is 2.02 or later, the address of the
>>  kernel command line is given by the header field cmd_line_ptr (see
>> @@ -260,6 +257,9 @@ command line is entered using the follow
>>      covered by setup_move_size, so you may need to adjust this
>>      field.
>>  
>> +       The kernel command line *must* be 256 bytes including the
>> +       final null.
>> +
>>  
>>  **** SAMPLE BOOT CONFIGURATION
>>  
> 
> This chunk is confusing at the very best.
> 
>     -hpa
> 

Hello,

The problem is that boot loader developers did not 
understand the old statement: "A string that is too long 
will be automatically truncated by the kernel, a boot loader 
may allow a longer command line to be passed to permit 
future kernels to extend this limit."

Most of them handed the same buffer to < 2.02 protocols and 
 >= 2.0.2 protocols. When I've opened bugs against that they 
claimed that they follow instructions since the 256 limit 
was explicitly mentioned. I've ended up in patching GRUB 
my-self to allow this.

I thought that this should be made clearer... But maybe I 
did not write it too well.

I've removed the 255+1 limitation from the boot protocol 
main description, so there will be no known limit there... 
And moved it to the <2.02 section notes.

Can you please suggest a different phrasing? Or maybe you 
think that it is not needed at all... But then I have a 
problem of making boot loader fix their code.

Best Regards,
Alon Bar-Lev.

