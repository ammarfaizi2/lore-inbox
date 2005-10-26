Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbVJZWOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVJZWOx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 18:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbVJZWOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 18:14:52 -0400
Received: from unused.mind.net ([69.9.134.98]:31129 "EHLO echo.lysdexia.org")
	by vger.kernel.org with ESMTP id S1751016AbVJZWOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 18:14:52 -0400
Date: Wed, 26 Oct 2005 15:07:04 -0700 (PDT)
From: William Weston <weston@lysdexia.org>
To: Rui Nuno Capela <rncbc@rncbc.org>
cc: george@mvista.com, Ingo Molnar <mingo@elte.hu>,
       john stultz <johnstul@us.ibm.com>,
       Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Mark Knecht <markknecht@gmail.com>,
       Steven Rostedt <rostedt@goodmis.org>,
       david singleton <dsingleton@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       cc@ccrma.Stanford.EDU
Subject: Re: 2.6.14-rc4-rt7
In-Reply-To: <435FEAE7.8090104@rncbc.org>
Message-ID: <Pine.LNX.4.58.0510261449310.20155@echo.lysdexia.org>
References: <1129852531.5227.4.camel@cmn3.stanford.edu> <20051021080504.GA5088@elte.hu>
 <1129937138.5001.4.camel@cmn3.stanford.edu> <20051022035851.GC12751@elte.hu>
 <1130182121.4983.7.camel@cmn3.stanford.edu> <1130182717.4637.2.camel@cmn3.stanford.edu>
 <1130183199.27168.296.camel@cog.beaverton.ibm.com> <20051025154440.GA12149@elte.hu>
 <1130264218.27168.320.camel@cog.beaverton.ibm.com> <435E91AA.7080900@mvista.com>
 <20051026082800.GB28660@elte.hu> <435FA8BD.4050105@mvista.com>
 <435FBA34.5040000@mvista.com> <435FEAE7.8090104@rncbc.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-472154353-1130364424=:20155"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--8323328-472154353-1130364424=:20155
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 26 Oct 2005, Rui Nuno Capela wrote:

