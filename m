Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTH0Lat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263330AbTH0Lat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:30:49 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:13271
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S263310AbTH0Lar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:30:47 -0400
From: Con Kolivas <kernel@kolivas.org>
To: warudkar@vsnl.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4-mm1 - kswap hogs cpu OO takes ages to start!
Date: Wed, 27 Aug 2003 21:37:42 +1000
User-Agent: KMail/1.5.3
References: <200308272138.h7RLciK29987@webmail2.vsnl.net>
In-Reply-To: <200308272138.h7RLciK29987@webmail2.vsnl.net>
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308272137.42632.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

