Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTIHW15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263689AbTIHW14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:27:56 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:35481 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262942AbTIHW1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:27:46 -0400
Message-ID: <3F5D023A.5090405@austin.ibm.com>
Date: Mon, 08 Sep 2003 17:27:06 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>That is not clear at this time.  We do know that the reaim regression was
>introduced by sched-2.6.0-test2-mm2-A3, but we don't know why.  Certainly
>that patch did not introduce the problem which Andrew's patch fixed.  And
>we have theorised that Andrew's patch brought back the reaim throughput. 
>And we have extrapolated those observations to possible improvements in
>volanomark throughput.
>
>It's all foggy and I'd like to see a clean rerun of specjbb and volanomark
>by Mark Peloquin and co, confirming that -mm6 is performing OK.
>  
>
For specjbb things are looking good from a throughput point of view. 



  
       2.6.0-test4 2.6.0-test4-mm6
  # of WHs      OPs/sec      OPs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1      9783.46     10093.09     3.16       309.63       293.50  *
         4     33783.93     35763.79     5.86      1979.86      1013.52  *
         7     54401.52     54288.06    -0.21      -113.46      1632.05
        10     56861.59     56445.20    -0.73      -416.39      1705.85
        13     56024.86     55720.23    -0.54      -304.63      1680.75
        16     43874.77     48994.63    11.67      5119.86      1316.24  *
        19     32658.83     31248.04    -4.32     -1410.79       979.76  *

But to get these numbers we are using much more CPU. I'll leave it to 
others to decide if this is good or not.

CPU IDLE TIME
           2.6.0-test4 2.6.0-test4-mm6
  # of WHs         %CPU         %CPU    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        87.30        87.31     0.01         0.01         3.62
         4        49.53        49.51    -0.04        -0.02         2.49
         7        12.40        12.32    -0.65        -0.08         1.37
        10         0.36         0.40    11.11         0.04         1.01
        13         1.20         0.62   -48.33        -0.58         1.04
        16        15.17         2.79   -81.61       -12.38         1.46  *
        19        30.66         5.29   -82.75       -25.37         1.92  *


Volanomark, on the other hand is still off by quite a bit from test4 stock

Results:Throughput
 
                                tolerance = 0.00 + 3.00% of 2.6.0-test4
            2.6.0-test4 2.6.0-test4-mm6
               Msgs/sec     Msgs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        40757        37223    -8.67     -3534.00      1222.71  *
 

>
>Also, I'm concerned that sched-2.6.0-test2-mm2-A3 caused slowdowns and
>Andrew's patch caused speedups and they just cancelled out.  Let's get
>Andrew's patch into Linus's tree and see if it speeds things up.  If it
>does, we probably still have a problem.
>

If thre is any particular patch/tree combination you would like me to 
try out, please let me know and I will see if I can get the results for 
you. 

Steve

