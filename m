Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275120AbRIYRb7>; Tue, 25 Sep 2001 13:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274579AbRIYRby>; Tue, 25 Sep 2001 13:31:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27405 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S274554AbRIYRbn>; Tue, 25 Sep 2001 13:31:43 -0400
Date: Tue, 25 Sep 2001 14:31:48 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Pau Aliagas <linux4u@wanadoo.es>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.9-ac15 painfully sluggish
In-Reply-To: <Pine.LNX.4.33.0109251855450.1309-100000@pau.intranet.ct>
Message-ID: <Pine.LNX.4.33L.0109251426310.26091-100000@duckman.distro.conectiva>
X-supervisor: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, Pau Aliagas wrote:
> On Tue, 25 Sep 2001, Rik van Riel wrote:
>
> > Could you send me one screen's worth of output from top
> > and 5 lines from 'vmstat -a 5' ?

> [pau@pau pau]$ vmstat -n 5
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  2  6  1   2392   3040    476   9644   5   7   585    17  170   479  85   6   9
>  2 12  0   2520   2800    408   9028  25  27  1425    35  208   184  92   6   2
>  2  4  0   2596   2812    408   9500  15  22  1174    24  204   304  79   6  16

Wow, these are a LOT of reads and a very small cache.

I guess the old page_launder() might be misbehaving in
this case, I've just finished the patch for a new one
(which seems to work nicely in the limited tests I've
thrown at it).

>   6:58pm  up 14 min,  5 users,  load average: 7,68, 6,21, 3,22
> 112 processes: 110 sleeping, 2 running, 0 zombie, 0 stopped
> CPU states:  2,7% user,  5,2% system, 92,0% nice,  0,0% idle
> Mem:   127072K av,  124272K used,    2800K free,     564K shrd,     440K buff
> Swap:  401536K av,    2132K used,  399404K free                    9368K cached

Here things get "interesting" ...

total memory:                               127 MB
The memory taken by all your processes:      55 MB
buffer + cache:                              10 MB
-----------------------------------------------------
missing:                                     62 MB

It would be interesting to get a listing of /proc/slabinfo,
in particular those lines which have a large number in the
4th or 5th column...


regards,

Rik
--
IA64: a worthy successor to the i860.

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

