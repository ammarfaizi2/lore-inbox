Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161310AbWJ3LZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161310AbWJ3LZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 06:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWJ3LZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 06:25:10 -0500
Received: from imag.imag.fr ([129.88.30.1]:25528 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S1161310AbWJ3LZI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 06:25:08 -0500
Message-ID: <4545E0D7.6010608@imag.fr>
Date: Mon, 30 Oct 2006 12:24:07 +0100
From: Videau Brice <brice.videau@imag.fr>
Reply-To: brice.videau@imag.fr
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Strange connect behavior
References: <4545D2FA.3030802@imag.fr> <200610301132.57769.dada1@cosmosbay.com>
In-Reply-To: <200610301132.57769.dada1@cosmosbay.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (imag.imag.fr [129.88.30.1]); Mon, 30 Oct 2006 12:24:12 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: brice.videau@imag.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It all makes sense now!

Thank you very much.

Regards,

Brice



Eric Dumazet wrote:
> On Monday 30 October 2006 11:24, Videau Brice wrote:
>   
>> Hello,
>>
>> While writing some client server application in c, we noticed a strange
>> behavior : if we try to connect endlessly to a given local port where
>> nobody is listening, and if the port is >= to 32768, after several
>> thousands tries ( Connection refused ) connect will return 0.
>> This behavior is not exhibited when port is < 32768.
>>
>>     
>
> Hello Brice
>
> Yes, it's quite possible your attempts are hitting themselves.
>
> Hint :
>
> cat /proc/sys/net/ipv4/ip_local_port_range
>
> When you connect(), TCP stack automatically chose a source port and bind your 
> outgoing socket. If the chosen port happens to be 35489 (your 'destination' 
> port), then the connect succeeds (you're connected to yourself), as specified 
> by TCP specs.
>
>
>   
>> We confirmed this behavior in kernel 2.6.17-10, 2.6.18-1, 2.6.8, on x86
>> and 2.4.21-32 on ia64, on several hardware configurations.
>> Distribution is debian or ubuntu.
>>
>> Attached is a source file that demonstrate this behavior.
>> ./a.out port_number
>>
>> Sample execution :
>>
>> ./a.out 35489
>> Out port : 35489
>> connect try 1 failed : Connection refused
>> connect try 2 failed : Connection refused
>> connect try 3 failed : Connection refused
>> .....
>> connect try 6089 failed : Connection refused
>> connect try 6090 failed : Connection refused
>> Connection success : 6091 try
>> Connection closed
>> last error : Connection refused
>>
>>
>> Is this behavior to be expected?
>> Can it be disabled?
>>
>> Thanks in advance.
>>
>> Regards,
>>
>> Brice Videau
>>     
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>   

