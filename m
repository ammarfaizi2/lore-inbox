Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261528AbSJYSiI>; Fri, 25 Oct 2002 14:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261535AbSJYSiH>; Fri, 25 Oct 2002 14:38:07 -0400
Received: from packet.digeo.com ([12.110.80.53]:20146 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261528AbSJYSiH>;
	Fri, 25 Oct 2002 14:38:07 -0400
Message-ID: <3DB990FE.A1B8956@digeo.com>
Date: Fri, 25 Oct 2002 11:44:14 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chrisl@vmware.com
CC: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
       chrisl@gnuchina.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: writepage return value check in vmscan.c
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com> <20021024175718.GA1398@vmware.com> <20021024183327.GS3354@dualathlon.random> <20021024191531.GD1398@vmware.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Oct 2002 18:44:14.0823 (UTC) FILETIME=[84496770:01C27C56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chrisl@vmware.com wrote:
> 
> bigmm -i 3 -t 2 -c 1024

That's a nice little box killer you have there.

With mem=4G, running bigmm -i 5 -t 2 -c 1024:

2.4.19: Ran for a few minutes, got slower and slower and
eventually stopped.  kupdate had taken 30 seconds CPU and
all CPUs were spinning in shrink_cache().  Had to reset.

2.4.20-pre8-ac1: Ran for a minute, froze up for a couple of
minutes then recovered and remained comfortable.

2.5.44-mm5: had a few 0.5-second stalls in vmstat output, no
other problems.

It's probably the list search failure, but I can't say for sure
at this time.
