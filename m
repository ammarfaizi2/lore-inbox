Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316459AbSEOTBO>; Wed, 15 May 2002 15:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316466AbSEOTBN>; Wed, 15 May 2002 15:01:13 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57607 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S316459AbSEOTBN>; Wed, 15 May 2002 15:01:13 -0400
Date: Wed, 15 May 2002 16:00:56 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <20020515184646.GH27957@holomorphy.com>
Message-ID: <Pine.LNX.4.44L.0205151558180.32261-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2002, William Lee Irwin III wrote:

> $ vmstat 1
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
> 17  0  0      0 182880  32364  55180   0   0     2    77   29   229  84   6  10
> 16  0  0      0 175224  32408  57524   0   0     0     0  104   961  95   5   0
>
> All good there. OTOH:
>
> $ top
> fscanf failed on /proc/stat for cpu 1

Doh, take a look at top.c around line 1460:

              for(i = 0; i < nr_cpu; i++) {
                if(fscanf(file, "cpu%*d %d %d %d %d\n",
                          &u_ticks, &n_ticks, &s_ticks, &i_ticks) != 4) {
                  fprintf(stderr, "fscanf failed on /proc/stat for cpu %d\n", i);

It would have been ok (like vmstat) if it didn't expect the \n
after the fourth number ;/

Oh well, time for another procps patch ;)

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

