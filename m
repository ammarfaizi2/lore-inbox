Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278137AbRJRUyT>; Thu, 18 Oct 2001 16:54:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278143AbRJRUyJ>; Thu, 18 Oct 2001 16:54:09 -0400
Received: from inje.iskon.hr ([213.191.128.16]:15035 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S278139AbRJRUx5>;
	Thu, 18 Oct 2001 16:53:57 -0400
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: Write throughput in >= 2.4.10
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 18 Oct 2001 21:13:13 +0200
Message-ID: <87669c92ye.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like recent kernels have some serious trouble during simple
writing of files. Throughput is cut to half.

2.4.12-ac3 (Riel VM):

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  4  1      0   2548   7652 369104   0   0     0 21992  291   592   0  23  77
 0  4  1      0   2556   7652 369104   0   0     0 22500  280   175   0   3  97
 0  4  1      0   3064   7652 368588   0   0     8 19644  278   202   0   4  96
...

2.4.13-pre4 (Andrea/Linus VM):

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 1  1  1  30312   2884   2304 384076   0  28     0  7784  199   241   0  12  88
 0  1  1  30316   2068   2256 385772   0 132     4  7900  186   188   1   8  91
 0  1  0  30316   3960   2232 384140   0   0     8  6744  179   204   0   4  96
...

'bo' column is the one to check out... I copied just 3 lines, but they
are all alike. 2.4.13-pre ends up with 11MB/sec, where -ac kernels are
over 20MB/sec (during sequential writing of big files - ext2 of course).

Also it looks like pre4 swaps when it is not necessary to do so. With
380MB in page cache I don't expect any swap traffic at all.
-- 
Zlatko
