Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266969AbSLDJVU>; Wed, 4 Dec 2002 04:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266976AbSLDJVU>; Wed, 4 Dec 2002 04:21:20 -0500
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:57759 "EHLO
	mail.kolivas.net") by vger.kernel.org with ESMTP id <S266969AbSLDJVS>;
	Wed, 4 Dec 2002 04:21:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: Giuliano Pochini <pochini@shiny.it>
Subject: Re: [BENCHMARK] 2.5.40-mm1 with contest
Date: Wed, 4 Dec 2002 20:28:44 +1100
User-Agent: KMail/1.4.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <XFMail.20021204094315.pochini@shiny.it>
In-Reply-To: <XFMail.20021204094315.pochini@shiny.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212042028.48710.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 4 Dec 2002 07:43 pm, Giuliano Pochini wrote:
> On 03-Dec-2002 Con Kolivas wrote:
> > UP results
> >
> > process_load:
> > Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> > 2.4.20 [5]              108.1   58      84      40      1.62
> > 2.5.50-mm1 [5]          86.6    78      18      20      1.30
>
> Hm, load task gets half cpu time, but it goes 5 times slower
> in 2.5.x. Why ? You can see a similar behaviour in other
> tests too.

You have to dig deeper to understand why. The time taken to compile the kernel 
takes a fixed amount of cpu time. In the presence of a load, it takes longer 
in wall clock time, but still takes about the same amount of cpu time. The 
amount of extra wall clock time will basically be used for the load, 
scheduling, io etc. Now the absolute extra wall clock time it takes to 
compile the kernel in this load is time it can also be doing the load. 
Therefore, if I spend 20 seconds longer to compile the kernel while the load 
is running, the load must also get 20 seconds where it can be doing it's 
work. Assuming it does 1 load per second, it will do 20 loads. If it takes 40 
seconds longer to compile the kernel, the load gets 40 seconds longer; hence 
it can do 40 loads. 

Look at the example above and you'll see those numbers. It takes 20 seconds 
longer in 2.5.50-mm1 compared to noload, and load gets to do 20 workloads. 
2.4.20 takes 40 seconds longer and gets to do 40 workloads. If you take into 
account the work done / time they are doing workloads at about the same rate. 
Now if one had taken 20 seconds longer than the other and done only the same 
amount of work it would be showing serious inefficiencies over and above the 
fair scheduling issues which contest is really trying to measure.

Hmm. Not sure if I made that clear enough, but hopefully I got my point 
across.

Con
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE97crOF6dfvkL3i1gRAhdzAKCX8vlHqLQUm+MnzsGAjzP7UPJB4ACbB4um
XyNURkBWQwIC7xAvgkTwmpY=
=4mwU
-----END PGP SIGNATURE-----
