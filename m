Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWBEIqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWBEIqE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 03:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWBEIqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 03:46:04 -0500
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:43459 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S964823AbWBEIqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 03:46:01 -0500
Message-ID: <43E5BB2E.5000203@namesys.com>
Date: Sun, 05 Feb 2006 00:45:34 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       LKML <linux-kernel@vger.kernel.org>,
       fsdevel <linux-fsdevel@vger.kernel.org>, lee.schermerhorn@hp.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Fw: Re: [PATCH] 2.6.16-rc-mm4 reiser4 calls try_to_unmap() with
 1 arg -- now takes 2
References: <20060205003039.3067e43c.akpm@osdl.org>
In-Reply-To: <20060205003039.3067e43c.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm, no, copy on capture needs to get enabled again as soon as we get
past issues outsiders care about, and start dealing again with improving
the code in the ways we think matter.  There are real problems that are
addressed by copy on capture.  That it has not been worked on since
2.6.5 just sadly indicates how successful folks have been in distracting
us for so long.

vs, open a bug report in bugzilla for copy on capture, and after we get
merged please make copy on capture work. 

Hans

Andrew Morton wrote:

>Hugh's right - quite worrying..
>
>Begin forwarded message:
>
>Date: Thu, 2 Feb 2006 20:46:07 +0000 (GMT)
>From: Hugh Dickins <hugh@veritas.com>
>To: Lee Schermerhorn <lee.schermerhorn@hp.com>
>Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
>Subject: Re: [PATCH] 2.6.16-rc-mm4 reiser4 calls try_to_unmap() with 1 arg -- now takes 2
>
>
>On Thu, 2 Feb 2006, Lee Schermerhorn wrote:
>
>  
>
>>Apparent race between reiser4 and direct migration patches in 16-rc1-
>>mm4.
>>Direct migration added arg to rmap.c:try_to_unmap()--int ignore_refs--
>>and
>>fixed up existing refs.  reiser4 adds new call with single arg. 
>>
>>One doesn't see this when building mm4 w/ reiser4 because the ref under
>>an
>>"#if REISER4_COPY_ON_CAPTURE" that is apparently not enabled.  I  just
>>noticed
>>it while looking at direct migration patches.  So, this patch is
>>essentially
>>UNTESTED.  Supplied simply to illustrate the location of the single arg
>>    
>>
>
>That's worrying code to find down in a filesystem.  But never mind,
>it refers to pte_chain_lock(), which hasn't existed since 2.6.5.  So
>REISER4_COPY_ON_CAPTURE is long untested and should just be deleted.
>
>Hugh
>
>  
>
>>Signed-off-by: Lee Schermerhorn <lee.schermerhorn@hp.com>
>>
>>Index: linux-2.6.16-rc1-mm4/fs/reiser4/txnmgr.c
>>===================================================================
>>--- linux-2.6.16-rc1-mm4.orig/fs/reiser4/txnmgr.c	2006-01-31
>>16:51:39.000000000 -0500
>>+++ linux-2.6.16-rc1-mm4/fs/reiser4/txnmgr.c	2006-02-02
>>14:43:01.659744418 -0500
>>@@ -3693,7 +3693,7 @@ static int create_copy_and_replace(jnode
>> 		pte_chain_lock(page);
>> 
>> 		if (page_mapped(page)) {
>>-			result = try_to_unmap(page);
>>+			result = try_to_unmap(page, 0);
>> 			if (result == SWAP_AGAIN) {
>> 				result = RETERR(-E_REPEAT);
>>    
>>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

