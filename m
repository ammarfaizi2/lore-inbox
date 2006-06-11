Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWFKOho@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWFKOho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751615AbWFKOho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 10:37:44 -0400
Received: from aun.it.uu.se ([130.238.12.36]:25741 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751613AbWFKOhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 10:37:43 -0400
Date: Sun, 11 Jun 2006 16:37:31 +0200 (MEST)
Message-Id: <200606111437.k5BEbVu5021415@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: rdunlap@xenotime.net, sam@ravnborg.org
Subject: Re: [PATCH] [2.6.17-rc6] Section mismatch in drivers/net/ne.o during modpost
Cc: akpm@osdl.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Jun 2006 22:38:00 +0200, Sam Ravnborg wrote:
>> --- linux-2617-rc6.orig/drivers/net/ne.c
>> +++ linux-2617-rc6/drivers/net/ne.c
>> @@ -829,7 +829,7 @@ that the ne2k probe is the last 8390 bas
>>  is at boot) and so the probe will get confused by any other 8390 cards.
>>  ISA device autoprobes on a running machine are not recommended anyway. */
>>  
>> -int init_module(void)
>> +int __init init_module(void)
>>  {
>>  	int this_dev, found = 0;
>
>When you anyway touches the driver I suggest to name the function
><module>_init, <module>_cleanup and use module_init(), module_cleanup().

Maybe not: in the ne.c driver init_module() is inside #ifdef MODULE,
so conversion to ne_init() + module_init(ne_init) would be a no-op
except for making the code larger. In the non-MODULE case Space.c
calls ne_probe() directly.

/Mikael
