Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbUDNMLZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 08:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264065AbUDNMLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 08:11:25 -0400
Received: from [82.138.8.106] ([82.138.8.106]:25336 "EHLO gw.home.net")
	by vger.kernel.org with ESMTP id S264069AbUDNMLU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 08:11:20 -0400
To: <ext2-devel@lists.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, <alex@clusterfs.com>
Subject: Re: [RFC] extents,delayed allocation,mballoc for ext3
References: <m365c3pthi.fsf@bzzz.home.net>
From: Alex Tomas <alex@clusterfs.com>
Organization: ClusterFS Inc.
In-Reply-To: <m365c3pthi.fsf@bzzz.home.net> (alex@clusterfs.com's message of
 "Tue, 13 Apr 2004 23:28:57 +0400")
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
Date: Wed, 14 Apr 2004 16:10:53 +0400
Message-ID: <m3ekqqoj3m.fsf@bzzz.home.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've just benched ext3 vs. ext3+reservation vs. ext3+delalloc vs. xfs.
it was tiobench.

Sequential Writes
                              File  Blk   Num                   Avg     CPU
Identifier                    Size  Size  Thr   Rate  (CPU%)  Latency   Eff
---------------------------- ------ ----- ---  ------ ------ --------- -----
ext3                          1024  4096    4   13.34 14.76%     0.897    90
ext3-dalloc                   1024  4096    4   26.39 19.26%     0.452   137
ext3-reserv                   1024  4096    4   23.77 28.99%     0.529    82
xfs                           1024  4096    4   27.22 20.68%     0.373   132

ext3                          1024  4096    8    9.71 10.82%     2.421    90
ext3-dalloc                   1024  4096    8   25.81 18.64%     0.816   138
ext3-reserv                   1024  4096    8   23.62 29.49%     1.006    80
xfs                           1024  4096    8   27.06 22.49%     0.763   120

ext3                          1024  4096   16    6.60 7.891%     7.222    84
ext3-dalloc                   1024  4096   16   24.99 19.71%     1.783   127
ext3-reserv                   1024  4096   16   23.04 28.15%     1.849    82
xfs                           1024  4096   16   24.84 20.58%     1.300   121

ext3                          1024  4096   32    8.12 9.872%     8.111    82
ext3-dalloc                   1024  4096   32   24.83 20.01%     2.995   124
ext3-reserv                   1024  4096   32   22.72 29.51%     3.282    77
xfs                           1024  4096   32   25.47 21.75%     2.247   117

ext3-dalloc is ext3 + extents + delayed allocation + multiblock allocator
ext3-reserv is ext3 + reservation patches by Mingming Cao

