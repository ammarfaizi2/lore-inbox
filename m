Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265243AbTBOVcv>; Sat, 15 Feb 2003 16:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265250AbTBOVcv>; Sat, 15 Feb 2003 16:32:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:59053 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265243AbTBOVcu>;
	Sat, 15 Feb 2003 16:32:50 -0500
Date: Sat, 15 Feb 2003 13:43:20 -0800
From: Andrew Morton <akpm@digeo.com>
To: Arador <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5: system time goes up to 100%
Message-Id: <20030215134320.39bafc6e.akpm@digeo.com>
In-Reply-To: <20030215222229.10b56e5f.diegocg@teleline.es>
References: <20030215222229.10b56e5f.diegocg@teleline.es>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Feb 2003 21:42:40.0061 (UTC) FILETIME=[29C8D6D0:01C2D53B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arador <diegocg@teleline.es> wrote:
>
> Hi, i've the following case (more info provided below):
> 
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  0  1  44268 124776  10380  64736    5    8    93    37  600   281   11  2 85  3
>  1  0  44268 124160  10584  64736    0    0   196   196 1750  1518  1 41 49  9
> ...
> 8209527 total                                      4,5041
> 8035501 default_idle                             100443,7625
>  39060 ext3_find_entry                           35,9007
>  19200 serial_in                                171,4286
>  18957 check_poison_obj                         131,6458

That all looks OK.  Your machine is waiting on disk I/O.

We changed the representation of the cpu states in /proc a while ago and I
have a vague feeling that this has caused some versions of the userspace
tools to confuse disk-wait with system time.

Try grabbing the latest vmstat from procps.sourceforge.net

