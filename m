Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264400AbRGCNKr>; Tue, 3 Jul 2001 09:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264395AbRGCNKh>; Tue, 3 Jul 2001 09:10:37 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:28329 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S264400AbRGCNKZ>; Tue, 3 Jul 2001 09:10:25 -0400
Date: Tue, 3 Jul 2001 06:10:21 -0700
From: "Adam J. Richter" <adam@ns1.yggdrasil.com>
Message-Id: <200107031310.GAA03900@ns1.yggdrasil.com>
To: sjhill@cotw.com
Subject: Re: linux-2.4.6-pre8/drivers/mtd/nand/spia.c: undefined symbols
Cc: dwmw2@redhat.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>         linux-2.4.6-pre8/drivers/mtd/nand/spia.c references four
>> undefined symbols, presumably intended to be #define constants,
>> although I am not sure what their values are supposed to be:
>> 
>>         IO_BASE
>>         FIO_BASE
>>         PEDR
>>         PEDDR
>> 
>The way that I architected the raw NAND flash device driver was to
>break it into 2 parts. 'nand.c' contains the actual driver code and
>is considered to be device independent. 'spia.c' is the device
>dependent part. You should write your own version of 'spia.c' and
>"simply" fill in the addresses for the IO address and control
>register address depending on your specific hardware. The above
>symbols are only defined for my specific hardware. They should be
>changed to values used on your hardware platform. Let me know if
>you need further assistance.

>-Steve

>-- 
> Steven J. Hill - Embedded SW Engineer

	If there is no architecture on which
linux-2.4.6-pre8/drivers/mtd/nand/spia.c will compile in its
"pristine" form, then the CONFIG_MTD_NAND_SPIA should be commented
out from drivers/mtd/nand/Config.in to avoid wasting the time of
users and automated build processes alike that just want to build
all available modules by default.  (At the moment, this code is
not even bracketed by CONFIG_EXPERIMENTAL, although changing that
would not be a sufficient fix.)

	Alternatively, if you will send me a one line description
of each of those four #define parameters, I will be happy to do the grunt
work of submiting a patch to you or whoever is appropriate to replace
those values with module and setup parameters that default to those
values if there are #defined and otherwise will abort initialization
if they are not #defined and no values were provided at run time.
(Or, better, yet, you can do this work!)

	Please let me know how you want to proceed.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


