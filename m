Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136395AbREGRCp>; Mon, 7 May 2001 13:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136370AbREGRCf>; Mon, 7 May 2001 13:02:35 -0400
Received: from m327-mp1-cvx1c.col.ntl.com ([213.104.77.71]:4992 "EHLO
	[213.104.77.71]") by vger.kernel.org with ESMTP id <S136318AbREGRCS>;
	Mon, 7 May 2001 13:02:18 -0400
To: Manfred Spraul <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zero^H^H^H^Hsingle copy pipe
In-Reply-To: <3AF3FA84.AA76CF89@colorfullife.com>
	<m2wv7vk2xi.fsf@boreas.yi.org.> <3AF45FAB.595951F8@colorfullife.com>
	<m2k83vjyrz.fsf@boreas.yi.org.> <3AF473F8.F01EF82A@colorfullife.com>
From: John Fremlin <chief@bandits.org>
Date: 07 May 2001 18:01:35 +0100
In-Reply-To: <3AF473F8.F01EF82A@colorfullife.com>
Message-ID: <m2n18p9jps.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Stuff about NetBSD pipes snipped]

I'm testing out Manfred's patch for zero copy pipes, and haven't
crashed it yet.

My hardware is a AMD K6-2 (stepping 1) on an ALi M1541 with 320 Mb -
one quite slow 64 Mb stick and one fast 256 Mb stick.

The lmbench bw_pipe showed a performance improvement of about 30% from
45 (+- 2) Mb/s to 59.5 (+-0.6) Mb/s.

The lmbench (2beta3) lat_pipe showed a performance improvement of
about 20% from a latency of about 27 (+- 1) usec to about 22.4 (+-.6)
usec. There was one outlyer amoung the 10 non zc pipe runs - 25
usec. For zc, the first run was always about 25 usec and after that
very stable around 22 usec.

FWIW the system time from "time" when running (bw_pipe;lat_pipe) 10
times in a row *increased* by 50%, from sys 0m18.740s to sys
0m31.660s. 

Script:
for i in 1 2 3 4 5 6 7 8 9 10; do ./bw_pipe; ./lat_pipe; done

Non zero copy:

real    0m49.602s
user    0m10.170s
sys     0m18.740s

Zero copy run 1:

real    0m47.901s
user    0m10.390s
sys     0m31.660s

Zero copy run 2:

real    0m47.492s
user    0m10.600s
sys     0m31.340s

-- 

	http://ape.n3.net
