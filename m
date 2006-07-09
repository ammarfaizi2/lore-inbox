Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWGIQMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWGIQMm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 12:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWGIQMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 12:12:42 -0400
Received: from rubidium.solidboot.com ([81.22.244.175]:15524 "EHLO
	mail.solidboot.com") by vger.kernel.org with ESMTP id S1750796AbWGIQMl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 12:12:41 -0400
Message-ID: <44B12AF4.6030809@solidboot.com>
Date: Sun, 09 Jul 2006 19:12:36 +0300
From: =?ISO-8859-1?Q?Juha_Yrj=F6l=E4?= <juha.yrjola@solidboot.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org, jlavi@iki.fi
Subject: Re: [2.6 patch] make drivers/mtd/cmdlinepart.c:mtdpart_setup()	static
References: <20060626220215.GI23314@stusta.de>	 <1151416141.17609.140.camel@hades.cambridge.redhat.com>	 <20060629173206.GF19712@stusta.de> <1152436332.25567.12.camel@shinybook.infradead.org>
In-Reply-To: <1152436332.25567.12.camel@shinybook.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:

>>>> --- linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c.old 2006-06-26 23:18:39.000000000 +0200
>>>> +++ linux-2.6.17-mm2-full/drivers/mtd/cmdlinepart.c     2006-06-26 23:18:51.000000000 +0200
>>>> @@ -346,7 +346,7 @@
>>>>   *
>>>>   * This function needs to be visible for bootloaders.
>>>>   */
>>>> -int mtdpart_setup(char *s)
>>>> +static int mtdpart_setup(char *s) 
>>> Patch lacks sufficient explanation. Explain the relevance of the comment
>>> immediately above the function declaration, in the context of your
>>> patch. Explain your decision to change the behaviour, but not change the
>>> comment itself.
>> My explanation regarding the relevance of the comment is that it seems 
>> to be nonsense.
>>
>> Do I miss something, or why and how should a bootloader access 
>> in-kernel functions? 
> 
> I'm not entirely sure, but allegedly it does -- Juha, can you elaborate?

Our bootloader doesn't access in-kernel functions, for obvious reasons. 
  The comment in cmdlinepart.c is unfortunately inaccurate.  The 
bootloader does need a mechanism for passing the partition table to the 
kernel, though.  Our partition table is generated on-the-fly by the 
bootloader to guarantee that each partition gets a certain number of 
non-bad NAND blocks.

We used to do this by passing the partition table in a string compatible 
with cmdlinepart syntax.  The kernel NAND driver then just passed the 
string received from the bootloader to mtdpart_setup().

Nowadays there is a better way of doing this, so as far as we are 
concerned, mtdpart_setup() can be made static again.  We'll migrate our 
MTD drivers to use the platform_data mechanism instead.

Cheers,
Juha

