Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUIWETi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUIWETi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 00:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268257AbUIWESl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 00:18:41 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:8891 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S268254AbUIWEME
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 00:12:04 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: 2.6.9-rc2-mm2 vs glxgears
Date: Thu, 23 Sep 2004 00:12:00 -0400
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409230012.00894.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.51.220] at Wed, 22 Sep 2004 23:12:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

One of the things I noted about the last few kernels is that glxgears 
seems to get tangled up in a bowl of very stiff molasses, for 
instance from 2.6.9-rc1-mm5:

[root@coyote root]# glxgears
1622 frames in 5.0 seconds = 324.400 FPS
932 frames in 5.0 seconds = 186.400 FPS
800 frames in 5.0 seconds = 160.000 FPS
712 frames in 5.0 seconds = 142.400 FPS
637 frames in 5.0 seconds = 127.400 FPS
624 frames in 5.0 seconds = 124.800 FPS
564 frames in 5.0 seconds = 112.800 FPS
554 frames in 5.0 seconds = 110.800 FPS
553 frames in 5.0 seconds = 110.600 FPS
554 frames in 5.0 seconds = 110.800 FPS
554 frames in 5.0 seconds = 110.800 FPS
525 frames in 5.0 seconds = 105.000 FPS
499 frames in 5.0 seconds = 99.800 FPS
498 frames in 5.0 seconds = 99.600 FPS
499 frames in 5.0 seconds = 99.800 FPS
499 frames in 5.0 seconds = 99.800 FPS
498 frames in 5.0 seconds = 99.600 FPS
499 frames in 5.0 seconds = 99.800 FPS
499 frames in 5.0 seconds = 99.800 FPS
498 frames in 5.0 seconds = 99.600 FPS
498 frames in 5.0 seconds = 99.600 FPS
499 frames in 5.0 seconds = 99.800 FPS
499 frames in 5.0 seconds = 99.800 FPS
498 frames in 5.0 seconds = 99.600 FPS
Broken pipe

But, imagine by surprise when I rebooted to rc2-mm2 and found this:
[root@coyote root]# glxgears
49 frames in 5.0 seconds =  9.800 FPS
46 frames in 5.0 seconds =  9.200 FPS
46 frames in 5.0 seconds =  9.200 FPS
31 frames in 5.0 seconds =  6.200 FPS <-I started kmail here
37 frames in 5.0 seconds =  7.400 FPS
49 frames in 5.0 seconds =  9.800 FPS
47 frames in 5.0 seconds =  9.400 FPS
49 frames in 5.0 seconds =  9.800 FPS
50 frames in 5.0 seconds = 10.000 FPS
50 frames in 5.0 seconds = 10.000 FPS
50 frames in 5.0 seconds = 10.000 FPS
50 frames in 5.0 seconds = 10.000 FPS
Broken pipe

Now, just for grins, I going to rebuild 2.6.9-rc1-mm5 without cachefs 
to see if that makes any difference.

Not enough to bother calling mother over:

[root@coyote root]# glxgears
1516 frames in 5.0 seconds = 303.200 FPS
983 frames in 5.0 seconds = 196.600 FPS
832 frames in 5.0 seconds = 166.400 FPS
703 frames in 5.0 seconds = 140.600 FPS
663 frames in 5.0 seconds = 132.600 FPS
623 frames in 5.0 seconds = 124.600 FPS
585 frames in 5.0 seconds = 117.000 FPS
553 frames in 5.0 seconds = 110.600 FPS
554 frames in 5.0 seconds = 110.800 FPS
554 frames in 5.0 seconds = 110.800 FPS
554 frames in 5.0 seconds = 110.800 FPS
554 frames in 5.0 seconds = 110.800 FPS
514 frames in 5.0 seconds = 102.800 FPS
499 frames in 5.0 seconds = 99.800 FPS
499 frames in 5.0 seconds = 99.800 FPS
499 frames in 5.0 seconds = 99.800 FPS
499 frames in 5.0 seconds = 99.800 FPS
498 frames in 5.0 seconds = 99.600 FPS
499 frames in 5.0 seconds = 99.800 FPS
496 frames in 5.0 seconds = 99.200 FPS
Broken pipe

Its not using any cpu unless you count once or twice I saw it 
report .25%.

Definitely weirdsville incorporated though.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
