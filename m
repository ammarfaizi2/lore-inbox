Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVIQQlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVIQQlb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 12:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbVIQQlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 12:41:31 -0400
Received: from [212.76.84.20] ([212.76.84.20]:52996 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751143AbVIQQla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 12:41:30 -0400
From: Al Boldi <a1426z@gawab.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Eradic disk access during reads
Date: Sat, 17 Sep 2005 19:38:34 +0300
User-Agent: KMail/1.5
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509171323.53054.a1426z@gawab.com> <200509171344.16564.vda@ilport.com.ua>
In-Reply-To: <200509171344.16564.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200509171918.17658.a1426z@gawab.com>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> > > > Monitoring disk access using gkrellm, I noticed that a command like
> > > >
> > > > cat /dev/hda > /dev/null
> > > >
> > > > shows eradic disk reads ranging from 0 to 80MB/s on an otherwise
> > > > idle system.
> > > >
> > > > 1. Is this a hardware or software problem?
> > >
> > > Difficult to tell without more info. Can be a broken IDE disk or
> > > defective ribbon.
> >
> > Tried the same with 2.4.31 which shows steady behaviour with occasional
> > dips and pops in the msec range.
> >
> > > > 2. Is there a lightweight perf-mon tool (cmd-line) that would log
> > > > this behaviour graphically?
>
> Try attached one.

Nice!

> # dd if=/dev/hda of=/dev/null bs=16M

This is what I got; what do you get?

Thanks!

2.4.31 # nmeter t6 c x i b d100
18:56:36.009981 cpu [SSSSSSSS..] ctx  145 int   86 bio 4.7M    0
18:56:36.110327 cpu [SSSSSSSS..] ctx  145 int   87 bio 4.8M    0
18:56:36.210735 cpu [SSSSSSSS..] ctx  139 int   88 bio 4.7M    0
18:56:36.310315 cpu [SSSSSSSS..] ctx  142 int   85 bio 4.7M    0
18:56:36.409979 cpu [SSSSSS....] ctx  147 int   86 bio 4.7M    0
18:56:36.510764 cpu [SSSSSSSSS.] ctx  161 int   88 bio 4.8M    0
18:56:36.610213 cpu [SSSSSSSS..] ctx  165 int   85 bio 4.7M    0
18:56:36.710194 cpu [SSSSSSSSS.] ctx  152 int   89 bio 4.7M 4096
18:56:36.809977 cpu [SSSSSSS...] ctx  135 int   86 bio 4.7M    0
18:56:36.909970 cpu [SSSSSSS...] ctx  142 int   89 bio 4.7M  16k
18:56:37.009972 cpu [SSSSS.....] ctx  130 int   86 bio 4.7M    0
18:56:37.109979 cpu [SSSSS.....] ctx  142 int   86 bio 4.7M    0
18:56:37.210335 cpu [SSSSSSSS..] ctx  135 int   87 bio 4.8M    0
18:56:37.309973 cpu [SSSSS.....] ctx  100 int   68 bio 3.5M    0
18:56:37.410011 cpu [SSSSSSS...] ctx  146 int   87 bio 4.7M    0
18:56:37.509980 cpu [SSSSSSS...] ctx  145 int   86 bio 4.8M    0
18:56:37.610117 cpu [SSSSSSS...] ctx  137 int   87 bio 4.7M    0
18:56:37.709978 cpu [SSSSSSSSS.] ctx  133 int   87 bio 4.7M    0
18:56:37.809981 cpu [SSSSSSSS..] ctx  146 int   87 bio 4.8M    0
18:56:37.909972 cpu [SSSSS.....] ctx  139 int   86 bio 4.7M    0
18:56:38.010504 cpu [SSSSSS....] ctx  149 int   87 bio 4.7M    0
18:56:38.110025 cpu [SSSSSSS...] ctx  136 int   87 bio 4.7M    0
18:56:38.210122 cpu [SSSSSSS...] ctx  137 int   85 bio 4.7M    0
18:56:38.309975 cpu [SSSSSSS...] ctx  141 int   87 bio 4.7M    0
18:56:38.410095 cpu [SSSSSSSS..] ctx  138 int   86 bio 4.8M    0
18:56:38.509978 cpu [SSSSS.....] ctx  145 int   87 bio 4.7M    0
18:56:38.610115 cpu [SSSSS.....] ctx  145 int   86 bio 4.7M    0
18:56:38.710204 cpu [SSSSSSSS..] ctx  141 int   87 bio 4.7M    0
18:56:38.811411 cpu [SSSSSSS...] ctx  128 int   88 bio 4.8M    0
18:56:38.911221 cpu [SSSSSSSS..] ctx  131 int   86 bio 4.7M    0
18:56:39.010779 cpu [SSSSSSSS..] ctx  127 int   86 bio 4.7M    0
18:56:39.110211 cpu [SSSSS.....] ctx  127 int   86 bio 4.7M    0
18:56:39.210086 cpu [SSSSSSSSS.] ctx  131 int   86 bio 4.7M    0
18:56:39.313572 cpu [SSSSSSS...] ctx  137 int   90 bio 5.0M    0
18:56:39.410307 cpu [SSSSSSS...] ctx  139 int   84 bio 4.6M    0
18:56:39.510618 cpu [SSSSSSSSS.] ctx  131 int   85 bio 4.7M    0
18:56:39.610558 cpu [SSSSSSSS..] ctx  144 int   87 bio 4.7M    0
18:56:39.709981 cpu [SSSS......] ctx  141 int   86 bio 4.7M    0
18:56:39.810109 cpu [SSSSSSS...] ctx  139 int   86 bio 4.7M    0
18:56:39.910581 cpu [SSSSSSS...] ctx  144 int   87 bio 4.8M    0
18:56:40.010554 cpu [SSSSSSSSS.] ctx  144 int   87 bio 4.7M    0
18:56:40.110382 cpu [SSSSSSSS..] ctx  143 int   86 bio 4.7M    0
18:56:40.210709 cpu [SSSSSSSSS.] ctx  138 int   87 bio 4.8M    0
18:56:40.310512 cpu [SSSS......] ctx  144 int   86 bio 4.7M    0
18:56:40.410830 cpu [SSSSSSS...] ctx  147 int   87 bio 4.7M    0
18:56:40.510371 cpu [SSSSSSSS..] ctx  160 int   86 bio 4.7M    0
18:56:40.610664 cpu [SSSSSSSS..] ctx  170 int   87 bio 4.8M    0
18:56:40.710106 cpu [SSSSSSS...] ctx  149 int   87 bio 4.7M    0
18:56:40.810056 cpu [SSSSSSSS..] ctx  141 int   85 bio 4.6M    0
18:56:40.910416 cpu [SSSSSSS...] ctx  138 int   86 bio 4.8M    0
18:56:41.009974 cpu [SSSSSS....] ctx  142 int   87 bio 4.7M    0
18:56:41.110094 cpu [SSSSSS....] ctx  142 int   86 bio 4.7M    0
18:56:41.209972 cpu [SSSSSSSS..] ctx  139 int   87 bio 4.7M    0
18:56:41.310140 cpu [SSSSSSSS..] ctx  135 int   88 bio 4.8M    0

2.6.13 # nmeter t6 c x i b d100
18:09:22.117959 cpu [SSSSSSSSSD] ctx   80 int   47 bio 4.7M    0
18:09:22.217932 cpu [SSSSSSDDDD] ctx   83 int   48 bio 4.8M    0
18:09:22.319200 cpu [SSSSDDDDDI] ctx   81 int   56 bio 4.7M  28k
18:09:22.407979 cpu [SSSSSSSSSD] ctx   60 int   38 bio 3.8M    0
18:09:22.517960 cpu [SSSSSSSSDI] ctx   95 int   61 bio 5.2M  52k
18:09:22.617942 cpu [SSSSSSSSSD] ctx   77 int   47 bio 4.7M    0
18:09:22.718043 cpu [SSSSSDDDDD] ctx   81 int   48 bio 4.8M    0
18:09:22.817976 cpu [SSSSDDDDDD] ctx   80 int   48 bio 4.6M    0
18:09:22.918080 cpu [SSSSSSSDDI] ctx   80 int   48 bio 4.8M    0
18:09:23.017975 cpu [SSSSSSSSDD] ctx   80 int   47 bio 4.7M    0
18:09:23.117912 cpu [SSSSDDDDDD] ctx   36 int   25 bio 3.1M    0
18:09:23.217943 cpu [SSSSDDDDDD] ctx   44 int   29 bio 2.7M    0
18:09:23.317949 cpu [SSSSSSSDDD] ctx   80 int   47 bio 4.8M    0
18:09:23.417944 cpu [SSSSSSSSDI] ctx   84 int   49 bio 4.7M    0
18:09:23.517944 cpu [SSSSSSSSDD] ctx   78 int   47 bio 4.7M    0
18:09:23.617948 cpu [SSSSDDDDDD] ctx   67 int   42 bio 4.5M 8192
18:09:23.718238 cpu [SSSSDDDDDD] ctx   80 int   48 bio 4.7M    0
18:09:23.818039 cpu [SSSSSSSDDI] ctx   79 int   48 bio 4.7M    0
18:09:23.917961 cpu [SSSSSSSSDD] ctx   80 int   49 bio 4.7M    0
18:09:24.019101 cpu [SSSSSSSDDD] ctx   80 int   48 bio 4.8M    0
18:09:24.107934 cpu [SSSSSSSDII] ctx   71 int   42 bio 4.2M    0
18:09:24.217946 cpu [SSSSDDDDDD] ctx   90 int   53 bio 5.2M    0
18:09:24.317965 cpu [SSSSSSDDDI] ctx   83 int   49 bio 4.7M    0
18:09:24.417974 cpu [SSSSSSSSDD] ctx   78 int   46 bio 4.6M    0
18:09:24.517938 cpu [SSSSDDDDDD] ctx   48 int   30 bio 3.7M    0
18:09:24.617940 cpu [SSSDDDDDDD] ctx   80 int   48 bio 4.7M    0
18:09:24.717948 cpu [SSSSSSSDDI] ctx   79 int   48 bio 4.7M    0
18:09:24.817955 cpu [SSSSSSSSDI] ctx   82 int   49 bio 4.7M    0
18:09:24.917914 cpu [SSSSDDDDDD] ctx   31 int   21 bio 2.7M    0
18:09:25.018051 cpu [SSSDDDDDDD] ctx   31 int   23 bio 2.7M    0
18:09:25.117988 cpu [SSSSSSDDII] ctx   81 int   49 bio 4.8M    0
18:09:25.217970 cpu [SSSSSDDDDD] ctx   37 int   24 bio 3.1M    0
18:09:25.318115 cpu [SSSSSSSSDD] ctx   81 int   48 bio 4.8M    0
18:09:25.417959 cpu [SSSSSSSSDD] ctx   81 int   47 bio 4.7M    0
18:09:25.517943 cpu [SSSSSSDDDD] ctx   65 int   41 bio 4.3M    0
18:09:25.617959 cpu [SSSSDDDDDD] ctx   80 int   48 bio 4.7M    0
18:09:25.717945 cpu [SSSSSSSDDD] ctx   81 int   47 bio 4.8M    0
18:09:25.817979 cpu [SSSSSSSSDI] ctx   79 int   49 bio 4.6M    0
18:09:25.917913 cpu [SSSSDDDDDD] ctx   30 int   21 bio 2.7M    0
18:09:26.017940 cpu [SSSSDDDDDD] ctx   64 int   39 bio 3.7M    0
18:09:26.118932 cpu [SSSSDDDDDI] ctx   79 int   49 bio 4.7M    0
18:09:26.217959 cpu [SSSSSDDDDD] ctx   43 int   26 bio 3.3M    0
18:09:26.317948 cpu [SSSSSDDDDD] ctx   64 int   38 bio 4.1M    0
18:09:26.417962 cpu [SSSSSSSSDD] ctx   78 int   47 bio 4.7M    0
18:09:26.517958 cpu [SSSSDDDDDD] ctx   27 int   20 bio 2.2M    0
18:09:26.617978 cpu [SSSDDDDDDD] ctx   24 int   18 bio 1.6M    0
18:09:26.717966 cpu [SSSSSDDDDI] ctx   76 int   45 bio 4.5M    0
18:09:26.817963 cpu [SSSSSSDDDI] ctx   62 int   37 bio 4.0M    0
18:09:26.917972 cpu [SSSSSDDDDD] ctx   69 int   40 bio 4.3M    0
18:09:27.017971 cpu [SSSSSSSDDD] ctx   78 int   47 bio 4.7M    0
18:09:27.117942 cpu [SDDDDDDDDD] ctx   40 int   25 bio 3.3M    0
18:09:27.217949 cpu [SSSSSSSSDI] ctx   69 int   42 bio 4.2M    0
18:09:27.318990 cpu [SSSSSSSSDI] ctx   84 int   48 bio 4.8M    0
18:09:27.417950 cpu [SSSSSSSSSI] ctx   79 int   47 bio 4.6M    0
18:09:27.518161 cpu [SSSSSSSSDI] ctx   79 int   47 bio 4.8M 8192
18:09:27.617941 cpu [SSSSSSSDDD] ctx   87 int   51 bio 4.7M  24k

