Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262259AbTD3PLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 11:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTD3PLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 11:11:24 -0400
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:30995 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S262259AbTD3PLX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 11:11:23 -0400
Message-ID: <3EAFEA83.9030301@superbug.demon.co.uk>
Date: Wed, 30 Apr 2003 16:23:47 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030401
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: vda@port.imtp.ilyichevsk.odessa.ua, Nick Piggin <piggin@cyberone.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bug in linux kernel when playing DVDs.
References: <3EABB532.5000101@superbug.demon.co.uk>	 <200304290538.h3T5cLu16097@Port.imtp.ilyichevsk.odessa.ua>	 <3EAE220D.4010602@cyberone.com.au>	 <200304301202.h3UC2eu23935@Port.imtp.ilyichevsk.odessa.ua> <1051704438.19573.20.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1051704438.19573.20.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2003-04-30 at 13:10, Denis Vlasenko wrote:
>  
>
>>>Having the kernel not use 100% CPU?
>>>      
>>>
>>I suspect IDE error recovery path was never audited for that
>>    
>>
>
>NOTABUG
>
>User space keeps asking it to read so it keeps using CPU, fix the user
>space
>
>  
>
The application does an initial seek() command, which succeeds.
It then just does read() commands for then on.
For bug tracking, I have put printf statements in my application.
I.e.
printf("About to seek\n");
result seek();
printf("Seek done.\n");
BigLoop:
printf("About to read\n");
result = read(fd,buffer, x_bytes);
printf("read done.\n");
If (result != x_types) assert(0);
else loop back to BigLoop:

When an error occurs on the DVD, "read done" message is never printed on 
the console and all applications fail to respond to user input. This is 
why I thought that the kernel hogs CPU 100% and the application never 
receives the error message.
If I force a different error "tray open", by using a pin in the manual 
eject hole on the front of the dvd rom device, I then see the "read 
done" message and everything comes back to life.

To me, this is somewhat strange behaviour, a bug even.

Is there some other user space parts between the kernel and the "read 
done" message that I don't know about?

So, from the logs, it looks like the kernel tries to keep reading the 
DVD, but it is not the user application requesting that!
Is there some sort of caching code between read() and the kernel, and if 
so, how do I turn it off.

Cheers
James


