Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262762AbTKEJTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 04:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTKEJTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 04:19:06 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:64130 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262762AbTKEJTC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 04:19:02 -0500
Message-ID: <3FA8C07E.4050703@cyberone.com.au>
Date: Wed, 05 Nov 2003 20:18:54 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Aaron Lehmann <aaronl@vitelus.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: Badness in as_completed_request
References: <20031105085817.GH21853@vitelus.com>
In-Reply-To: <20031105085817.GH21853@vitelus.com>
Content-Type: multipart/mixed;
 boundary="------------040408050105070507090905"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040408050105070507090905
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

   

Aaron Lehmann wrote:

>I've been seeing this about every day for the past month or so, while
>tracking 2.6.0-test*. Usually by the time I feel like reporting it I'm
>a few revisions behind and decide to upgrade before complaining about
>it. Now I'm running -test9 and it still happens. This happens every
>few day or so under normal load and every few minutes under high I/O
>load. I'm running an x86 system with a 3ware RAID5:
>
>Badness in as_completed_request at drivers/block/as-iosched.c:919
>

This warning is harmless. Here is a patch against 2.6.0-test9-mm2.
Please test that kernel as it has a few other important as-iosched
fixes. Thanks.


--------------040408050105070507090905
Content-Type: text/plain;
 name="as-warn-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="as-warn-fix.patch"

 linux-2.6-npiggin/drivers/block/as-iosched.c |    2 --
 1 files changed, 2 deletions(-)

diff -puN drivers/block/as-iosched.c~as-warn-fix drivers/block/as-iosched.c
--- linux-2.6/drivers/block/as-iosched.c~as-warn-fix	2003-11-05 20:16:42.000000000 +1100
+++ linux-2.6-npiggin/drivers/block/as-iosched.c	2003-11-05 20:16:58.000000000 +1100
@@ -965,8 +965,6 @@ static void as_completed_request(request
 		return;
 
 	if (ad->changed_batch && ad->nr_dispatched == 1) {
-		WARN_ON(ad->batch_data_dir == arq->is_sync);
-
 		kblockd_schedule_work(&ad->antic_work);
 		ad->changed_batch = 0;
 

_

--------------040408050105070507090905--

