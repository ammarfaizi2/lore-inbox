Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267029AbSLXBii>; Mon, 23 Dec 2002 20:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267030AbSLXBih>; Mon, 23 Dec 2002 20:38:37 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:26761 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S267029AbSLXBig>;
	Mon, 23 Dec 2002 20:38:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] scheduler tunables with contest - exit_weight
Date: Tue, 24 Dec 2002 12:46:40 +1100
User-Agent: KMail/1.4.3
References: <200212220818.22906.conman@kolivas.net> <200212230148.16806.m.c.p@wolk-project.de>
In-Reply-To: <200212230148.16806.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212241246.44601.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Mon, 23 Dec 2002 11:49 am, Marc-Christian Petersen wrote:
> On Saturday 21 December 2002 22:18, Con Kolivas wrote:
>
> Hey Con,
>
> > osdl hardware, contest results, 2.5.52-mm2 with scheduler tunable - exit
> > weight (ew1= exit weight ==1 and so on)
>
> Can you please try another thing?
>
> kernel/sched.c
>
>         /*
>          * If the child was a (relative-) CPU hog then decrease
>          * the sleep_avg of the parent as well.
>          */
>         if (p->sleep_avg < p->parent->sleep_avg)
>                 p->parent->sleep_avg = (p->parent->sleep_avg * exit_weight
> + p->sleep_avg) / (exit_weight + 1);
>
> Remove these please and run again.

Sure why not

noload:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          39.2    181     0       0       1.08
2552mm2noew [5]         39.6    180     0       0       1.09

cacherun:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          36.5    194     0       0       1.01
2552mm2noew [5]         36.5    194     0       0       1.01

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          46.5    152     8       41      1.28
2552mm2noew [5]         49.1    143     10      50      1.36

ctar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          52.8    154     1       10      1.46
2552mm2noew [5]         57.7    160     1       10      1.59

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          76.1    124     1       8       2.10
2552mm2noew [5]         70.1    128     1       8       1.94

io_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          74.5    112     11      20      2.06
2552mm2noew [5]         67.3    117     8       17      1.86

io_other:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          59.9    134     6       18      1.65
2552mm2noew [5]         66.2    131     9       21      1.83

read_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          50.5    147     5       6       1.39
2552mm2noew [5]         50.2    149     5       6       1.39

list_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          43.7    167     0       9       1.21
2552mm2noew [5]         43.5    166     0       9       1.20

mem_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.52-mm2 [7]          66.0    141     39      3       1.82
2552mm2noew [5]         64.7    136     38      3       1.79

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+B7yAF6dfvkL3i1gRAhjaAJ4r0rEcvy95o28bw7WoSBoe7ZfmAgCgpHJS
HFJaBj8sBtA1MyzK/7qptQg=
=N3fU
-----END PGP SIGNATURE-----
