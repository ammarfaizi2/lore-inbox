Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265175AbSJPQbr>; Wed, 16 Oct 2002 12:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbSJPQbr>; Wed, 16 Oct 2002 12:31:47 -0400
Received: from packet.digeo.com ([12.110.80.53]:50048 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265175AbSJPQbn>;
	Wed, 16 Oct 2002 12:31:43 -0400
Message-ID: <3DAD95CD.DB7F8C26@digeo.com>
Date: Wed, 16 Oct 2002 09:37:33 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Siva Koti Reddy <siva.kotireddy@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BENCH MARK] 'tiobench' results comparision for 2.5.43 kernel and 
 2.4.19
References: <04fd01c2750d$c895a470$690b720a@M3104487>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Oct 2002 16:37:34.0184 (UTC) FILETIME=[543C2E80:01C27532]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siva Koti Reddy wrote:
> 
> Hai...
>     Here is the benchmark results of tiobench for 2.5.43 kernel and 2.4.19
> kernel. There is a  drastic performance degradation in Read operations of
> 2.5.43 kernel as compared to 2.4.19 kernel though there is a little
> improvement in write operations. Any cooments..?
> 

The tiobench threaded read phase is very sensitive to the
interworking between readahead and the disk scheduler.  2.4
gets this right, and 2.5 does not.

2.5 seeks between the files with a granularity equal to the
readahead window size.  2.4 seeks betwen the files at a
granularity equal to the elevator request expiry count.

So yup, it's known.  Haven't investigated it yet.
