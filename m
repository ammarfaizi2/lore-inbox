Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbUCRDz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 22:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUCRDz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 22:55:59 -0500
Received: from home.geizhals.at ([213.229.14.34]:4308 "EHLO
	morework.geizhals.at") by vger.kernel.org with ESMTP
	id S262316AbUCRDz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 22:55:57 -0500
Message-ID: <40591EC1.1060204@geizhals.at>
Date: Thu, 18 Mar 2004 05:00:01 +0100
From: "Marinos J. Yannikos" <mjy@geizhals.at>
User-Agent: Mozilla Thunderbird 0.5b (Windows/20040201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: CONFIG_PREEMPT and server workloads
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

we upgraded a few production boxes from 2.4.x to 2.6.4 recently and the 
default .config setting was CONFIG_PREEMPT=y. To get straight to the 
point: according to our measurements, this results in severe performance 
degradation with our typical and some artificial workload. By "severe" I 
mean this:

---

1. "production" load(*), kernel-compiles (make -j5, in both cases 
kernels with CONFIG_PREEMPT=n were compiled), dual Xeon 3,06GHz/4GB RAM, 
SMP+HT.

2.6.4 with CONFIG_PREEMPT=y:
real    4m41.741s
user    6m13.631s
sys     0m43.729s

2.6.4 with CONFIG_PREEMPT=n:
real    2m20.424s
user    5m54.498s
sys     0m37.297s

The slowness during the compilation was very noticeable on the console.

2. artificial load(**), kernel-compiles (make -j5), single 2,8GHz P4 
with SMP+HT:

2.6.4 with CONFIG_PREEMPT=y:
real    7m40.933s
user    5m42.454s
sys     0m28.114s

2.6.4 with CONFIG_PREEMPT=n:
real    7m13.735s
user    4m56.266s
sys     0m35.495s

3. no noticeable slowdown with no load at all during the benchmarking 
was observed.

(*) busy webserver doing apache/mod_perl stuff, ~40 static/~10 dynamic 
hits/sec, ~20% CPU usage; typical load has no significant 
jumps/anomalies in this time frame (it's also one of 3 boxes in a 
cluster with a hardware load balancer)
(**) "ab -n 100000 -c2 <some simple CGI script>" from another box 
running at the same time
---

Now, we can go into details about our methodology and what else may have 
been borked about our boxes, but what I'm wondering about is (assuming 
that we didn't mess things up somewhere and other people can confirm 
this!): why in the world would anyone want CONFIG_PREEMPT=y as a default 
setting when it has such an impact on performance in actual production 
environments? Is 2.6 intended to become the "Desktop Linux" code path? 
If not, shouldn't there be a big warning sticker somewhere that says 
"DON'T EVEN THINK ABOUT KEEPING THIS DEFAULT SETTING UNLESS ALL YOU WANT 
TO DO IS LISTEN TO MP3 AUDIO WHILE USING XFREE86!"? I've been skimming 
over older lkml postings about performance problems with 2.6.x and many 
of them, while obviously being about systems with CONFIG_PREEMPT=y, 
don't even mention the fact that the degradation might be because of 
that setting. Noone seems to know/care. Why?

Regards,
  Marinos
-- 
Dipl.-Ing. Marinos Yannikos, CEO
Preisvergleich Internet Services AG
Franzensbrückenstraße 8/2/16, A-1020 Wien
Tel./Fax: (+431) 5811609-52/-55
