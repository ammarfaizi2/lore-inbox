Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWDTXSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWDTXSE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932132AbWDTXSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:18:04 -0400
Received: from s0006.shadowconnect.net ([213.202.216.60]:680 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S932129AbWDTXSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:18:02 -0400
Message-ID: <444816A2.8090302@shadowconnect.com>
Date: Fri, 21 Apr 2006 01:17:54 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/message/i2o/iop.c: static inline functions
 mustn't be exported
References: <20060418150615.GH11582@stusta.de> <20060418230600.4bccd221.akpm@osdl.org>
In-Reply-To: <20060418230600.4bccd221.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
>> static inline functions mustn't be exported.
> Actually, exports of static inlines work OK.  The compiler will emit an
> out-of-line copy to satisfy EXPORT_SYMBOL's reference and the module
> namespace is separate from the compiler&linker's namespace.
> Of course, things will screw up when we're using the compiler&linker
> namespace (ie: the driver is statically linked).
>> --- linux-2.6.17-rc1-mm2-full/drivers/message/i2o/iop.c.old	2006-04-13 17:30:41.000000000 +0200
>> +++ linux-2.6.17-rc1-mm2-full/drivers/message/i2o/iop.c	2006-04-13 17:30:57.000000000 +0200
>> @@ -1243,7 +1243,6 @@
>>  EXPORT_SYMBOL(i2o_cntxt_list_get_ptr);
>>  #endif
>>  EXPORT_SYMBOL(i2o_msg_get_wait);
>> -EXPORT_SYMBOL(i2o_msg_nop);
>>  EXPORT_SYMBOL(i2o_find_iop);
>>  EXPORT_SYMBOL(i2o_iop_find_device);
>>  EXPORT_SYMBOL(i2o_event_register);
> It depends whether Markus thinks this symbol is something which the driver
> should be exporting.  If so, we should uninline i2o_msg_nop().  But given
> that it's in a header, nobody should be linking to it anyway...
 > (why on earth does i2o put semicolons after its function definitions?)

OK, i could live with both versions... The EXPORT_SYMBOL was needed in 
earlier version, but i forgot to remove it when i inlined the function 
and put it into the header.

If someone thinks the inline is to expensive here, please let me know and 
i will submit a patch to reverse it again.


Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
