Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292324AbSBUKfL>; Thu, 21 Feb 2002 05:35:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292323AbSBUKfB>; Thu, 21 Feb 2002 05:35:01 -0500
Received: from mta07-svc.ntlworld.com ([62.253.162.47]:60128 "EHLO
	mta07-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S286179AbSBUKeu>; Thu, 21 Feb 2002 05:34:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: SA <super.aorta@ntlworld.com>
To: linux-kernel@vger.kernel.org
Subject: Swap / thrashing / fatal crash
Date: Thu, 21 Feb 2002 10:41:27 +0000
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020221103449.YCUZ22101.mta07-svc.ntlworld.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear list,

Not that I can think anything can be done about this but--

My system went down after a memory leak (probably X) and a large application 
caused the swap to run out.  It looked like as soon as the swap space became 
critical kswapd thrashed around eating all CPU for ~ 10 minutes preventing me 
from logging in as root to kill off either X or the large application- 
eventually the system locked solid and power cycling was the only way to go.
After ~ 20 hours uptime.

There is no record in /var/log/messages-

I seem to recall that under k2.2.xx this sort of thing would end up with 
something getting a signal -KILL rather than thrashing.

Maybe there should be a swap memory high water mark and kswapd should spot 
thrashing resort to some fail-sfae behaviour  (maybe it does this already?) 
and protect one virtual console or soemthing...

In the mean time I will just keep a closer eye on things.

mtt



Information
uname -a
Linux trouble 2.4.7-10 #1 Thu Sep 6 16:46:36 EDT 2001 i686 unknown

# on a fresh reboot
cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  459632640 443174912 16457728     8192  4988928 88207360
Swap: 945864704 13381632 932483072

Size of "large application" 257Mb
X appeared to have grown to 1Gb  (from top so this may not be accurate), but 
it is impossible to say as the system was not responsive for that last 10 
minutes before it locked.

