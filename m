Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTFLBSQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 21:18:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264682AbTFLBSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 21:18:16 -0400
Received: from dyn-ctb-210-9-241-68.webone.com.au ([210.9.241.68]:19716 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S264679AbTFLBSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 21:18:06 -0400
Message-ID: <3EE7D7F5.3070803@cyberone.com.au>
Date: Thu, 12 Jun 2003 11:31:33 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Robert Love <rml@tech9.net>, bos@serpentine.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] as-iosched divide by zero fix
References: <1055369849.1084.4.camel@serpentine.internal.keyresearch.com>	<20030611154122.55570de0.akpm@digeo.com>	<1055374476.673.1.camel@localhost>	<1055377120.665.6.camel@localhost>	<20030611172444.76556d5d.akpm@digeo.com>	<1055380257.662.8.camel@localhost> <20030611182249.0f1168e4.akpm@digeo.com>
In-Reply-To: <20030611182249.0f1168e4.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>Robert Love <rml@tech9.net> wrote:
>
>>Fix as-iosched divide-by-zero bug.
>>
>
>hrm, OK.  Still not convinced about `batch'.
>
>How about this?
>

Yeah, thats the way to do it, of course. It was too
jumpy at that setting though, so make it batch*3
(or <<1+batch if you don't want the multiply).

>
>--- 25/drivers/block/as-iosched.c~as-div-by-zero-fix	2003-06-11 18:17:04.000000000 -0700
>+++ 25-akpm/drivers/block/as-iosched.c	2003-06-11 18:20:58.000000000 -0700
>@@ -930,13 +930,12 @@ void update_write_batch(struct as_data *
> 		write_time = 0;
> 
> 	if (write_time > batch + 5 && !ad->write_batch_idled) {
>-		if (write_time / batch > 2)
>+		if (write_time > batch * 2)
> 			ad->write_batch_count /= 2;
> 		else
> 			ad->write_batch_count--;
>-		
> 	} else if (write_time + 5 < batch && ad->current_write_count == 0) {
>-		if (batch / write_time > 2)
>+		if (batch > write_time * 2)
> 			ad->write_batch_count *= 2;
> 		else
> 			ad->write_batch_count++;
>
>_
>
>
>  
>

