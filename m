Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278214AbRKKKtZ>; Sun, 11 Nov 2001 05:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278297AbRKKKtP>; Sun, 11 Nov 2001 05:49:15 -0500
Received: from h24-78-175-24.nv.shawcable.net ([24.78.175.24]:38017 "EHLO
	oof.localnet") by vger.kernel.org with ESMTP id <S278214AbRKKKs6>;
	Sun, 11 Nov 2001 05:48:58 -0500
Date: Sun, 11 Nov 2001 02:48:55 -0800
From: Simon Kirby <sim@netnation.com>
To: linux-kernel@vger.kernel.org
Subject: Writing over NFS causes lots of paging
Message-ID: <20011111024855.A5893@netnation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like when writing large amounts of data to NFS where the remote
end is slower than the local end the local end appears to start swapping
out a lot I'm guessing this is because it can read much faster than it
can write.

Also, I see NFS timeouts and thus "I/O error" messages fom cp when it is
mounted with the "soft" option, even with high timeouts.  "hard" works
fine, but I didn't want to use it for this mount.

For example:

procs                   memory   swap         io     system      cpu
r b w   swpd  free buff  cache si   so   bi   bo   in    cs us sy id
0 0 0  70316  4128  608 141744  0    0 4172    0 3065  4214  1 12 87
0 0 0  70316  3156  620 142704  0   92 3896   92 2904  4028  1 11 88
0 1 0  70316  4208  672 141604  0   40 2912   40 3248  4715  2 12 86
1 0 0  70316  3228  724 142528  0  296 3284  296 2904  4682  5 17 79
0 1 0  70700  4048  720 141948  0  124 3744  124 2987  4109  1 14 85
1 1 0  70700  3752  724 142376  0  116 4136  116 2927  3985  1 16 83
1 0 0  70956  3816  712 142384  0  180 3964  180 2724  3801  1 15 84
0 0 0  70956  3968  720 142308  0    0 3908    0 3045  4277  2 13 84
0 1 0  71724  3336  724 142984  0  580 3796  580 2837  4985  9 21 69
0 0 0  71724  3924  736 144116  0  588 3776  588 2860  3950  1 14 85
0 1 0  72236  3120  752 146132  0  556 3380  556 2731  3983  1  9 89
0 0 0  73260  3212  752 146140  0 2496 3468 2496 2516  3637  1 14 85
0 0 0  73900  3476  744 145868  0  640 3900  640 2776  3888  0 13 87
0 0 0  74156  3192  736 146212  0  540 4150  540 2916  4010  1 15 83

The copy is still running and almost everything is swapped out now
(140 MB).  When the copy started, there was about 30 MB of swap.

NFS client (reading from disk and writing through NFS): 2.4.15pre1
NFS server (writing to disk from NFS): 2.4.15pre2
NFSv3 and knfsd used.

Is there something different with the VM here?  Should I try 2.4.15pre2
on the NFS client?

Simon-

[  Stormix Technologies Inc.  ][  NetNation Communications Inc. ]
[       sim@stormix.com       ][       sim@netnation.com        ]
[ Opinions expressed are not necessarily those of my employers. ]
