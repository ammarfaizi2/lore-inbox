Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268073AbUHVTSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268073AbUHVTSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 15:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268076AbUHVTSY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 15:18:24 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:52117 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S268073AbUHVTSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 15:18:09 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.8.1: swap storm of death - CFQ scheduler=culprit
References: <200408221527.10303.karl.vogel@seagha.com>
	<m38yc757pu.fsf@seagha.com>
From: Karl Vogel <karl.vogel@seagha.com>
In-Reply-To: <m38yc757pu.fsf@seagha.com> (karl vogel's message of "Sun, 22
 Aug 2004 20:49:17 +0200")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Date: Sun, 22 Aug 2004 21:18:51 +0200
Message-ID: <m33c2f56ck.fsf_-_@seagha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When using elevator=as I'm unable to trigger the swap of death, so it seems
that the CFQ scheduler is at blame here.

With AS scheduler, the system recovers in +-10 seconds, vmstat output during
that time:

procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0 295632  40372  49400   87  278   324   303 1424   784  7  2 78 13
 0  0      0 295632  40372  49400    0    0     0     0 1210   648  3  1 96  0
 0  0      0 295632  40372  49400    0    0     0     0 1209   652  4  0 96  0
 2  0      0 112784  40372  49400    0    0     0     0 1204   630 23 34 43  0
 1  9 156236    788    264   8128   28 156220  3012 156228 3748  3655 11 31  0 59
 0 15 176656   2196    280   8664    0 20420   556 20436 1108   374  2  5  0 93
 0 17 205320    724    232   7960   28 28664   396 28664 1118   503  7 12  0 81
 2 12 217892   1812    252   8556  248 12584   864 12584 1495   318  2  7  0 91
 4 14 253268   2500    268   8728  188 35392   432 35392 1844   399  3  7  0 90
 0 13 255692   1188    288   9152  960 2424  1408  2424 1173  2215 10  5  0 85
 0  7 266140   2288    312   9276  604 10468   752 10468 1248   644  5  5  0 90
 0  7 190516 340636    348   9860 1400    0  2016     0 1294   817  4  8  0 88
 1  8 190516 339460    384  10844  552    0  1556     4 1241   642  3  1  0 96
 1  3 190516 337084    404  11968 1432    0  2576     4 1292   788  3  1  0 96
 0  6 190516 333892    420  13612 1844    0  3500     0 1343   850  5  2  0 93
 0  1 190516 333700    424  13848  480    0   720     0 1250   654  3  2  0 95
 0  1 190516 334468    424  13848  188    0   188     0 1224   589  3  2  0 95

With CFQ processes got stuck in 'D' and never left that state. See URL's in my
initial post for diagnostics.

