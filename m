Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbTK0T4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 14:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbTK0T4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 14:56:50 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:34035 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S261744AbTK0T4r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 14:56:47 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: None that appears to be detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: amanda vs 2.6 and FB problems
Date: Thu, 27 Nov 2003 14:56:46 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311271456.46293.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.54.127] at Thu, 27 Nov 2003 13:56:46 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That amanda vs 2.6 thread was getting verbose.

First, there's a bug in xconfig for 2.6.0-test11, which I just rebuilt 
again.  I had to turn off the VESA_FB with vim, its not an option in 
the xconfig menus.  So this boot is to 2.6.0-test11 with
# CONFIG_FB_VESA is not set
and using the deadline scheduler.

I have started X and logged back out twice, and still had an 
underscore cursor both times, so the disapperaring cursor problem 
seems to be solved.  Many thanks for the hint about framebuffers.

Now, using the deadline scheduler, lets see how an 'su amanda' works:
------------------------
root@coyote linux-2.6]# su amanda  <<<-instant
[amanda@coyote linux-2.6]$ exit
exit
[root@coyote linux-2.6]# su amanda <<<-instant
[amanda@coyote linux-2.6]$ exit
exit
[root@coyote linux-2.6]# su amanda <<<-instant
[amanda@coyote linux-2.6]$ exit
exit
[root@coyote linux-2.6]# su amanda <<<-instant
[amanda@coyote linux-2.6]$ exit
[root@coyote linux-2.6]# su amanda <<<- used ctrl+d to exit
[amanda@coyote linux-2.6]$ exit
[root@coyote linux-2.6]# su amanda <<<- hung, then killed su
Killed
[root@coyote linux-2.6]#
------------------------
So that didn't solve this.

BUT, I just did the whole next amanda snapshot install using 'su 
amanda -c "nameofjob"', after it had refused to do the su amanda by 
itself, and that worked 100% from another, same icon launched, shell 
window.  I'm beginning to think there's something in su thats kernel 
sensitive, and which is bypassed if you give it a job argument.

Am I making any sense at all here?

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

