Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265477AbSL1GIi>; Sat, 28 Dec 2002 01:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSL1GIi>; Sat, 28 Dec 2002 01:08:38 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:25004 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S265477AbSL1GIh>;
	Sat, 28 Dec 2002 01:08:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] vm swappiness with contest
Date: Sat, 28 Dec 2002 17:16:47 +1100
User-Agent: KMail/1.4.3
Cc: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       Andrew Morton <akpm@digeo.com>
References: <200212271646.01487.conman@kolivas.net> <200212272100.44345.conman@kolivas.net>
In-Reply-To: <200212272100.44345.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212281716.50535.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Fri, 27 Dec 2002 09:00 pm, Con Kolivas wrote:
> On Fri, 27 Dec 2002 04:46 pm, Con Kolivas wrote:
> > Here is a family of contest benchmarks using the osdl hardware in
> > uniprocessor mode on 2.5.53-mm1 while varying vm swappiness. s020 is vm
> > swappiness=20 and so on:
>
> SNIP--->
SNIP SNIP -->

akpm was the first to suggest these results looked unusual and suggested 
running them in a single sitting. The thing is, I ran these in a single 
sitting without rebooting over about 12 hours sequentially so I thought I'd 
try a different approach. Look at this first set rearranged in the order I 
tested them:

> dbench_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> s000 [3]                191.6   41      1       43      2.87
> s020 [5]                195.5   40      1       44      2.93
> s040 [5]                197.9   41      1       43      2.96
> s060 [5]                331.4   32      0       23      4.96
> s080 [5]                439.4   24      0       10      6.58
> s100 [5]                883.6   13      1       9       13.24
> s050 [5]                914.6   15      0       6       13.70

It appeared to take longer to run the longer the machine had been running, 
even though all memory is "flushed" and swap is turned on/off before each 
run. So I ran these again with a reboot between each run:

sw000 [5]               185.1   42      1       42      2.77
sw020 [5]               199.9   39      1       44      2.99
sw040 [5]               210.5   38      2       45      3.15
sw050 [5]               199.7   39      2       46      2.99
sw060 [5]               190.3   41      1       45      2.85
sw080 [5]               196.1   40      1       44      2.94
sw100 [5]               198.7   40      1       43      2.98

Well these look rather different shall we say? There's virtually no change 
regardless of the swappiness setting.

Question. Why does the above happen when the machine has been running for a 
while? All the file writes are deleted between each run so the filesystem 
doesnt change that dramatically, but even if it was the change to the 
filesystem, why does a reboot fix it? (ext3 throughout)

Is there something about the filesystem layer or elsewhere in the kernel that 
could decay or fragment over time that only a reboot can fix? This would seem 
to be a bad thing.

Comments?
Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE+DUHPF6dfvkL3i1gRAlEaAJ0fV2c1T1TdkM3gakNQUUx+doptNQCbBoCS
XgPTttdepCq+1m4n66TFexY=
=pvGe
-----END PGP SIGNATURE-----
