Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264575AbSIQVkT>; Tue, 17 Sep 2002 17:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264591AbSIQVkT>; Tue, 17 Sep 2002 17:40:19 -0400
Received: from packet.digeo.com ([12.110.80.53]:8919 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264575AbSIQVkS>;
	Tue, 17 Sep 2002 17:40:18 -0400
Message-ID: <3D87A264.8D5F3AD2@digeo.com>
Date: Tue, 17 Sep 2002 14:45:08 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: manfred@colorfullife.com, "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Info: NAPI performance at "low" loads
References: <3D879F59.6BDF9443@digeo.com> <20020917.142635.114214508.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Sep 2002 21:45:08.0045 (UTC) FILETIME=[7D9D27D0:01C25E93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Andrew Morton <akpm@digeo.com>
>    Date: Tue, 17 Sep 2002 14:32:09 -0700
> 
>    There is a similar background loadtester at
>    http://www.zip.com.au/~akpm/linux/#zc .
> 
>    It's fairly fancy - I wrote it for measuring networking
>    efficiency.  It doesn't seem to have any PCisms....
> 
> Thanks I'll check it out, but meanwhile I hacked up sparc
> specific assembler for manfred's code :-)
> 
>    (I measured similar regression using an ancient NAPIfied
>    3c59x a long time ago).
> 
> Well, it is due to the same problems manfred saw initially,
> namely just a crappy or buggy NAPI driver implementation. :-)

It was due to additional inl()'s and outl()'s in the driver fastpath.

Testcase was netperf Tx and Rx.  Just TCP over 100bT. AFAIK, this overhead
is intrinsic to NAPI.  Not to say that its costs outweigh its benefits,
but it's just there.

If someone wants to point me at all the bits and pieces to get a
NAPIfied 3c59x working on 2.5.current I'll retest, and generate
some instruction-level oprofiles.
