Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbWFSMKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbWFSMKL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWFSMKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:10:11 -0400
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:14829 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932402AbWFSMKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:10:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: tglx@timesys.com
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and  dynamic HZ
Date: Mon, 19 Jun 2006 22:09:36 +1000
User-Agent: KMail/1.9.3
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>
References: <1150643426.27073.17.camel@localhost.localdomain> <449580CA.2060704@gmail.com> <1150660202.27073.23.camel@localhost.localdomain>
In-Reply-To: <1150660202.27073.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606192209.38403.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 05:50, Thomas Gleixner wrote:
> Michal,
>
> On Sun, 2006-06-18 at 18:35 +0200, Michal Piotrowski wrote:
> > HARNING:
> > /lib/modules/2.6.17-hrt-dyntick1/kernel/sound/pci/ac97/snd-ac97-codec.ko
> > needs unknown symbol msecs_to_jiffies WARNING:
> > /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/net/skge.ko needs unknown
> > symbol jiffies_to_msecs WARNING:
> > /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/cpufreq/cpufreq_ondemand.
> >ko needs unknown symbol jiffies_to_usecs
> >
> > Here is fix small fix.
>
> Applied, thanks.
>
> New patch available at:
>
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick2.patch
>
> http://www.tglx.de/projects/hrtimers/2.6.17/patch-2.6.17-hrt-dyntick2.patch
>es.tar.bz2

Also suffers from:
WARNING: "timespec_to_jiffies" [fs/fuse/fuse.ko] undefined!

Here is a fix

---
 kernel/time.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.17-hrt-dyntick2.patch/kernel/time.c
===================================================================
--- linux-2.6.17-hrt-dyntick2.patch.orig/kernel/time.c	2006-06-19 22:02:32.000000000 +1000
+++ linux-2.6.17-hrt-dyntick2.patch/kernel/time.c	2006-06-19 22:08:39.000000000 +1000
@@ -773,6 +773,8 @@ timespec_to_jiffies(const struct timespe
 
 }
 
+EXPORT_SYMBOL(timespec_to_jiffies);
+
 void
 jiffies_to_timespec(const unsigned long jiffies, struct timespec *value)
 {

-- 
-ck
