Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265583AbTGDAEe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 20:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbTGDAEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 20:04:34 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:26527 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S265583AbTGDAEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 20:04:30 -0400
Date: Fri, 4 Jul 2003 02:18:40 +0200 (MEST)
Message-Id: <200307040018.h640IeYQ018389@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: rmk@arm.linux.org.uk
Subject: Re: [PATCH][2.5.74] correct gcc bug comment in <linux/spinlock.h>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003 17:42:04 +0100, Russell King wrote:
>On Thu, Jul 03, 2003 at 06:08:11PM +0200, Mikael Pettersson wrote:
>> Linus,
>> 
>> This patch updates include/linux/spinlock.h's comment regarding gcc
>> bugs for empty struct initializers, to correctly state that the bug
>> is present also in 2.95.x and at least early versions of 2.96 (as
>> reported by one Mandrake user).
>> 
>> /Mikael
>> 
>> --- linux-2.5.74/include/linux/spinlock.h.~1~	2003-07-03 12:32:46.000000000 +0200
>> +++ linux-2.5.74/include/linux/spinlock.h	2003-07-03 16:07:59.772534704 +0200
>> @@ -144,7 +144,7 @@
>>  	} while (0)
>>  #else
>>  /*
>> - * gcc versions before ~2.95 have a nasty bug with empty initializers.
>> + * gcc versions up to 2.95, and early versions of 2.96, have a nasty bug with empty initializers.
>>   */
>>  #if (__GNUC__ > 2)
>>    typedef struct { } spinlock_t;
>
>This also isn't that clear (does it mean up to 2.95.0 but not including
>2.95.1 etc.)  Also, we don't build with gcc < 2.95 anyway, so there's
>no need to mention anything older.  This removes the doubt:
>
>"All gcc 2.95 versions and early versions of gcc 2.96 have a nasty bug with
> empty initializers."

Agreed. More precision is better. Updated patch below.

/Mikael

--- linux-2.5.74/include/linux/spinlock.h.~1~	2003-07-03 12:32:46.000000000 +0200
+++ linux-2.5.74/include/linux/spinlock.h	2003-07-04 02:01:05.982375152 +0200
@@ -144,7 +144,8 @@
 	} while (0)
 #else
 /*
- * gcc versions before ~2.95 have a nasty bug with empty initializers.
+ * All gcc 2.95 versions and early versions of 2.96 have a nasty bug
+ * with empty initializers.
  */
 #if (__GNUC__ > 2)
   typedef struct { } spinlock_t;
