Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269184AbUIBVoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269184AbUIBVoJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 17:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269180AbUIBVmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 17:42:53 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:11524 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S269184AbUIBVkj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 17:40:39 -0400
To: george@mvista.com
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
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
	<87fz61yf75.fsf@devron.myhome.or.jp> <4137896E.5080802@mvista.com>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Fri, 03 Sep 2004 06:38:17 +0900
In-Reply-To: <4137896E.5080802@mvista.com>
Message-ID: <87u0uggxme.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> writes:

> OGAWA Hirofumi wrote:
> Well, my machine says the result should be 996000000, so something is
> wrong with your or my math.

Hmm.. I don't know why. I'm using x86 cpu machine.

> As to if the initial jiffie value should
> be a multiple of HZ, I don't see why.  I think it is several counts
> off of this value when the system wall clock is set in any case.

Ah, sorry for quite insufficiency explanation.

Since INITIAL_JIFFIES is -5 minutes, so I though tv.tv_nsec should be 0.
The cause of this is

     INITIAL_JIFFIES % HZ (4294667296 % 1000)

because INITIAL_JIFFIES is unsigned long.

So, I guessed this is not intention.
Looks like this should be (-300*1000) % 1000.

What do you think of this?
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
