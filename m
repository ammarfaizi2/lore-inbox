Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267338AbUIATQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267338AbUIATQt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 15:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267406AbUIATQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 15:16:49 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:59918 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S267338AbUIATQq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 15:16:46 -0400
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: john stultz <johnstul@us.ibm.com>, george anzinger <george@mvista.com>,
       Andrew Morton <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       albert@users.sourceforge.net, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
References: <87smcf5zx7.fsf@devron.myhome.or.jp>
	<20040816124136.27646d14.akpm@osdl.org>
	<Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	<412285A5.9080003@mvista.com>
	<1092782243.2429.254.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
	<1092787863.2429.311.camel@cog.beaverton.ibm.com>
	<1092781172.2301.1654.camel@cube>
	<1092791363.2429.319.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de>
	<20040819191537.GA24060@elektroni.ee.tut.fi>
	<20040826040436.360f05f7.akpm@osdl.org>
	<Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de>
	<Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de>
	<1093916047.14662.144.camel@cog.beaverton.ibm.com>
	<Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 02 Sep 2004 04:14:22 +0900
In-Reply-To: <Pine.LNX.4.53.0408310757430.6523@gockel.physik3.uni-rostock.de>
Message-ID: <87fz61yf75.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> writes:

> However, the actual reason were just missing wall_to_monotonic 
> initializations:
> 
>   http://www.uwsg.iu.edu/hypermail/linux/kernel/0306.2/1330.html

Sorry for may not be related question in this thread.


         xtime.tv_nsec = (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ);

#include <stdio.h>

#define HZ 1000
#define NSEC_PER_SEC (1000000000L)
#define INITIAL_JIFFIES ((unsigned long)(unsigned int) (-300*HZ))

int main()
{
	printf("%ld\n", (INITIAL_JIFFIES % HZ) * (NSEC_PER_SEC / HZ));
	return 0;
}

hirofumi@devron (a)[1006]$ ./c
296000000

xtime.tv_nsec was not 0. Is this bug?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
