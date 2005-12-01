Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932528AbVLAWXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528AbVLAWXw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVLAWXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:23:52 -0500
Received: from kirby.webscope.com ([204.141.84.57]:9867 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S932528AbVLAWXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:23:52 -0500
Message-ID: <438F77CA.3060106@m1k.net>
Date: Thu, 01 Dec 2005 17:23:06 -0500
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Perry Gilfillan <perrye@linuxmail.org>
CC: Mauro Carvalho Chehab <mchehab@infradead.org>,
       Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>, Don Koch <aardvark@krl.com>
Subject: Re: Gene's pcHDTV 3000 analog problem
References: <200511282205.jASM5YUI018061@p-chan.krl.com>	 <c35b44d70511291548lcb10361ifd3a4ea0f239662d@mail.gmail.com>	 <438CFFAD.7070803@m1k.net>	<200511300007.56004.gene.heskett@verizon.net>	 <438D38B3.2050306@m1k.net>	<200511301553.jAUFrSQx026450@p-chan.krl.com>	 <438E7107.3000407@linuxmail.org>	<438E8365.4020200@linuxmail.org>	 <438E84A4.8000601@m1k.net> <438E8A58.4010003@linuxmail.org>	 <438EBD43.3080400@linuxmail.org>  <438F38E6.7090303@m1k.net> <1133470859.23362.59.camel@localhost> <438F73E5.5020600@linuxmail.org>
In-Reply-To: <438F73E5.5020600@linuxmail.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perry Gilfillan wrote:

> Mauro Carvalho Chehab wrote:
>
>>     After checking the datasheets of Thompson tuner, and I have one 
>> guess:
>>
>>     At board description, tda9887 is not there. This tuner needs to work
>> properly.
>>
>>     This small patch does enable it for your board.
>>
>>     You should notice that you may need to use some parameters for 
>> tda0887
>> to work properly, like using port1=0 port2=0 qss=0 as insmod options for
>> this module. (these are some on/off bits at the chip, to enable some
>> special functions - if 0/0/0 doesn't work you may need to test 0/0/1, ..
>> 1/1/1). 
>
> This has fixed it for me!!  I compiled todays cvs, with out this 
> patch, to watch it fail, then added the line as noted, and reloaded 
> the modules without rebooting, and it worked.  I did a cold start to 
> see that it is repeatable, and it continues to work.  I used no extra 
> parameters, so the defaults are working fine.
>
> Cheers,
>
> Perry
>
>> Cheers, Mauro.
>>  
>> ------------------------------------------------------------------------
>>
>> Index: linux/drivers/media/video/cx88/cx88-cards.c
>> ===================================================================
>> RCS file: 
>> /cvs/video4linux/v4l-dvb/linux/drivers/media/video/cx88/cx88-cards.c,v
>> retrieving revision 1.108
>> diff -u -p -r1.108 cx88-cards.c
>> --- linux/drivers/media/video/cx88/cx88-cards.c    25 Nov 2005 
>> 10:24:13 -0000    1.108
>> +++ linux/drivers/media/video/cx88/cx88-cards.c    1 Dec 2005 
>> 20:56:43 -0000
>> @@ -569,6 +569,7 @@ struct cx88_board cx88_boards[] = {
>>         .radio_type     = UNSET,
>>         .tuner_addr    = ADDR_UNSET,
>>         .radio_addr    = ADDR_UNSET,
>> +        .tda9887_conf   = TDA9887_PRESENT,
>>         .input          = {{
>>             .type   = CX88_VMUX_TELEVISION,
>>             .vmux   = 0, 
>
HURRAY!!!!!

Signed-off-by: Michael Krufky <mkrufky@m1k.net>

... I'll go add this to cvs now.

