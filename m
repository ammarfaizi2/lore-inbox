Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbSIWXV3>; Mon, 23 Sep 2002 19:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261486AbSIWXV2>; Mon, 23 Sep 2002 19:21:28 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:17304 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S261485AbSIWXV2>;
	Mon, 23 Sep 2002 19:21:28 -0400
Message-ID: <1032823598.3d8fa32e92e94@kolivas.net>
Date: Tue, 24 Sep 2002 09:26:38 +1000
From: Con Kolivas <conman@kolivas.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@digeo.com>, Ryan Anderson <ryan@michonline.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Oliver Xymoron <oxymoron@waste.org>, Daniel Jacobowitz <drow@false.org>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       Robinson Maureira Castillo <rmaureira@alumno.inacap.cl>,
       gcc@gcc.gnu.org
Subject: [BENCHMARK] Statistical representation of IO load results with contest
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you all who responded with suggestions on how to get useful data out of
the IO load module from contest. These are _new_ results with a
sync,swapoff,swapon before conducting just the IO load. I have digested all your
suggestions and come up with the following:

n=5 for number of samples

Kernel          Mean    CI(95%)
2.5.38          411     344-477
2.5.39-gcc32    371     224-519
2.5.38-mm2      95      84-105


The mean is a simple average of the results, and the CI(95%) are the 95%
confidence intervals the mean lies between those numbers. These numbers seem to
be the most useful for comparison.

Comparing 2.5.38(gcc2.95.3) with 2.5.38(gcc3.2) there is NO significant
difference (p 0.56)

Comparing 2.5.38 with 2.5.38-mm2 there is a significant diffence (p<0.001)

After playing with all these it appears I should do the following to contest:

Add sync,swapoff,swapon before each load
Perform noload and process_load twice to ensure no abnormal results
Perform mem_load 3 times
Perform IO_fullmem 5 times (and rename it just IO_load)
Drop IO_halfmem (adds no more useful information and just adds time).
Do a statistical analysis like the above when posting information.

Comments?

Con

