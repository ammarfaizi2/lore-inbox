Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266020AbSKOIV3>; Fri, 15 Nov 2002 03:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266042AbSKOIV2>; Fri, 15 Nov 2002 03:21:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:16882 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266020AbSKOIV1>;
	Fri, 15 Nov 2002 03:21:27 -0500
Message-ID: <3DD4B01F.B3C1DCDC@digeo.com>
Date: Fri, 15 Nov 2002 00:28:15 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Justin A <ja6447@albany.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.47-ac4 panic on boot.
References: <200211150059.51743.ja6447@albany.edu> <3DD49520.7927434C@digeo.com> <200211150254.25306.ja6447@albany.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Nov 2002 08:28:16.0411 (UTC) FILETIME=[F20806B0:01C28C80]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin A wrote:
> 
> I did that...
> Disabling PM made it boot:
> 
> < CONFIG_PM=y
> < CONFIG_APM=m
> < # CONFIG_APM_IGNORE_USER_SUSPEND is not set
> < CONFIG_APM_DO_ENABLE=y
> < CONFIG_APM_CPU_IDLE=y
> < CONFIG_APM_DISPLAY_BLANK=y
> < # CONFIG_APM_RTC_IS_GMT is not set
> < # CONFIG_APM_ALLOW_INTS is not set
> < # CONFIG_APM_REAL_MODE_POWER_OFF is not set
> ---
> > # CONFIG_PM is not set
> 
> I think I still had swsusp on before I disabled PM...I will have to test more
> tomorrow to make sure thats it...
> Perhaps its the CONFIG_APM_CPU_IDLE that did it?

Could be...

> I had tried linux init=/bin/sh, which got to the shell, then 2 seconds later
> paniced, so I have a feeling its the idle thingy:)

slab runs a timer every couple of seconds to drain caches which could
otherwise be wasted-for-ever memory.  So it looks like we don't get
to find out about abuse until much later.  Damn.

Oh, it'd be interesting to enable memory debugging under the kernel-hacking
menu - that may trap the bug when it's happening.
