Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129495AbRCPCxq>; Thu, 15 Mar 2001 21:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129598AbRCPCxg>; Thu, 15 Mar 2001 21:53:36 -0500
Received: from mail.cis.nctu.edu.tw ([140.113.23.5]:39433 "EHLO
	mail.cis.nctu.edu.tw") by vger.kernel.org with ESMTP
	id <S129495AbRCPCxY>; Thu, 15 Mar 2001 21:53:24 -0500
Message-ID: <000b01c0adc4$2482c8c0$ae58718c@cis.nctu.edu.tw>
Reply-To: "gis88530" <gis88530@cis.nctu.edu.tw>
From: "gis88530" <gis88530@cis.nctu.edu.tw>
To: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0103152222121.1320-100000@duckman.distro.conectiva>
Subject: kernel benchmark
Date: Fri, 16 Mar 2001 10:52:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I use kernprof+gprof to measure the 2.2.16 kernel,
but the scale is mini-second. 
So I use do_gettimeofday( ) kernel function call to measure 
the latency. (This function support micro-second scale.)

Moreover, I use SmartBits packet generator to generate
the specific network traffic load. The environment is
as follows. However, the result are very funny. I think 
that latency should increase progressively when load
increase, but the result are unable explaining.
Could you give me some hint? Thanks a lot.

1518byte packet
load    latency(us)
1%    13.1284
10%    14.1629
20%    12.6558
30%    11.1056
40%    10.7510
50%    10.4148
60%    10.3337
70%    10.1038
80%    10.1103
90%    10.3634
100%    11.2367

64byte packet
load    latency(us)
1%    3.6767
10%    2.7696
20%    4.3926
30%    2.8135
40%    8.2552
50%    5.3088
60%    9.3744
70%    23.6247
80%    8.5351
90%    9.7217
100%    13.065

Benchmark Environment:
+---smartbits<---+
|                         |
+---->Linux-----+


* The do_gettimeofday function call is as follows:
--------------
do_gettimeofday(&begin);
...
(kernel do something)
...
do_gettimeofday(&end);
if (end.tv_usec < begin.tv_usec) {
    end.tv_usec += 1000000; end.tv_sec--;
}
end.tv_sedc -= begin.tv_sec;
end.tv_usec -= begin.tv_usec;
return ((end.tv_sec*1000000) + end.tv_usec);


