Return-Path: <linux-kernel-owner+w=401wt.eu-S1754143AbWLRPZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbWLRPZz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754145AbWLRPZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:25:55 -0500
Received: from vms048pub.verizon.net ([206.46.252.48]:14801 "EHLO
	vms048pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbWLRPZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:25:54 -0500
Date: Mon, 18 Dec 2006 10:24:18 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 2.6.19 file content corruption on ext3
In-reply-to: <1166438986.7003.1.camel@localhost>
To: linux-kernel@vger.kernel.org, andrei.popa@i-neo.ro
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Florian Weimer <fw@deneb.enyo.de>,
       Marc Haber <mh+linux-kernel@zugschlus.de>,
       Martin Michlmayr <tbm@cyrius.com>
Message-id: <200612181024.18829.gene.heskett@verizon.net>
Organization: Not detectable
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1166314399.7018.6.camel@localhost>
 <1166436717.10372.58.camel@twins> <1166438986.7003.1.camel@localhost>
User-Agent: KMail/1.9.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 05:49, Andrei Popa wrote:
>> OK, I'll try this on a ext3 box. BTW, what data mode are you using
>> ext3 in?
>
>ordered
>
>> Also, for testings sake, could you give this a go:
>> It's a total hack but I guess worth testing.
>>
>> ---
>>  mm/rmap.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Index: linux-2.6-git/mm/rmap.c
>> ===================================================================
>> --- linux-2.6-git.orig/mm/rmap.c	2006-12-18 11:06:29.000000000 +0100
>> +++ linux-2.6-git/mm/rmap.c	2006-12-18 11:07:16.000000000 +0100
>> @@ -448,7 +448,7 @@ static int page_mkclean_one(struct page
>>  		goto unlock;
>>
>>  	entry = ptep_get_and_clear(mm, address, pte);
>> -	entry = pte_mkclean(entry);
>> +	/* entry = pte_mkclean(entry); */
>>  	entry = pte_wrprotect(entry);
>>  	ptep_establish(vma, address, pte, entry);
>>  	lazy_mmu_prot_update(entry);
>
>with latest git and this patch there is no corruption !
>
I've not run a torrent app here recently.  Should this patch be applied to 
a plain 2.6-20-rc1 before I do run azureas or similar apps?
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
