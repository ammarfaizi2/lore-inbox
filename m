Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289045AbSAFXrz>; Sun, 6 Jan 2002 18:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289047AbSAFXro>; Sun, 6 Jan 2002 18:47:44 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:32901 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S289045AbSAFXrb>; Sun, 6 Jan 2002 18:47:31 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 6 Jan 2002 15:47:30 -0800
Message-Id: <200201062347.PAA01754@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.2.9: fbdev kdev_t build fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>"Adam J. Richter" wrote:

>> [...] So, as far as I
>> can tell, these initializations of fb_info.node are just wasting
>> CPU cycles and confusing developers.
>> 
>>         Can anyone identify a place that uses the initialized value
>> of fb_info.node prior to fb_info.node being set by register_framebuffer?

>Your question here shows that you did not check.

>There are failure paths in register_framebuffer by which an
>uninitialized value may be displayed by a printk, if you delete the
>.node = NODEV initialization.  So, your patch breaks things.

>       Jeff

        I looked before and did not notice any such case.  I looked
again now at register_framebuffer and did not notice any such case.
It is something that can be missed and I don't know why you phrased
your response as if it would not be easy to miss ("Your question here
shows that you did not check").  Attempts at proof by intimidation
can produce bad decisions, in this case it may produce slightly
slower and bigger code.

        How about pointing out where this occurs in
register_framebuffer?  Then we can see if it is something where printing
out this initialized value actually records information that it not
otherwise clear from the printk (e.g., perhaps it is a printk that
is never called after the "node" field has been set to something
sensible).

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
