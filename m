Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268159AbTBNCkU>; Thu, 13 Feb 2003 21:40:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268160AbTBNCkU>; Thu, 13 Feb 2003 21:40:20 -0500
Received: from ns.cinet.co.jp ([61.197.228.218]:27659 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S268159AbTBNCkT>;
	Thu, 13 Feb 2003 21:40:19 -0500
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A332@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Christoph Hellwig '" <hch@infradead.org>,
       "'jsimmons@infradead.org '" <jsimmons@infradead.org>
Cc: "'Linux Kernel Mailing List '" <linux-kernel@vger.kernel.org>,
       "'Alan Cox '" <alan@lxorguk.ukuu.org.uk>
Subject: RE: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) consol
	e
Date: Fri, 14 Feb 2003 11:50:09 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comments.

-----Original Message-----
From: Christoph Hellwig
To: Osamu Tomita; jsimmons@infradead.org
Cc: Linux Kernel Mailing List; Alan Cox
Sent: 2003/02/13 0:36
Subject: Re: [PATCHSET] PC-9800 subarch. support for 2.5.60 (12/34) console

> On Wed, Feb 12, 2003 at 10:42:33PM +0900, Osamu Tomita wrote:
>> +ifneq ($(CONFIG_X86_PC9800),y)
>>  FONTMAPFILE = cp437.uni
>> +else
>> +FONTMAPFILE = pc9800.uni
>> +endif
> 
> This should be
> 
> ifeq ($(CONFIG_X86_PC9800),y)
> FONTMAPFILE = pc9800.uni
> else
> FONTMAPFILE = cp437.uni
> endif
I see. I'll fix it.

> but I really wonder whether there's something nicer possible
We need pc9800.uni to display japanese "KANA" letters.
I want another nice idea too.

>> diff -Nru linux/drivers/char/console_macros.h
> Bah, console_macros.h should just die.
Thanks for the information.

>> diff -Nru linux/drivers/char/console_pc9800.h
> I think this should all be in include/linux/console.h.
I'm planning to use console_pc9800.h for PC-9800 specific macoros.
I'm testing it on 2.4.20.

>> --- linux/drivers/char/vt.c	2002-12-16 11:08:16.000000000 +0900
>> +++ linux98/drivers/char/vt.c	2002-12-20 14:52:06.000000000 +0900
>> @@ -75,6 +75,9 @@
>>   */
>>  
>>  #include <linux/module.h>
>> +#ifdef CONFIG_X86_PC9800
>> +#define CONFIG_KANJI
>> +#endif
> 
> Please set CONFIG_KANJI in the Kconfig file and in general
> the CONFIG_KANJI usere look really messy.  I don't think it's
> easy to get them cleaned up before 2.6, you might get in contact
> with James who works on the console layer to properly integrate them.
I think too, CONFIG_KANJI needs cleanup.

Regards,
Osamu Tomita
