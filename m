Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276231AbRJCN0S>; Wed, 3 Oct 2001 09:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276230AbRJCN0L>; Wed, 3 Oct 2001 09:26:11 -0400
Received: from mail.sneakemail.com ([64.23.225.151]:61966 "HELO
	mail.sneakemail.com") by vger.kernel.org with SMTP
	id <S276223AbRJCN0F>; Wed, 3 Oct 2001 09:26:05 -0400
Message-ID: <134798577.1002115593411.JavaMail.root@boots>
Date: 03 Oct 2001 09:26:20 -0000
From: "Geoffrey Hausheer" <18kll001@sneakemail.com>
To: linux-kernel@vger.kernel.org
Subject: Strange system-clcok behaviour
Mime-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having some very strange behaviour from my system clock.  I am not sure 
that it is really a kernel problem, but I don't know where else to look.  The 
problem is that my kernel does not keep consistent time.  It doesn't have a 
regular drift, but instead jumps radically every once in a while.  I have had 
this problem since switching to the 2.4.xx kernels (never with the 2.2.xx 
kernels),and am currently running 2.4.9.  This is a PentiumII laptop, and the 
kernel is compiled with no APM support.  Please don't recomend ntpd, I've tried
it, and it doesn't work well for this problem.  If there is any other 
info I can provide (or if someone can point me in another direction), please 
let me know.

adjtimex -p reports:
         mode: 0
       offset: 0
    frequency: 5065932
     maxerror: 16384000
     esterror: 16384000
       status: 65
time_constant: 2
    precision: 1
    tolerance: 33554432
         tick: 10000
     raw time:  1002095853s 812935us = 1002095853.812935
 return value = 5

Here are some snippets from running adjtimex -c:
the clock was synchronized against the hardware clock just before the trace
I have validated that the hw clock keeps at least reasonably accurate time.
1001882724        0.001034       0.001034   10000   5065932
1001882734       -0.000707      -0.001741   10000   5065932
1001882744       -0.000758      -0.000051   10000   5065932    10000   5400165
1001882754       -0.000805      -0.000047   10000   5065932    10000   5373951
1001882764       -0.000849      -0.000044   10000   5065932    10000   5354290
...two days later...
1002075913    -8151.712480       0.000009   10000   5065932    10000   5006950
1002075923    -8151.712469       0.000011   10000   5065932    10000   4993843
1002075933    -8151.712454       0.000015   10000   5065932    10000   4967628
1002075943    -8151.712437       0.000017   10000   5065932    10000   4954521
1002075953    -8151.712425       0.000012   10000   5065932    10000   4987289
1002075963    -8151.712417       0.000008   10000   5065932    10000   5013503
1002075973    -8151.712400       0.000017   10000   5065932    10000   4954521
1002075983    -8151.712389       0.000011   10000   5065932    10000   4993842
1002075993    -8151.802377      -0.089988   10000   5065932    10091  -1566311
...
1002076093    -8151.892229       0.000014   10000   5065932    10000   4974182
1002076103    -8151.892211       0.000018   10000   5065932    10000   4947967
1002076113    -8151.892198       0.000013   10000   5065932    10000   4980735
1002076123    -8151.892181       0.000017   10000   5065932    10000   4954521
1002076133    -8151.892166       0.000015   10000   5065932    10000   4967628
1002076143    -8151.892153       0.000013   10000   5065932    10000   4980735
1002076153    -8151.892135       0.000018   10000   5065932    10000   4947967
1002076163    -8151.892120       0.000015   10000   5065932    10000   4967628
1002076192    -8171.223589     -19.331469   10000   5065932    29332   1585971
...
1002076653    -8171.382818       0.000021   10000   5065932    10000   4928306
1002076663    -8171.382803       0.000015   10000   5065932    10000   4967628
1002076673    -8171.382785       0.000018   10000   5065932    10000   4947967
1002076683    -8171.382766       0.000019   10000   5065932    10000   4941413
1002076693    -8171.382736       0.000030   10000   5065932    10000   4869324
1002076703    -8171.382730       0.000006   10000   5065932    10000   5026610
1002076713    -8171.382712       0.000018   10000   5065932    10000   4947967
1002077037    -8485.777411    -314.394699   10000   5065932   324395   3093298
1002077050    -8485.777439      -0.000028   10000   5065932    10000   5249433

my /etc/adjtime looks like:
0.000000 0 0.000000
0
LOCAL

Please CC me on any correspondence
Thanks,
.Geoff


-----------------------------------------------------
Protect yourself from spam, use http://sneakemail.com
