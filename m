Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261209AbVCTNfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbVCTNfX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 08:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVCTNfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 08:35:23 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:33194 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261209AbVCTNfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 08:35:01 -0500
Date: Sun, 20 Mar 2005 14:34:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Short sleep precision
In-Reply-To: <Pine.LNX.4.62.0503201335420.2501@dragon.hyggekrogen.localhost>
Message-ID: <Pine.LNX.4.61.0503201427010.31416@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503201316320.18044@yvahk01.tjqt.qr>
 <Pine.LNX.4.62.0503201335420.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Running your program here I see even worse values than that on 2.6.11-mm4 
>and it's also interresting to see that for a lot of continuous runs the 
>values reported drop steadily and eventually settle around ~1100, but if I 
>insert a  sleep 1  between runs, then I see a steady ~1000 reported.
>This is all with HZ = 1000

That may be related to the new mix of USER_HZ. I can't really tell, 
just observed that there is such.

>Linux nanosleep() used to have a busywait loop for sleeps less than two
>milliseconds.  2.4.x still does.

Yes, I know. Linus threw it out during 2.5 because it was deemed to buggy.
That did not affect me, because that busywaiting is only possible in 
!SCHED_OTHER, which I cannot use, because tiny delays are needed in a 
user-runnable userspace app, and I don't want it suid and stuff.

(I've developed an "overhead correction" for accurate(*) realtime replay of 
logfiles. (*) with respect to the total runtime. Works well.)

>You can spin on the gettimeofday() result in userspace.

How can I use it? / What does it help me? I just have the gettimeofday() in 
the example script to measure the total time of nanosleep(). Sometimes, 
nanosleep completes in the same tick, sometimes (95%), another task is 
scheduled before returning. I am calling nanosleep repetedly to find out the 
_average_ time for a 0us-nanosleep(), usually 100/1000 us.



Jan Engelhardt
-- 
