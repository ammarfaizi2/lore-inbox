Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132697AbRDDOTR>; Wed, 4 Apr 2001 10:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132700AbRDDOTI>; Wed, 4 Apr 2001 10:19:08 -0400
Received: from [212.115.175.146] ([212.115.175.146]:5626 "EHLO
	ftrs1.intranet.FTR.NL") by vger.kernel.org with ESMTP
	id <S132697AbRDDOTB>; Wed, 4 Apr 2001 10:19:01 -0400
Message-ID: <27525795B28BD311B28D00500481B7601F115A@ftrs1.intranet.ftr.nl>
From: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: random PIDs
Date: Wed, 4 Apr 2001 16:17:45 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finished & tested my random PID kernel/fork.c:get_pid() replacement.
This one keeps track of the last N (default is 64) pids who have exited.
These are then not used. So, one cannot have more then 32767 - (64 + 1
(init) + 1 (idle)) = 32761 processes :o)

I know that it was all implemented before, but this patch is very small 
and I couldn't stand the idea the fact that my last announcement was for
a patch which didn't work at all :o)

One can find it at: http://www.vanheusden.com/Linux/kernel_patches.php3
(or: http://www.vanheusden.com/Linux/fp-2.2.19.patch.gz but then you
miss the list of other patches ;-])
Patch is against kernel 2.2.19.

I did not do any performance tests, but the machine I tested it on
(300MHz dec alpha) felt (felt?) as smooth as before :o)


Folkert van Heusden

[ www.vanheusden.com ]

p.s. the patch mentioned above also raises the number of pool-words
from 128 to 2048, adds code to do_exit which tells you if the idle
task is killed (as in 2.4.x), and replaces
net/core/utils.c:net_[s]random() with something which uses
get_random_bytes().
