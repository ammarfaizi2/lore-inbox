Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130537AbRBWCt1>; Thu, 22 Feb 2001 21:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130160AbRBWCtT>; Thu, 22 Feb 2001 21:49:19 -0500
Received: from hera.cwi.nl ([192.16.191.8]:32658 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S130856AbRBWCtL>;
	Thu, 22 Feb 2001 21:49:11 -0500
Date: Fri, 23 Feb 2001 03:49:05 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200102230249.DAA252851.aeb@vlet.cwi.nl>
To: linux-kernel@vger.kernel.org, phillips@innominate.de,
        torvalds@transmeta.com
Subject: Re: [rfc] Near-constant time directory index for Ext2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    Just looking at R5 I knew it wasn't going to do well in this application
    because it's similar to a number of hash functions I tried with the same
    idea in mind: to place similar names together in the same leaf block. 
    That turned out to be not very important compared to achieving a
    relatively high fullness of leaf blocks.  The problem with R5 when used
    with my htree is, it doesn't give very uniform dispersal.

    The bottom line: dx_hack_hash is still the reigning champion.

Now that you provide source for r5 and dx_hack_hash, let me feed my
collections to them.
r5: catastrophic
dx_hack_hash: not bad, but the linear hash is better.

E.g.:
Actual file names:

Linear hash, m=11, sz=2048, min 262, max 283,  av 272.17, stddev 12.25
dx_hack_hash:      sz=2048, min 220, max 330,  av 272.17, stddev 280.43
r5:                sz=2048, min 205, max 382,  av 272.17, stddev 805.18

Linear hash, m=11, sz=65536, min 0, max 24, av 8.51, stddev 8.70
dx_hack_hash:      sz=65536, min 0, max 23, av 8.51, stddev 8.51
r5:                sz=65536, min 0, max 26, av 8.51, stddev 8.89

Generated consecutive names:

Linear hash, m=11, sz=2048, min 262, max 283,  av 272.17, stddev 12.25
dx_hack_hash:      sz=2048, min 191, max 346,  av 272.17, stddev 636.11
r5:                sz=2048, min 0,   max 3587, av 272.17, stddev 755222.91

Linear hash, m=11, sz=65536, min 2, max  14, av 8.51, stddev 2.79
dx_hack_hash:      sz=65536, min 0, max  26, av 8.51, stddev 12.24
r5:                sz=65536, min 0, max 120, av 8.51, stddev 738.08

Andries
