Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbVIRNnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbVIRNnk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 09:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbVIRNnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 09:43:40 -0400
Received: from [212.76.84.86] ([212.76.84.86]:57604 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751229AbVIRNnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 09:43:39 -0400
From: Al Boldi <a1426z@gawab.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Subject: Re: Eradic disk access during reads
Date: Sun, 18 Sep 2005 16:40:19 +0300
User-Agent: KMail/1.5
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org
References: <200509170717.03439.a1426z@gawab.com> <200509171918.17658.a1426z@gawab.com> <200509181400.27004.vda@ilport.com.ua>
In-Reply-To: <200509181400.27004.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509181640.19984.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Saturday 17 September 2005 19:38, Al Boldi wrote:
> > > # dd if=/dev/hda of=/dev/null bs=16M
> > 2.4.31 # nmeter t6 c x i b d100
> > 18:56:36.009981 cpu [SSSSSSSS..] ctx  145 int   86 bio 4.7M    0
> > 18:56:36.110327 cpu [SSSSSSSS..] ctx  145 int   87 bio 4.8M    0
> > 18:56:36.210735 cpu [SSSSSSSS..] ctx  139 int   88 bio 4.7M    0
> > 18:56:36.310315 cpu [SSSSSSSS..] ctx  142 int   85 bio 4.7M    0
> >
> > 2.6.13 # nmeter t6 c x i b d100
> > 18:09:22.117959 cpu [SSSSSSSSSD] ctx   80 int   47 bio 4.7M    0
> > 18:09:22.217932 cpu [SSSSSSDDDD] ctx   83 int   48 bio 4.8M    0
> > 18:09:22.319200 cpu [SSSSDDDDDI] ctx   81 int   56 bio 4.7M  28k
> > 18:09:22.407979 cpu [SSSSSSSSSD] ctx   60 int   38 bio 3.8M    0
> > 18:09:22.517960 cpu [SSSSSSSSDI] ctx   95 int   61 bio 5.2M  52k
>
> Well, I do not see any bursts you mention...

Can you try 2.4.31?

> Anyway, my data:
> 13:52:09.201450 cpu [SSSSSSDDII] ctx   34 int  142 bio 4.1M    0
> 13:52:09.301176 cpu [SSSSSSSDDI] ctx   39 int  138 bio 3.8M    0
> 13:52:09.401806 cpu [SSSSSSSSDI] ctx   55 int  157 bio 4.3M    0
> 13:52:09.501077 cpu [SSSSDDDDDI] ctx   32 int  121 bio 2.2M    0
> 13:52:09.601067 cpu [SSSDDDDDDD] ctx   24 int  127 bio 1.7M    0
> 13:52:09.701108 cpu [SSSSSSSDDI] ctx   50 int  153 bio 4.1M    0
> 13:52:09.802156 cpu [SSSSDDDDII] ctx   34 int  139 bio 2.7M    0
> 13:52:09.902026 cpu [SSSSSSSSDD] ctx   44 int  152 bio 4.0M    0
> 13:52:10.002041 cpu [SSSSDDDDDI] ctx   39 int  126 bio 2.2M    0
> 13:52:10.100997 cpu [SSSSDDDDDI] ctx   46 int  129 bio 2.7M    0
> 13:52:10.201964 cpu [SSSSSSSDDI] ctx   57 int  139 bio 3.6M    0
> 13:52:10.303468 cpu [SSSSDDDDDI] ctx   34 int  133 bio 2.2M    0
> 13:52:10.401523 cpu [SSSSSSSDDI] ctx   50 int  145 bio 3.6M 4096
> 13:52:10.500934 cpu [SSSSSSSSII] ctx   66 int  139 bio 4.1M    0

Does not look smooth.

> /dev/hda:
>  UDMA modes: udma0 udma1 udma2 udma3 udma4 *udma5

same here.

> My CPU is not that new:

PII - 400Mhz here.

> hdc (an old disk):
> 13:52:40.201718 cpu [SSSDDDDDDD] ctx   26 int  112 bio 1.2M    0
> 13:52:40.301569 cpu [SSDDDDDDDD] ctx   28 int  109 bio 1.2M    0
> 13:52:40.402552 cpu [SSDDDDDDDI] ctx   23 int  111 bio 1.2M    0
> 13:52:40.502535 cpu [SSDDDDDDDD] ctx   22 int  110 bio 1.2M    0
> 13:52:40.601507 cpu [SSDDDDDDDI] ctx   26 int  111 bio 1.2M    0
> 13:52:40.701493 cpu [SSDDDDDDDD] ctx   23 int  110 bio 1.2M    0

Looks smooth.

Also, great meter!  Best of all does not hog the CPU!
Could you add a top3 procs display?

Thanks!

--
Al

