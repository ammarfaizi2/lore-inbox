Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261423AbUBTWno (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 17:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbUBTWl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 17:41:27 -0500
Received: from mail-07.iinet.net.au ([203.59.3.39]:53441 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261408AbUBTWkq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 17:40:46 -0500
Message-ID: <40368CE9.9030807@cyberone.com.au>
Date: Sat, 21 Feb 2004 09:40:41 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: John Chatelle <johnch@medent.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: High read Latency test (Anticipatory I/O scheduler)
References: <20040220202023.M9162@medent.com>
In-Reply-To: <20040220202023.M9162@medent.com>
Content-Type: multipart/mixed;
 boundary="------------050303040703000703030501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050303040703000703030501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



John Chatelle wrote:

>   I haven't seen much duplicated results regarding the Robert Love article 
>in the February 2004 Linux Journal article, also reachable in the hyperlink:
>          http://www.linuxjournal.com/article.php?sid=6931
>
> Although the 1st simple test: "Write starved reads" gets results comparable
>to the results reported in the Article, Our results for the 2nd test: "High 
>Read latency" delivers results opposite our expectations...
>
>

Hi John,
Can you try the following patch please? If that doesn't help, can you
show me what /sys/block/hda/queue/iosched/est_time says after your
test has been running for a couple of minutes.

Thanks
Nick


--------------050303040703000703030501
Content-Type: text/plain;
 name="as-exit-prob.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-exit-prob.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN drivers/block/as-iosched.c~as-exit-prob drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-exit-prob	2004-02-21 09:38:54.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2004-02-21 09:39:22.000000000 +1100
@@ -734,8 +734,10 @@ static int as_can_break_anticipation(str
 	if (aic->ttime_samples == 0) {
 		if (ad->new_ttime_mean > ad->antic_expire)
 			return 1;
+#if 0
 		if (ad->exit_prob > 128)
 			return 1;
+#endif
 	} else if (aic->ttime_mean > ad->antic_expire) {
 		/* the process thinks too much between requests */
 		return 1;

_

--------------050303040703000703030501--
