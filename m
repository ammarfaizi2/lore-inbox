Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319732AbSIMRzF>; Fri, 13 Sep 2002 13:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319734AbSIMRzF>; Fri, 13 Sep 2002 13:55:05 -0400
Received: from hermes.domdv.de ([193.102.202.1]:45838 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S319732AbSIMRzE>;
	Fri, 13 Sep 2002 13:55:04 -0400
Message-ID: <3D8227EA.6040708@domdv.de>
Date: Fri, 13 Sep 2002 20:01:14 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ahmed Masud <masud@googgun.com>
CC: Thunder from the hill <thunder@lightweight.ods.org>, dag@brattli.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
References: <Pine.LNX.4.44.0209131013080.10048-100000@hawkeye.luckynet.adm> <3D82247A.80601@googgun.com>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(rct@gherkin.frus.com removed from cc list as his mta treats (not only) 
my mails as spam...)

Ahmed Masud wrote:
> Thunder from the hill wrote:
> 
>> Hi,
>>
>> On Fri, 13 Sep 2002, Andreas Steinmetz wrote:
>>
>>> At least for gcc 3.2 this would be better:
>>>
>>> #define DERROR(dbg, fmt, args...) \
>>>     do { if (DEBUG_##dbg) \
>>>         printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
>>>     } while(0)
>>>
> Perhaps a hybrid of the two? :
> 
> #define DERROR(dbg, fmt, 
> args...)                                          \
>    do { if (DEBUG_##dbg) {                                                \
>                printk(KERN_INFO "irnet: %s() : ", __FUNCTION__);          \
>                printk(fmt, ## args);                                      \
>         }                                                                 \
>    } while (0)
> 
> 
How about what I did just suggest for smbfs?

#if __GNUC__>=3
#define DERROR(dbg, fmt, args...) \
   do { if (DEBUG_##dbg) \
       printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
   } while(0)
#else
#define DERROR(dbg, args...) \
   {if(DEBUG_##dbg) \
     printk(KERN_INFO "irnet: " __FUNCTION__ "(): " args);}
#endif

gcc 2 versions will be deprecated eventually some time in the future and 
in between the macro selection by gcc major version should be fair enough.
-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

