Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264641AbSIWAt1>; Sun, 22 Sep 2002 20:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264643AbSIWAt1>; Sun, 22 Sep 2002 20:49:27 -0400
Received: from packet.digeo.com ([12.110.80.53]:19702 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264641AbSIWAt1>;
	Sun, 22 Sep 2002 20:49:27 -0400
Message-ID: <3D8E6647.8B02E613@digeo.com>
Date: Sun, 22 Sep 2002 17:54:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.38-mm1
References: <3D8D5F2A.BC057FC4@digeo.com> <20020923004036.GA13921@www.kroptech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 00:54:31.0325 (UTC) FILETIME=[C6B8D4D0:01C2629B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> 
> Trying to boot 2.5.38-mm1 on SMP ppro gives an endless stream of oopses. (Well,
> to be honest I only let it scroll for about 30 seconds before declaring it
> "endless" and hitting the reset button.) Same .config on 2.5.38 stock boots
> fine.

It found a bug.  Someone is calling kmem_cache_create() in an
atomic region.  Plus I think that during startup, in_atomic()
is (probably incorrectly) returning true.

I'll ratelimit it to one message per second.

You can kill the printk at the bottom of kernel/sched.c for now.
