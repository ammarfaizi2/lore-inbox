Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271063AbTGWAia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 20:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271064AbTGWAia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 20:38:30 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:22266 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271063AbTGWAi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 20:38:29 -0400
Subject: Re: another must-fix: major PS/2 mouse problem
From: Albert Cahalan <albert@users.sf.net>
To: Yoann <linux-yoann@ifrance.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>, vortex@scyld.com, jgarzik@pobox.com
In-Reply-To: <3EDD8850.9060808@ifrance.com>
References: <1054431962.22103.744.camel@cube> <3EDCF47A.1060605@ifrance.com>
	 <1054681254.22103.3750.camel@cube>  <3EDD8850.9060808@ifrance.com>
Content-Type: text/plain
Organization: 
Message-Id: <1058921044.943.12.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 Jul 2003 20:44:05 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I may have found the problem!

On Tue, 2003-06-03 at 15:18, Yoann wrote:

> I have the same problem with my laptop, chip sis630,
> celeron 1.2Ghz, 256MB of RAM (32MB for video), mouse
> on PS/2 (ImPS/2) abd read mp3 throught nfs partition
> (ethernet 100MB). I haven't try without traffic on
> nfs but I will try next time I boot on the 2.5.70

Using the lockmeter on a 2.5.75 kernel, I discovered
that boomerang_interrupt() grabs a spinlock for over
1/4 second. No joke, 253 ms. Interrupts are off AFAIK.

Mouse behavior is terrible.

It should be no surprise that NTP isn't working too
well either. The ntpd daemon keeps complaining about
losing sync and having to advance the clock by amounts
of over 100 seconds.

Could somebody with the hardware manual take a look
at that function?


