Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267545AbUIUOhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267545AbUIUOhW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267696AbUIUOhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:37:22 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:37527 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S267545AbUIUOhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:37:20 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: journal aborted, system read-only
Date: Tue, 21 Sep 2004 10:37:18 -0400
User-Agent: KMail/1.7
Cc: Andrew Morton <akpm@osdl.org>, sct@redhat.com
References: <200409121128.39947.gene.heskett@verizon.net> <20040921015020.7372faac.akpm@osdl.org> <20040921025356.38b2b550.akpm@osdl.org>
In-Reply-To: <20040921025356.38b2b550.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409211037.18840.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [141.153.127.192] at Tue, 21 Sep 2004 09:37:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 05:53, Andrew Morton wrote:
>Andrew Morton <akpm@osdl.org> wrote:
>> This should fix.
>
>scrub that, it hangs.  Third time lucky.
>
Stopped "makeit", patch this up by hand, started again.  Thanks 
Andrew.

>--- 25/kernel/wait.c~wait_on_bit-must-loop 2004-09-21
> 01:57:14.000000000 -0700 +++ 25-akpm/kernel/wait.c 2004-09-21
> 02:48:18.596420024 -0700 @@ -157,7 +157,7 @@
> __wait_on_bit(wait_queue_head_t *wq, str int ret = 0;
>
>  prepare_to_wait(wq, &q->wait, mode);
>- if (test_bit(q->key.bit_nr, q->key.flags))
>+ while (test_bit(q->key.bit_nr, q->key.flags) && !ret)
>   ret = (*action)(q->key.flags);
>  finish_wait(wq, &q->wait);
>  return ret;
>_

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.26% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
