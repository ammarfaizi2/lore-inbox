Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269713AbSISAae>; Wed, 18 Sep 2002 20:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269714AbSISAae>; Wed, 18 Sep 2002 20:30:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:20868 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S269713AbSISAad>;
	Wed, 18 Sep 2002 20:30:33 -0400
Message-ID: <3D891BD1.8F774946@digeo.com>
Date: Wed, 18 Sep 2002 17:35:29 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Duncan Sands <duncan.sands@math.u-psud.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: fsync 50 times slower after 2.5.27
References: <200209190222.33276.duncan.sands@math.u-psud.fr>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Sep 2002 00:35:29.0825 (UTC) FILETIME=[74AEC110:01C25F74]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Duncan Sands wrote:
> 
> I noticed a performance degradation in recent kernels:
> fsync takes around 50 times longer in kernels 2.5.28 to
> 2.5.34 when the system is under heavy load, as compared
> to kernels <= 2.5.27.  I noticed this because it makes kmail
> unusable.  2.5.34 is the most recent kernel I tested.
> 

Please try replacing the yield() in fs/jbd/transaction.c
with

	set_current_state(TASK_RUNNING);
	schedule();
