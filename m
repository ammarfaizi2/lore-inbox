Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271788AbTGRKCC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 06:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271786AbTGRKBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 06:01:12 -0400
Received: from pop.gmx.de ([213.165.64.20]:39872 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S271783AbTGRJ7X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 05:59:23 -0400
Message-Id: <5.2.1.1.2.20030718120229.01a8fcf0@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Fri, 18 Jul 2003 12:18:33 +0200
To: Nick Piggin <piggin@cyberone.com.au>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O6int for interactivity
Cc: Davide Libenzi <davidel@xmailserver.org>, Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
In-Reply-To: <3F1794F0.1090803@cyberone.com.au>
References: <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
 <200307170030.25934.kernel@kolivas.org>
 <200307170030.25934.kernel@kolivas.org>
 <5.2.1.1.2.20030718071656.01af84d0@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:34 PM 7/18/2003 +1000, Nick Piggin wrote:

>Mike Galbraith wrote:
>
>>no_load:
>>Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
>>2.5.69               1  153     94.8    0.0     0.0     1.00
>>2.5.70               1  153     94.1    0.0     0.0     1.00
>>2.6.0-test1          1  153     94.1    0.0     0.0     1.00
>>2.6.0-test1-mm1      1  152     94.7    0.0     0.0     1.00
>>cacherun:
>>Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
>>2.5.69               1  146     98.6    0.0     0.0     0.95
>>2.5.70               1  146     98.6    0.0     0.0     0.95
>>2.6.0-test1          1  146     98.6    0.0     0.0     0.95
>>2.6.0-test1-mm1      1  146     98.6    0.0     0.0     0.96
>>process_load:
>>Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
>>2.5.69               1  331     43.8    90.0    55.3    2.16
>>2.5.70               1  199     72.4    27.0    25.5    1.30
>>2.6.0-test1          1  264     54.5    61.0    44.3    1.73
>>2.6.0-test1-mm1      1  323     44.9    88.0    54.2    2.12
>>ctar_load:
>>Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
>>2.5.69               1  190     77.9    0.0     0.0     1.24
>>2.5.70               1  186     80.1    0.0     0.0     1.22
>>2.6.0-test1          1  213     70.4    0.0     0.0     1.39
>>2.6.0-test1-mm1      1  207     72.5    0.0     0.0     1.36
>>xtar_load:
>>Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
>>2.5.69               1  196     75.0    0.0     3.1     1.28
>>2.5.70               1  195     75.9    0.0     3.1     1.27
>>2.6.0-test1          1  193     76.7    1.0     4.1     1.26
>>2.6.0-test1-mm1      1  195     75.9    1.0     4.1     1.28
>>io_load:
>>Kernel          [runs]  Time    CPU%    Loads   LCPU%   Ratio
>>2.5.69               1  437     34.6    69.1    15.1    2.86
>>2.5.70               1  401     37.7    72.3    17.4    2.62
>>2.6.0-test1          1  243     61.3    48.1    17.3    1.59
>>2.6.0-test1-mm1      1  336     44.9    64.5    17.3    2.21
>
>Looks like gcc is getting less priority after a read completes.
>Keep an eye on this please.

That _might_ (add salt) be priorities of kernel threads dropping too low.

I'm also seeing occasional total stalls under heavy I/O in the order of 
10-12 seconds (even the disk stops).  I have no idea if that's something in 
mm or the scheduler changes though, as I've yet to do any isolation and/or 
tinkering.  All I know at this point is that I haven't seen it in stock yet.

         -Mike 

