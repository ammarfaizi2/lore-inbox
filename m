Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTH0Pxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTH0Pxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:53:46 -0400
Received: from webmail2.vsnl.net ([203.197.12.44]:39900 "EHLO bom6.vsnl.net.in")
	by vger.kernel.org with ESMTP id S263526AbTH0Pxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:53:43 -0400
Date: Wed, 27 Aug 2003 21:25:23 -0500 (GMT)
Message-Id: <200308280225.h7S2PNa26057@webmail2.vsnl.net>
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)
From: warudkar@vsnl.net
To: kernel@kolivas.org, wli@holomorphy.com, linux-kernel@vger.kernel.org
X-Mailer: VSNL, Web based email
X-Sender-Ip: 203.197.141.34
Cc: Andrew Morton <akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con - With swappiness set to 100, the apps do start up in 3 minutes and kswapd doesn't hog the CPU. But X is still unusable till all of them have started up.
Wli - Sorry, vmstat segfaults on 2.6!

kernel@kolivas.org wrote
On Thu, 28 Aug 2003 07:38, warudkar@vsnl.net wrote:
> Trying out 2.6.0-test4-mm1. Inside KDE, I start OpenOffice.org, Rational
> Rose and Konsole at a time. All of these take extremely long time to
> startup. (approx > 5 minutes). Kswapd hogs the CPU all the time. X becomes
> unusable till all of them startup, although I can telnet and run top. Same
> thing run under 2.4.18 starts up in 3 minutes, X stays usable and kswapd
> never take more than 2% CPU.

Yes I can reproduce this with a memory heavy load as well on low memory 
(linking at the end of a big kernel compile is standard problem). I actually 
found the best workaround was to increase the swappiness instead of 
decreasing it.

Try 
echo 100 > /proc/sys/vm/swappiness

time it

then try
echo 0 > /proc/sys/vm/swappiness

you'll see that at low swappiness kswapd0 can use ridiculous amounts of cpu 
trying to avoid swap. The default is 60.

Con
