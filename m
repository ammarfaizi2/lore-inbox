Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270545AbRHHSOg>; Wed, 8 Aug 2001 14:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270546AbRHHSOZ>; Wed, 8 Aug 2001 14:14:25 -0400
Received: from [63.209.4.196] ([63.209.4.196]:41481 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S270545AbRHHSOQ>; Wed, 8 Aug 2001 14:14:16 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: I/O very slow under 2.4 (device reading)
Date: Wed, 8 Aug 2001 18:12:40 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9krveo$82c$1@penguin.transmeta.com>
In-Reply-To: <20010808193158.A4055@cerebro.laendle>
X-Trace: palladium.transmeta.com 997294425 26750 127.0.0.1 (8 Aug 2001 18:13:45 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 8 Aug 2001 18:13:45 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010808193158.A4055@cerebro.laendle>,
 <pcg@goof.com ( Marc) (A.) (Lehmann )> wrote:
>It might be vm related, it might be not, but I get very funny effects when
>running:
>
>   buffer -S1m -s128k -m32m </dev/hde >/dev/null
>
>(buffer is just a fast read/write buffer reading stdin to stdout, i use it
>to check wether all sectors of a disk are readable, it's similar to dd,
>which creates the same effects).

I bet it's the same thing that made writes slow - the buffer allocator
and the VM disagree about how/when to allocate memory. It's fixed by the patch
that's floating around in the "VM suckage" thread along with the tweak
to fix "zone_free_plenty()".

I'll make a real pre-patch (2.4.8-pre7) with the full changeset, can you
test that out? I did an equivalent "dd" that you see problems with, and
on my current kernel as long as there isn't other IO activity it stays
at a nice stable 21MB/s which is all my disk can deliver. 

[ Damn, maybe I should get one of those nice big 7200 rpm IBM drives ]

		Linus
