Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTD3X52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbTD3X52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:57:28 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:58294 "EHLO
	lakemtao02.cox.net") by vger.kernel.org with ESMTP id S262598AbTD3X5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:57:23 -0400
Message-ID: <3EB065B4.6050309@cox.net>
Date: Wed, 30 Apr 2003 19:09:24 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
References: <20030424212508.GI14661@codepoet.org> <200304251401.36430.m.c.p@wolk-project.de> <200304251410.31701.m.c.p@wolk-project.de> <20030430090242.GA15480@codepoet.org> <3EB02D0F.1080101@cox.net> <20030430205021.GA20614@codepoet.org>
In-Reply-To: <20030430205021.GA20614@codepoet.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Wed Apr 30, 2003 at 03:07:43PM -0500, David van Hoose wrote:
> 
>>I'm getting an unresolved in soundcore.o that is preventing me from 
>>having sound.
>>/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: unresolved symbol 
>>devfs_remove
>>/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod 
>>/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o failed
>>/lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod snd-card-0 failed
>>
>>Can that be fixed?
> 
> 
> It looks like this is simply a minor include file problem.
> sound/sound_core.c needs 
>     #include <sound/driver.h>
> added to it which should hopefully make this problem go away.
> 
> 
>>Also I have problems if I compile USB Audio and USB MIDI from the USB 
>>section AND USB Audio and USB MIDI from the ALSA section. Compilation 
>>fails in that situation. Might want to put the former patch up if this 
>>stuff might take a while to fix.
> 
> 
> This looked trivial enough to fix, I went ahead and
> regenerated my patch with these changes,

Got it. I patched sound_core.c and I have sound now. I'm assuming that 
was the only file that needed to be patched. Correct? Also, should the 
OSS soundcore option in menuconfig always be 'Y'? It seems to not want 
to be anything else.

I get this warning on almost every file during the compile.
In file included from /usr/src/linux-2.4.21-rc1/include/sound/driver.h:43,
                   from hwdep.c:22:
/usr/src/linux-2.4.21-rc1/include/sound/adriver.h:320:1: warning:
"vmalloc_to_page" redefined
In file included from
/usr/src/linux-2.4.21-rc1/include/linux/modversions.h:185,
from <command line>:1:
/usr/src/linux-2.4.21-rc1/include/linux/modules/ksyms.ver:66:1: warning:
this is the location of the previous definition

Another trivial patch perhaps?

Thanks for the patch!
David

