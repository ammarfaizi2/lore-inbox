Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267783AbTBGKyW>; Fri, 7 Feb 2003 05:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267785AbTBGKyW>; Fri, 7 Feb 2003 05:54:22 -0500
Received: from packet.digeo.com ([12.110.80.53]:35057 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267783AbTBGKyV>;
	Fri, 7 Feb 2003 05:54:21 -0500
Date: Fri, 7 Feb 2003 03:03:50 -0800
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.5.59-mm9
Message-Id: <20030207030350.728b4618.akpm@digeo.com>
In-Reply-To: <20030207013921.0594df03.akpm@digeo.com>
References: <20030207013921.0594df03.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Feb 2003 11:03:50.0778 (UTC) FILETIME=[987265A0:01C2CE98]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.59/2.5.59-mm9/

I've taken this down.

Ingo, there's something bad in the signal changes in Linus's current tree.

mozilla won't display, and is unkillable:

mnm:/home/akpm> ps aux|grep moz               
akpm      1462  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1463  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1469  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1470  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1471  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      9024  0.0  0.0  3260  556 pts/19   S    02:32   0:00 grep moz
mnm:/home/akpm> kill -9 1462 1463 1469 1470 1471
mnm:/home/akpm> ps aux|grep moz                 
akpm      1462  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1463  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1469  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1470  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      1471  0.0  2.5 44568 23244 ?       S    02:26   0:00 /usr/lib/mozilla-1.3a/mozilla-bin
akpm      9028  0.0  0.0  3260  556 pts/19   S    02:33   0:00 grep moz
mnm:/home/akpm> ps axo pid,comm,wchan|grep moz
 1462 mozilla-bin      schedule_timeout
 1463 mozilla-bin      rt_sigsuspend
 1469 mozilla-bin      rt_sigsuspend
 1470 mozilla-bin      rt_sigsuspend
 1471 mozilla-bin      rt_sigsuspend


That's just from bringing up X and starting mozilla 1.13a.  Happens every time.


