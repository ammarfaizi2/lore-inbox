Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSKSJdg>; Tue, 19 Nov 2002 04:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbSKSJdg>; Tue, 19 Nov 2002 04:33:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:38887 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264686AbSKSJdf>;
	Tue, 19 Nov 2002 04:33:35 -0500
Message-ID: <3DDA070F.CF2047BF@digeo.com>
Date: Tue, 19 Nov 2002 01:40:31 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vasya vasyaev <vasya197@yahoo.com>
CC: "Nakajima, Jun" <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Machine's high load when HIGHMEM is enabled
References: <3DC94885.AD5B8A3B@digeo.com> <20021119092912.39541.qmail@web20510.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Nov 2002 09:40:32.0384 (UTC) FILETIME=[B4200000:01C28FAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vasya vasyaev wrote:
> 
> Hi again,
> 
> Let me try to explain what is this all about...
> 
> Box has 1 GB of RAM, it's running oracle database.
> After some disk activity disk cache has 400 Mb, so 600
> Mb is free

And the other 400 megabytes will be freed up on demand.

> Oracle is tuned for using of 800 Mb of RAM for SGA (as
> shared memory segment), so Oracle needs 800 Mb of RAM
> to be free before it's start, right ?

No...  If that were so, you'd never be able to start any
applications.

> So when oracle starts it can't allocate this 800 Mb
> for SGA and fails to start...

Well, maybe Oracle is failing to start.  But maybe that's
not for the reasons you are assuming.

> Where is a problem - in kernel which can't reduce disk
> cache to allow allocating of shared memory segment or
> in oracle ?

If Oracle requests 800 megabytes from the kernel, it will get it.
It won't be able to mlock it (I'm guessing here).
 
> BTW, free doesn't show that shared memory is in use
> when oracle is started and requested shared memory
> segment is allocated (and ipcs shows it).

Yup, the "shared" accounting is always zero.  Maybe we should
fix that, or remove it.
 
> We need to control disk cache to reduce it as much as
> possible because it's not needed for oracle, much
> better is to allow oracle to control the RAM
> for it's use.
> 
> As to compare, on solaris we mount ufs with
> "forcedirectio" mount option, which tells not to use
> disk cache.

Please ensure that the failure is not some Oracle-specific setup
thing, and then provide specific details on the problem which you
are observing.  The assumptions which you are making may not be
correct.

Thanks.
