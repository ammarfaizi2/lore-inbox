Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132219AbRCaD51>; Fri, 30 Mar 2001 22:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132227AbRCaD5R>; Fri, 30 Mar 2001 22:57:17 -0500
Received: from avocet.prod.itd.earthlink.net ([207.217.121.50]:13492 "EHLO
	avocet.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S132219AbRCaD5J>; Fri, 30 Mar 2001 22:57:09 -0500
Date: Fri, 30 Mar 2001 19:57:20 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: Pavel Machek <pavel@suse.cz>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
   Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: fbcon slowness [was NTP on 2.4.2?]
Message-ID: <Pine.LNX.4.31.0103301951180.743-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Probably the lack of hardware area copies has something to do with
>> this.  However, who isn't familiar with xterm "jump scroll" mode?
>> That's nice and fast.
>>
>> Could such a thing be implemented in the console driver?
>
>I believe so. It would be simple: if there's too much activit, defer
>framebuffer updates and only update in-memory copy. Sync from time to
>time. I'd certainly like to see that.

If the time between syncs gets to big then the amount of data to go over
the bus would kill performance. Plus this has the problem that even
small areas like 12x20 areas become more expensive as the bpp increases. A
better solution is to implement accelerated copyareas. In fact for 2.5.X I
have the fbcon system wrapped around using accels instead of writing to the
framebuffer directly. I have had enormous improvements doing this. Plus
using this approach makes the fbcon layer much simpler and smaller in size.
Thus better performace overall.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

