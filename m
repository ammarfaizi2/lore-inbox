Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278170AbRJZKIb>; Fri, 26 Oct 2001 06:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278274AbRJZKIW>; Fri, 26 Oct 2001 06:08:22 -0400
Received: from inje.iskon.hr ([213.191.128.16]:38307 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S278171AbRJZKIQ>;
	Fri, 26 Oct 2001 06:08:16 -0400
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
Date: 26 Oct 2001 12:08:46 +0200
In-Reply-To: <Pine.LNX.4.31.0110250920270.2184-100000@cesium.transmeta.com> (Linus Torvalds's message of "Thu, 25 Oct 2001 09:31:12 -0700 (PDT)")
Message-ID: <dnr8rqu30x.fsf@magla.zg.iskon.hr>
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

Next test:

block: 1024 slots per queue, batch=341

Wrote 600.00 MB in 71 seconds -> 8.39 MB/s (7.5 %CPU)

Still very spiky, and during the write disk is uncapable of doing any
reads. IOW, no serious application can be started before writing has
finished. Shouldn't we favour reads over writes? Or is it just that
the elevator is not doing its job right, so reads suffer?


   procs                      memory    swap          io     system         cpu
 r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
 0  1  1      0   3600    424 453416   0   0     0     0  190   510   2   1  97
 0  1  1      0   3596    424 453416   0   0     0 40468  189   508   2   2  96
 0  1  1      0   3592    424 453416   0   0     0     0  189   541   1   0  99
 0  1  1      0   3592    424 453416   0   0     0     0  190   513   1   0  99
 1  1  1      0   3592    424 453416   0   0     0     0  192   511   0   1  99
 0  1  1      0   3596    424 453416   0   0     0     0  188   528   0   0 100
 0  1  1      0   3592    424 453416   0   0     0     0  188   510   1   0  99
 0  1  1      0   3592    424 453416   0   0     0 41444  195   507   0   2  98
 0  1  1      0   3592    424 453416   0   0     0     0  190   514   1   1  98
 1  1  1      0   3588    424 453416   0   0     0     0  192   554   0   2  98
 0  1  1      0   3584    424 453416   0   0     0     0  191   506   0   1  99
 0  1  1      0   3584    424 453416   0   0     0     0  186   514   0   0 100
 0  1  1      0   3584    424 453416   0   0     0     0  186   515   0   0 100
 1  1  1      0   3576    424 453416   0   0     0     0  434  1493   3   2  95
 1  1  1      0   3564    424 453416   0   0     0 40560  301   936   3   1  96
 0  1  1      0   3564    424 453416   0   0     0     0  338  1050   1   2  97
 0  1  1      0   3560    424 453416   0   0     0     0  286   893   1   2  97

-- 
Zlatko
