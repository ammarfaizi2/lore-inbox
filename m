Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVFNPLD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVFNPLD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 11:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVFNPLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 11:11:02 -0400
Received: from mail.gmx.net ([213.165.64.20]:14292 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261335AbVFNOxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 10:53:46 -0400
X-Authenticated: #137701
From: Alexander Gretencord <arutha@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Swapping in 2.6.10 and 2.6.11.11 on a desktop system
Date: Tue, 14 Jun 2005 16:53:30 +0200
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
X-Length: 1578
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200506141653.32093.arutha@gmx.de>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[1] With swappiness = 60 I either get swap hell (2.6.10) or the oom killer 
kicks in (2.6.11.11)

[2] I upgraded to 2.6.11.11 from 2.6.8.1 yesterday and tried to compile 
something. After some time I come back and the compile has aborted because 
the oom killer killed the compiler process. There is no additional use of 
swap space (although some applications that were also running could have been 
swapped out). There was a similar bugreport with this behaviour some time ago 
for 2.6.11.8 but that one included a swappiness value of 0, i got 60.

Then I tried 2.6.10. The oom bugs were gone, the compile finished over night. 
About an hour ago I started a very RAM consuming application and at 2/3 RAM 
usage I get swap hell. The system constantly swaps, yet ram usage _and_ swap 
usage stay about the same. Even setting swappiness to 0 from an ssh login 
(switching to a console does not work) did not help, only killing the 
consuming application.

I also applied the ck hard-swappiness Patch to my 2.6.10 and tested a bit 
further. Depending on the swappiness I get hellish swapping behaviour at 
different levels of RAM usage and even managed to get the oom killer to step 
in (at swappiness=20). I had about 250MB of RAM used and boom -> oom killer 
shoots down some bigger java processes. At swappiness=80 I get massive 
swapping with 250MB of RAM usage. When reaching that level, the fs cache goes 
up to 300MB while the applications that need the ram are left with about 120 
megs. Rest was buffers.

I'm really out of ideas. 2.6.8.1 with swappiness=0 is by far the best I've 
managed to get by now. With that I can use my system until RAM and swap are 
completely full. No swap hell and no oom killer yet. Maybe I just have to 
search the lkml a bit more to find something usable. If someone else already 
has, please tell me (and tell me why it's not in the mainline kernel 
already :))

I have 512MB of RAM and another 512MB of swap.

Please cc me in replies as I'm not on the list.


Alex