> Just noticed a couple or more of this on dmesg. Maybe its old news and 
> being discussed already. Otherwise my P4@2.53Ghz/UP laptop boots and 
> runs without hicups on 2.6.14-rc5-rt7 (config.gz attached).
> 
> ... time warped from 13551912584 to 13551905960.
> ... system time:     13488892865 .. 13488892865.
> udevstart/1579[CPU#0]: BUG in get_monotonic_clock_ts at 
> kernel/time/timeofday.c:
> 262
>   [<c0116fcb>] __WARN_ON+0x4f/0x6c (8)
>   [<c012f8b0>] get_monotonic_clock_ts+0x27a/0x2f0 (40)
>   [<c0141c9d>] kmem_cache_alloc+0x51/0xac (76)
>   [<c0114826>] copy_process+0x2ff/0xeed (44)
>   [<c0139444>] unlock_page+0x17/0x4a (12)
>   [<c0147a8a>] do_wp_page+0x245/0x372 (20)
>   [<c01154f5>] do_fork+0x69/0x1b5 (56)
>   [<c02c120b>] do_page_fault+0x432/0x543 (32)
>   [<c01017aa>] sys_clone+0x32/0x36 (72)
>   [<c0102a9b>] sysenter_past_esp+0x54/0x75 (16)

I'm getting these with two different machines running 2.6.14-rc5-rt7 with
Steven's ktimer_interrupt() patch from yesterday.  Did not see these with
previous -rt kernels.  Shutting down NTP makes no difference.

This is from the athlon-xp/via-kt400 box (xeon smt box looks similar):

... time warped from 945167068424 to 945167068179.
... system time:     945133952528 .. 945133952528.
crond/2584[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c011953d>] copy_process+0x41d/0xf10 (84)
 [<c011600f>] activate_task+0x5f/0x70 (12)
 [<c011a12b>] do_fork+0x6b/0x1f0 (68)
 [<c0335285>] __schedule+0x365/0x6b0 (24)
 [<c0107302>] do_syscall_trace+0x1d2/0x1f0 (32)
 [<c01019b2>] sys_clone+0x32/0x40 (28)
 [<c0102ddd>] syscall_call+0x7/0xb (16)
... time warped from 6853686562624 to 6853686562329.
... system time:     6853631273662 .. 6853631273662.
top/3207[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c0198cde>] uptime_read_proc+0x2e/0xd0 (84)
 [<c01411a5>] audit_filter_syscall+0x45/0xd0 (28)
 [<c0198cb0>] uptime_read_proc+0x0/0xd0 (20)
 [<c0196740>] proc_file_read+0x1a0/0x250 (16)
 [<c01965a0>] proc_file_read+0x0/0x250 (48)
 [<c0163ce6>] vfs_read+0xb6/0x170 (4)
 [<c0164071>] sys_read+0x41/0x70 (24)
 [<c0102ddd>] syscall_call+0x7/0xb (28)
... time warped from 8420727047178 to 8420727046873.
... system time:     8420661679983 .. 8420661679983.
wget/3250[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c012dcc0>] posix_ktime_get_ts+0x0/0x10 (68)
 [<c0133790>] ktimer_get_res+0x0/0x20 (4)
 [<c012dcc7>] posix_ktime_get_ts+0x7/0x10 (12)
 [<c012ed44>] sys_clock_gettime+0x74/0x90 (4)
 [<c0102ddd>] syscall_call+0x7/0xb (20)
(          phasex-3174 |#0): new 27 us maximum-latency wakeup.
... time warped from 10109461139641 to 10109461139296.
... system time:     10109399212009 .. 10109399212009.
top/3207[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c0198cde>] uptime_read_proc+0x2e/0xd0 (84)
 [<c01411a5>] audit_filter_syscall+0x45/0xd0 (28)
 [<c0198cb0>] uptime_read_proc+0x0/0xd0 (20)
 [<c0196740>] proc_file_read+0x1a0/0x250 (16)
 [<c01965a0>] proc_file_read+0x0/0x250 (48)
 [<c0163ce6>] vfs_read+0xb6/0x170 (4)
 [<c0164071>] sys_read+0x41/0x70 (24)
 [<c0102ddd>] syscall_call+0x7/0xb (28)
... time warped from 32482693158437 to 32482693158230.
... system time:     32482660250031 .. 32482660250031.
top/3725[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c0198cde>] uptime_read_proc+0x2e/0xd0 (84)
 [<c01411a5>] audit_filter_syscall+0x45/0xd0 (28)
 [<c0198cb0>] uptime_read_proc+0x0/0xd0 (20)
 [<c0196740>] proc_file_read+0x1a0/0x250 (16)
 [<c01965a0>] proc_file_read+0x0/0x250 (48)
 [<c0163ce6>] vfs_read+0xb6/0x170 (4)
 [<c0164071>] sys_read+0x41/0x70 (24)
 [<c0102ddd>] syscall_call+0x7/0xb (28)
... time warped from 32716462596526 to 32716462596335.
... system time:     32716439248732 .. 32716439248732.
bash/2994[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c011953d>] copy_process+0x41d/0xf10 (84)
 [<c013427b>] __init_rt_mutex+0x1b/0x30 (12)
 [<c011a12b>] do_fork+0x6b/0x1f0 (68)
 [<c0107302>] do_syscall_trace+0x1d2/0x1f0 (56)
 [<c01019b2>] sys_clone+0x32/0x40 (28)
 [<c0102ddd>] syscall_call+0x7/0xb (16)
... time warped from 35905926422502 to 35905926422326.
... system time:     35905875002399 .. 35905875002399.
0logwatch/3805[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c011953d>] copy_process+0x41d/0xf10 (84)
 [<c011a12b>] do_fork+0x6b/0x1f0 (80)
 [<c0107302>] do_syscall_trace+0x1d2/0x1f0 (56)
 [<c01019b2>] sys_clone+0x32/0x40 (28)
 [<c0102ddd>] syscall_call+0x7/0xb (16)
... time warped from 35906285042477 to 35906285042296.
... system time:     35906218002396 .. 35906218002396.
sh/4023[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c011953d>] copy_process+0x41d/0xf10 (84)
 [<c011a12b>] do_fork+0x6b/0x1f0 (80)
 [<c0107302>] do_syscall_trace+0x1d2/0x1f0 (56)
 [<c01019b2>] sys_clone+0x32/0x40 (28)
 [<c0102ddd>] syscall_call+0x7/0xb (16)
... time warped from 35907691480506 to 35907691480313.
... system time:     35907639002385 .. 35907639002385.
sh/4038[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c011953d>] copy_process+0x41d/0xf10 (84)
 [<c011a12b>] do_fork+0x6b/0x1f0 (80)
 [<c0107302>] do_syscall_trace+0x1d2/0x1f0 (56)
 [<c01019b2>] sys_clone+0x32/0x40 (28)
 [<c0102ddd>] syscall_call+0x7/0xb (16)
... time warped from 35929004908544 to 35929004908333.
... system time:     35928954002217 .. 35928954002217.
makewhatis.cron/4201[CPU#0]: BUG in get_monotonic_clock_ts at 
kernel/time/timeofday.c:262
 [<c011befe>] __WARN_ON+0x5e/0xa0 (8)
 [<c013610e>] get_monotonic_clock_ts+0x24e/0x2c0 (48)
 [<c011953d>] copy_process+0x41d/0xf10 (84)
 [<c011a12b>] do_fork+0x6b/0x1f0 (80)
 [<c0107302>] do_syscall_trace+0x1d2/0x1f0 (56)
 [<c01019b2>] sys_clone+0x32/0x40 (28)
 [<c0102ddd>] syscall_call+0x7/0xb (16)


--ww

--8323328-472154353-1130364424=:20155
Content-Type: APPLICATION/x-gzip; name="config-2.6.14-rc5-rt7.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0510261507040.20155@echo.lysdexia.org>
Content-Description: 
Content-Disposition: attachment; filename="config-2.6.14-rc5-rt7.gz"

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
QOpBbFadsMBRxutopGosMvj//wFZ1ZCDmYEAAA==

--8323328-472154353-1130364424=:20155
Content-Type: APPLICATION/x-gzip; name="dmesg-2.6.14-rc5-rt7.gz"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0510261507041.20155@echo.lysdexia.org>
Content-Description: 
Content-Disposition: attachment; filename="dmesg-2.6.14-rc5-rt7.gz"

H4sICKH9X0MCA2RtZXNnLTIuNi4xNC1yYzUtcnQ3AMRa+3PayJb+XX/F2Tt3
dyAXsB5IPHaSGmzshEmwWUMeW96Uq5EarGuBGEk49vz1+51uiYdNbN3MbG1S
hZH6nO7z+Po8uvkQLtf3dCeTNIyXZDe8htWsJ75bT7IWVZI4zn4VaSaSTDai
hzSQ96FoxMm8SpW572/4mg2zYZFtmq7ZssF3KQN6JzL9vu5Wq/STRaPL09Ph
aEKTtaQLPyPbJavVddyu7dCoP1HsxvHgYlxfJfFdGGCO1c1DGvoiosvekBZi
1TVIEci2bXbJfPSP6ruvOjMfryrrVEwjWf0eo6baYxRqrkoiU5ncyeC7rLMn
a1pmOVbrsbjObMZyvCDuhmqfcaYYeyejAQUiE9/nne3zNguzad7zT+PDrDPp
P5aXX1klVJ1J+ZRVlmPV8u6wWhs/77Badmt4TO8Gb98NT4ck7kQYsQEbRrvj
YeDDxedH7y+WtIwDSSZlcSailZjLtEu2Z1tN0yDqD3v0R7yUXWqaHY/UcI0+
DM4uaCoy/6Zrgeg8ThYApaazbddumwcoHSZ9F85vhnKR0zp2y2semtQ1+sMB
tp9DK9ZtmTUMdkqXLsf9EVXuWOve+OOYXvxXpV/JvGcDujPX3M4yUbNYxSy9
1qf2l/oXAm3TdkxbOhYNx2cTPDsW/puOpWcqQJfPdNb7kzNN7Xym44uLPzeT
U8g0/LMyue18pv7WTqTn2pmpwGAxUw7I6cbi6l8+02hYn4QLmdDggkZxkgHY
97JpFgt9iDmq9UaDExJBAJenGC92S0GjhivCX4XXYXDFS3ylSKxCf/sol4xq
7INREvuYJU7oJ5O8rmXqyYsAbXm7k16fA2yPJr4BUEkGc0lRuMzw0vpazXkG
F1oSTWt/LUS+YpF1bPhK8zS8nopUXpngQ6heIXznjFlMs02AKziqhh4FfZdy
pciubSR2anuW0Uw1ejsekFm3nUK088n1+PLk+uLTJVWma9ASPq/D5Hd8m0fx
VETqwaZgFin1qi9zdnY5OxTF3yiSdzLasF7+l0nrFApOHyiGwAmSVWM7aD83
2DkweMpeDJdz7bMFwlOX6CwSWYPoY8oDFg2OLtRwaug3KmZXGPpVmsHt4+GI
/Hg5C+frRGRswXA54zjF341eFAFxGTOOTgYEs8brBIAhldv5NbK1u4mvc6Ra
KvJDd7pxWV9m0s8gvm02Ww233aThuz8QsnLsNYxLKSIFfBolUi5WSpDxerXC
FqDKSZWTfLPOmZ4Gy3lMwzhaisQ4XodRBiU5SkZhmqXGe5ngKzRaLMQyYEzC
JklMXJG8Pgrk3dEisCgFNeqX12aBuF28BTneZIG3ZZiFIgr/YHVPRh9/Mo3P
vcvzwfnbLsn7lUwg9jLjYuPkI4WLVSTVM6vQMEAPhAAQMJh/i+h9I5LgtW82
3Skvk8azTD1x8WCMBn2MpzeU8e7EJs2SkLOMSimVOAlk0iULYPdc1/GAhUym
VeP0DoSkHUOrMIMDsViE7U3fwuyGfLGCvySHkpZxEi/TOIJN/DgCB3162/sH
tc17G5mE13sAuX8jD4qBCIgybSNIq0au3bTb7UKQASfI+vf5tdQFu1fT2bNZ
sCPdxckDljEd1/bat0eW2Wy7nnm7TcNUse2Wc0u3hZcDWYNBOmbzlorcXqNO
s3WrShqMtcEewoE1Jb3r3aqAtZCLqnFyI/1b9mk4o+wmTLd4pJt4CeOkeC3p
84imMCo2Mm8NStfw+F3IVLzhGo0GXdzCzwDINNE7JZCReMB25e+ZCubpSvrh
LPQBwzVIwKV82miZdBzP4+FgNKZKtPrna+yPtuM2q8ZY+uskzB7oLBEL+S1O
bunOQlVsKm0UHGVgjE8/MI6x6/uhKgAD3o9TYL1hDOP1MnvGG65lMzq71Jtl
EHEul0CyTwgsyyycPdQUboAZp+3MprMZ+Zavv2zKqRJfdleAAQNY7f9igQ+I
c3TCqgJXzfdU8XJUHXEAqNaon8P6wGA+g13wwy7fodFqYGcpH6SlFbCfVWCw
zADlBRbHSuQzKEkkeOKQuU4kI47DoAwaB2kTyaOMtTypE0KnClMNY5El2Gl3
NmBTsVkQ1+oUygz71MtuonhZmQyr9GWEItM0/4HALlcrng2ibfLLDL0cnSGU
peJOEgdW7LYsThT8AwTfnVy0Xi5EegsxxgMswUzy3pc6oueqbLk2e/Dnmyj7
WUWuZO2r0Mkb633DoGx6PxO+rKNs6tAVlxFRLIJrheZ0p4Dt6tQ20e/Ttc97
ebaOogcS/u/rMMF+GYlE7Ur2ISJhlsQRDWV2Ewdpt/H/9M9QEtMV15BfUSsx
Mtwq2hcHofFi+k+gINWBvNmivrwLOf1awFQuOGo0upRzmCw1dEOGgJGuYLJ9
I7DVdHzgXEhIOp2p12kb8g5l0h1CBZpaCwZ2iurwcYfQpUkilmmoPIlcqRbj
GLizjnF63jv+gNSIGq6ukipKl9RoNCaD4ekloAht4uQ1l9NIVUvrtc1/7Nd1
62kaW8pvu7nL3adQBe0zqc42zk8nXWUZQDrhQ4EkzmKkPaB5EcIgm9qWq7js
YYVV/RDALhgMVDxdVfZwm4kBRH192IEqWedKGBNFptXpoMKMeI9gqteWZtTl
1n5ppVax8mXH62n6gKUWO1PzSUgHssu7+UpOo9u62UF+vTI9OOXu2k+kyOQ1
hq6nqMtulVPejk4BGXaIeUZX13j8irIVaqSkijkWsbM7IWqJZyc8Q+IIyKHP
4hbZ9TQPKhZdIp9whYYVUs6EKmcqNlQVXPaoIKSheHQWyig4Ol7PZjI5GqH0
Qe+6TV3KGj+y47bFGIvkHW2xT/aRTWpVfMV3m/Ti2B/WkWVRLkNKFcd1VCvP
pdM90mxWRAS9ueh6POlxjLsenAPfPxwdDNfcbNeZMimwkAnYYDlHljHVOihL
aHedot5HnE/Q0XO+yaN6PqJRlTdIXL+HTJqsV1leW8yLRhK4HWzGUCbc0tWH
8/e9r1ThLQn/Nsklj1610KoA0DCRZVefZz7eMr/S3P8C88njlfd46RW2UJAX
MY3nZ+ofmulVSTFOnzK/Kq3D2Z+x3tunKxecZDXJQtB/1dmZ4pLD9DE6Peyc
K7xAs1xRfRU3JTo2JfG0aM24r/gmUC7optQshOml6RqbVsX8aT7Z/1yPj68b
ekqmxj42jWOm4OPTGAWs2gj8Wq1nYcmGeVC7Sw06ypPYdubG9ehy8vVf5MGH
lTOqwpZG0Xqu6o0Rl9RFQ3hnNjotqvhV6gViQcdcbxurJXrP0XKk8xKHmv1X
3XwXwtpav3Q3Tism3k/w0GYnqfHBjERhkSCW6fLnjLgerxFngL8hZ7xmeoke
72/ou0GO3HUjoxUKxFWMnCDyEk2Lo+1JYaw0QUKFQ9QRj1nnPy2UkfE6ChCh
4C+56WqeZW5r5rb1IvP0CTOapzp/trhJABO6nDJsTovZnJZ7gE2ZTQO3myOI
5W7wOengApkafcC3LnGfXQ/QcOM1H7YW7+VMV8Z1OZPcj/P46PL07HRy8m6H
SFPVZ62ZJlLHUkBzHWWuiQxnKWxfoxq4XsXfEEi3dUx/g282lB5diCXSAyNS
yz+WmQJphAS59B/yRi6eFVDY1YuTr9c0xqr5J7WRziIx1+WBI7giUfn53jKG
e7X7tjJexVG00y+qmxPEQbFadHX5sTmRa9hqcj7eMh2q9JPwTjVXxbDlCb+q
GfOTIjRcfG7EEMeM6yBEfRTuHmosZRZxlEqRyyFqpYjDVU1dsSzHRJ/vua2G
1fS6VrW714XmHTX6zvWSa7cYNVaKEe7F9KG1MeEzc3q3nsvJh2MkO+70Oefy
4RK37OajU5bkYZXF80SsblDkIdflcQSdCzoZ7TDYKOM+9sS6OuEzR8is8Dr2
xXKpmhbsZt78PiJjqgpt2LZLWeqTz1VLXkhu8LupJRvGe+UGTD5GWQlXBew+
ddLJJ2DRWrlMlb7qfGez9nmsI9Z/6HiVQ0XFHXXEReqI60SVWoXj4DE7j3Zi
vprD8Tqnc9PDkc4yLRXq+tx6/YauKTVyOgZyfq72adCj9xMEkSP12cMfD7sA
WFsBfFuG3tsRiZVMVGMJ/HvNoTqFnrXzbvQqSBZfabfKwgvSJw98Bmd2bPdg
UN/NFFeoMupv1JkrCrSKOgSt8XlolV9zhEXt/XSlBA2KhnBLr+aaDtIjmzpc
wplml4zR+Qgrj1Hr5f1bBBte4a3pmE53NLbf1/hhph+GX/Ue9MwaPpp8DkdW
DfZGpApjoLhtNm3qffxCKrg9pX1E+f64/z1KYwxCEXWpbbsm6lIXFV6gXfz3
y7y+70K3jkl/R33OsyBBsC1SpO6d9t0IY0oZc2tWbRnHq92eZG9QoCD3w5XI
eDd9jyiQIuBDjO8S+LPfd8fOoni1etCyV1Js9VlgMlSsRrM5NM76J6QehUpu
dfQ+FlQ2Wy0jgqjdos2sLMQ9tYtMWzVWt5kf3AVdRrTdMIU+0DVbdVQ+v0mU
7737aYziRfCfX9N1KhuBrKrUv+IyOLZ/zWQUioYfL4y7UNQTDqMNv8v7x6x/
eG/xtHW74dFv66Ws4x2vQJ+TMMt0/OvHS4HceIzAK5O/MF18fzeYXcve2w22
c3g3tHTO+RQK9TwL79crFb9256nRLIkX6gIScEO/gP3A+/5SJZTBQIMyP3MH
NXPKrvC6TbfrWl1/VssXa+TMQ/CM3v13XheBu7g4sWoqunIded9qexgLgOMs
VJWSaUlLF7VNU1gNI1sD1x+XjPSUI9zH86NJb7SpmNQWQJvT8DQlH+YDNB3t
niFQ8j4R6fJBLNPbB/oFsLn99fe1iPgEn539xsDcfCFBw3WUhXUE1kw9ntYH
/dNii213GEKHKaLVjbCNkO9DVP3LcjsO3znkHTdXvelKAqgqS6Aq4Wie/ufm
ckWfJ+ALd/T398an0TWWQzWINf1t5IHR2PFpFO/4HIj8C+HFpxJ8o1Q3nbar
D8DyN9eBZO23M33U5zYZV/BqRIEpTh7XLErCZ2ELAsC2C4kYty+iE+Q5Om3X
Vfh0NxbLc9D2kMPbDLG+lmn+Oy1FxuLqG6xvIXrxFVobqe5NVAWWbHgY8XdZ
23Zcvs6/405HOeVjf9izHGfXOVxW+eGe0mwnOBXgPx7W+c5e7Rm+fKmrP62a
rrZSXf2hArgJRBeENXyZ8pdiCuvJFG09xezAFH4xRaCmKPo2lnub61kuLlN4
RfqMOPu5j6z823HdNM+GPWzo3qRH/cH4vQa9wQKVoeN5tZDWjNW0Zq0a32B7
6nyIc1fz+xJZWiIfSPlw+mVycUkn/foljb7UPzfbdrOnVkPrdNI/6n/CyMVw
I13wWLrTyWHprFw61VJYLSVdayudqy3CCSWRv68lWipdXVp2+314rEct13NM
q9luw+58xJhSBcvaHg2Pq/TtqG11bNDqM/4anbwbv+bbKBeJ+shzago9FYu7
ZjWbviyYRev0Rp0l5wfwhkIDf1j8YfOHwx9N+oX/uPzh8UeLP9r80VHkJr3R
/npGi+lfqsX0WS2mrMWUtZiyFlPWYqq1mLIWU9ZiylpMWYtpR5FrLYKDWph2
U6sR/Igalue0nSMEjyd6BM/qEbAeAesRsB4B6xFoPQLWI2A9AtYjYD2CjiLX
egDTGrtN84tCNbDLf44uP2ts1tQl3e1GUCWW41Q3GelkB/C7Ochp2KaxQMTN
S9VFjHqmCMKc2ABtjp986MhkRrhcrTMOxjReScHlSWj7xNfVxX1dvoixgMaJ
CKEyqviUKxq+JNyWb4RuZpmQowgXQSGbiboTjeOw9+V62L/un34av7Zdr0Z4
GB9f83bEi5ZimobZQqy2v6doOB1j86uUZK17K8FNyh0W56o9Y/87COPojpf6
J051ElN9K9V48RzeLtTvTfQNAwf8gBtw1Mm38mEao4FT0SBFePXMI1WSo2Mc
qYMaST984zw5GREgzBdXKTd5L0/RKaYwd+dA6CzL7Lgdu+PtMHfp3YYx3VwX
cAW9K1l+4c/rqK963UQiP++U7loWf/fVi5cgL1O0XiZx8x+XDLCbxjdwvL/O
VDZXiOqtM3zlTlVdEPQGfRJJIh7ShhreAgkf6npd30UsxBy6wO8cRRWlDqci
3bCk05oqIsJFfgf6b2VnnBYzTkvNKKACsE+cDfkZfkpDLrKgkI6MxQgX0U/f
6jiKdYKQLyX4HuvjR9iBjxWYsCBqlSHyyhC5ZYicMkR2GSLrRaKtYcSeYUQZ
w4gyhhFlDCPKGEaUMYwoYxjxsmH0JVyAaO3mAXgZ/KKs9Gb3eVo85zG4S/nL
glalhW4OegRPzEfCV4W1amZsQrTkGI2EFCYJ0vIhKLcPIbm9C+RnXNEuAdF2
CYS2SwC0XQKf7RLwbD9G566yooSyooSyooSyooSyooSy4kVlt4iz9xDX3gdc
+wDe2m9ywqdos38Aba1DaGvtou0Z47ZKIKlVAkmtEkhqlUBS6zGSdhURJRQR
JRQRJRQRJRQRLyqyRYm5h5LWPkpaB1DSepMTPkWJ+QMo8Q6hxNtFyTOG80og
wCuBAK8EArzHCNgVUpQQUpQQUpQQUrwo5Na7zp53vX3vege8673JCZ961/kB
77qHvOvuevcZo7glPOeW8Jz72HO7AogSAogSAogXBdh6pbnnFXffK+4Br7hv
csKnXmn+gFecQ15xdr3yjMJOCYs7jy2+O7koMbl4cfKtNVt71nT2rekcsKbz
Jid8as3WD1jTPmRNe9eazyhjP7bULqN4kXFrBWvPCva+FewDVrDf5IRPrWD9
gBWsg13SgZdi+3IrvbdfHT8qjg/Vxm9ywqfSe2Wk55+gFo1f/+L8tGGcfpk4
9Rka+wX/uJpvD0J07fpKQc2kOn2+NBWZ0L8PNz6djbs0zOnVz3D+t52r7W0c
N8Lf9SsEtEATdC3znZJxe+hm7/YFbboHpOmHGoErS7LjJrYMy954D/fjO0NS
L3YtO27ust5D8iGw6WeGFJ8RxdHM8CxbL3lD9Bwc9jjNZ/dfAu/dIstsFq0p
93CJ7tMyNR7T2UcASb27/+SrhQlolaUYge+/zafTiYsfgz/rS3wBl8/SonrD
hK+j3rtU70vzWmr7xQr1VsUwyRdYN1G7/JiM6d4lwc+j4hDodjW0UYMqL3g7
b2KISclYTohRMJPzujckgfhmXDnaHUkLvY82jI9dFnO4LQbD1difm3I5/80q
nYy/AM3/uvL7VxeES3LzXJFAGsj+2zoSyHaPP3pErEU2I4H8uHQVFHfpKlg9
kQzQ9HqmkiKxgV28MvsupE/Woc4k1zBJJwLeb1LZlkmpAyaVbZqU3kkJI944
npoMrp7/9kqo9dp/7xpwoI0QEyrslmDyykUYacTE3YefD94OdPt2qLv98fKa
kr/S7e5AptndBFOMhoLUPTPBsOdnsnAS8P4PtYXT3dNJD1o46GlauPSy22Qy
uE3SDQjMygcYxwdMsatzQdqwuDRdX12YwG+9Yr3y46KYjGdYWAc/zFbTIVwv
bVNiKgKpmWjMd8Jgu82baRPAHtlmzc4rO2waIE1usaSYKZyYlAgPFk6fdkBB
QKw8NtgMoo2flE0h8VOXAuQhtg7Db02LpcsE9Vyfn1nAn88wNpIgnmAYZNMw
VjumHadtl2G0YI8xDNampGEYWMvqynqxws+Qxtr5rH5i23w+Gze0f/GrcEMP
c0OP4IYexw1vU7KbmxhuXNzDAAGuIyzXtcsmdumWZ1vEV2nGdKQySYYZ/ng7
tfzrU8uaO44nUMsOU8uOoJYdR61oU9JCrXC3nWjnRrRyc2hfi+m0nx+xRQag
Z78VXfjaNRvwLrR2UDBITFme6uHQPoDDho1ljHeSZRnlkehtZEfa0KCPNNji
o39P5oj6k5fD7Fg8ZhqaOl3u/9G/yGZABO6EC/87GK759Jc0G07iGZ7F8v3B
HQnDHQl1OxKqDm7QWWMlaU/8rIc7eujcgrkADZ/AdDrYiNmf/hn0cG6q3l/3
qbrx/cvLj59e97MsdInh+EGPRvhLvDalPdnydR+LZ2+8M3fvpJlJceySToRf
f/kDObdmhzX4mMEwma6mnXK//BDfZat5ANJYko3pVmYHDdJ8U5o9SZo/SVrs
k35EpHU7ivm/Dm5teuY+hrUuSzHprXdxfdUnHXPnMQ7z/v764w99rG3lCaGS
klHKRtHN4UuQT5qAvdLonPvvrky+cIqrApooeMi+85SPdZk39Kkd+v6ftwFP
GYM8gTHwExiDPoExiBMYA/vqY8C0q1MYBD2FQfBTGIQ8hUGoUxhEdBKGSX6l
UXzNB+sb+1oefJWQhOLOLx7iOV6fOU4H0ythQn5aTHI8r6TXoX62Bvll0cMQ
wSIvil4pWWuKtGThlqZpSjYUsV2KrODhTZ7ed0FYimVK2f92ddl8N+OfYUbm
eJGvsHhzijljr+n54c7oN7ujfJrVqH3StsbE1BWu5q8wz/9yODcHIN2POulq
fp+twTWYx3jWGnlDf+tZFl9xnn7DWZ4sQ10e2fDxH6Gm7J2puLAp9QwPpqgK
L+ThvvSTRhru9U/MWTRk7ap7sXbOFR2aopt7PLojW4MzbYqMmjB3oNhJaKgq
Ke2UxzNTUskDiXnd83twrZelIx03fGMSkKBZtlm+1JnM/PtsHMM0Tc1ZViMX
uRqCS4vvWliwrsV+WtkYD/b4T9bSDT5ucp+ubfrtY2XpDtmDdEf7jaX6M36/
6DDBN27nvSsXuqZmiX6IF3hAm3n9FAlJlSYqFEzg7FTfqY6siHuKLk2lL/4h
hPNI4mGb4O9ufA88eKrM0i6ToeibE5Nuev7F9XtkZZwtB9N8li/z2SQZmHrh
wbLACbMh2S52Yf7lozT+EiQ9ppjn978Dd5gOs1H2/Y0/GOA5cYNPf/8zWcus
i9VB/ll47lBcUYKo3T2BCBMowxIQEpUUjSRPQSrJ518G7sAywAoKC+Z6RLED
UWEVISPAmlA3nvOyjIs7HMsIsBqgeGSFg8aUDQGa5oNRvkCQGnZNwZB/psrO
OYdJk+bCyupRAHIluwjHI6aqronmhFl9QEkCVj1YLuIE8TRlpWZe9U9oNEQ8
gHEKZkYx4gSqra6esDRNLczoxH+A1AAcwuWo8912o0LJVaikAo6M4dQNnLVZ
jsFwyjRXChMuNhsCb5nPu5wR/a1YThQmKUqt5ti3CbgaA0I8wtMN2xFgEki1
OQBgABtU2MOWVKK9SSfBmvqHZLd+UoJJBVZaIBgBqN3i0TpiBDNJLJ0lWsY7
0RW2vkzFk0wB9vOoKFFD1TXVZQCrUIJo6uzNoQR1d0XDiveaG176TnOD5QmP
syZCUx2iuVUNKtS8xdwQoxQsZ1EUYibUZkPgPQDbYG+SfCv2xtIkMaTlxWQ9
uDNGgRqMBBJHm2sLLMo6QrgBLgxykZVQ1uQOFes2xdoprpc2lqVC1EsLjHmM
uRJTXGK0AHjUVH6AcnLefLDNb+MiW3c41aK5n9dHP9goHm4nFKU8UoKaAtq6
hUWqxWYMiEcRo+BhRWg0my0vi9TLItW2SHEmQqYiTmHzw7XJJKpbGCctJmdB
isAFEY5ZelstzuQ0ky8m92Jy2yanoQPFJIybKWtyVQtsLltNDkGwDgp4ejJr
cs2WwBvGxW2XRdHvchfPBdNDMw58UzVYQD+rZbZGm8AtOj9+H//I3blUz7M7
5zIiMmJKMDBZZsyibuGs7eFnQKGWGIOMzMNvsyXwyH0+fsDEzy4Pifxdenh7
6A7J6dKtwI8k4MRrXdLtWtr3OhZEQ0OuKumuWwIP1gABH194Ph2etYqogHuP
qJJn18Ip38OzVjxCVkNZ8ly3OJ55+MLzyfDMgBsRkVAK4XguWzjfwzMLIymA
VUa147nREnhT8JgebuPlpAjwPV0X/GH6Qvqzk+783cUyGVgftsPhEduMT+x9
7f9fX1dHpilsAAA=

--8323328-472154353-1130364424=:20155--
