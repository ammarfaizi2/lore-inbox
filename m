Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278086AbRJZJqB>; Fri, 26 Oct 2001 05:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278087AbRJZJpv>; Fri, 26 Oct 2001 05:45:51 -0400
Received: from inje.iskon.hr ([213.191.128.16]:23447 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S278086AbRJZJpc>;
	Fri, 26 Oct 2001 05:45:32 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: xmm2 - monitor Linux MM active/inactive lists graphically
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: 26 Oct 2001 11:45:55 +0200
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com> (Linus Torvalds's message of "Thu, 25 Oct 2001 09:31:12 -0700 (PDT)")
Message-ID: <dnd73apwdo.fsf@magla.zg.iskon.hr>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 25 Oct 2001, Zlatko Calusic wrote:
> >
> > Yes, I definitely have DMA turned ON. All parameters are OK. :)
> 
> I suspect it may just be that "queue_nr_requests"/"batch_count" is
> different in -ac: what happens if you tweak them to the same values?
> 
> (See drivers/block/ll_rw_block.c)
> 
> I think -ac made the queues a bit deeper the regular kernel does 128
> requests and a batch-count of 16, I _think_ -ac does something like "2
> requests per megabyte" and batch_count=32, so if you have 512MB you should
> try with
> 
> 	queue_nr_requests = 1024
> 	batch_count = 32
> 
> Does that help?
> 

Unfortunately not. It makes a machine quite unresponsive while it's
writing to disk, and vmstat 1 discovers strange "spiky"
behaviour. Average throughput is ~ 8MB/s (disk is capable of ~ 13MB/s)

   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 2  0  0      0   3840    528 441900   0   0     0 34816  188   594   2  34  64
 0  1  0      0   3332    536 442384   0   0     4 10624  187   519   2   8  90
 0  1  0      0   3324    536 442384   0   0     0     0  182   499   0   0 100
 2  1  0      0   3300    536 442384   0   0     0     0  198   486   0   1  99
 1  1  0      0   3304    536 442384   0   0     0     0  186   513   0   0 100
 0  1  1      0   3304    536 442384   0   0     0     0  193   473   0   1  99
 0  1  1      0   3304    536 442384   0   0     0     0  191   508   1   1  98
 0  1  0      0   3884    536 441840   0   0     4 44672  189   590   4  40  56
 0  1  0      0   3860    536 441840   0   0     0     0  186   526   0   1  99
 0  1  0      0   3852    536 441840   0   0     0     0  191   500   0   0 100
 0  1  0      0   3844    536 441840   0   0     0     0  193   482   1   0  99
 0  1  0      0   3844    536 441840   0   0     0     0  187   511   0   1  99
 0  2  1      0   3832    540 441844   0   0     4     0  305  1004   3   2  95
 0  3  1      0   3824    544 441844   0   0     4     0  410  1340   2   2  96
 0  3  0      0   3764    552 441916   0   0    12 47360  346   915   6  41  53
 0  3  0      0   3764    552 441916   0   0     0     0  373   887   0   0 100
 0  3  0      0   3764    552 441916   0   0     0     0  278   692   1   2  97
 1  3  0      0   3764    552 441916   0   0     0     0  221   579   0   3  97
 0  3  0      0   3764    552 441916   0   0     0     0  286   704   0   2  98

I'll now test "batch_count = queue_nr_requests / 3", which I found in
2.4.14-pre2, but with queue_nr_request still left at 1024. And report
results after that.
-- 
Zlatko
