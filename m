Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030612AbWBODTF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030612AbWBODTF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 22:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030615AbWBODTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 22:19:05 -0500
Received: from smtp102.mail.mud.yahoo.com ([209.191.85.212]:41600 "HELO
	smtp102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030614AbWBODTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 22:19:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=k0ondqwRz0/3Gf+5/cpWxdriQT23KH23KRlbYa7O0mTROnubAoNLOMHVDH8WuPk4lRqmzoMrgzmGblq7sWPJ/DGwPYgVWw+9qd48Oci8fdog9GR65CMrsMwyDB0fHlata1h2DnD0hgG3iiFalubBClbmR3pFsgNAVjcTViJpIKM=  ;
Message-ID: <43F29B84.6020009@yahoo.com.au>
Date: Wed, 15 Feb 2006 14:09:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Coywolf Qi Hunt <coywolf@gmail.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, christoph@lameter.com
Subject: Re: + vmscan-rename-functions.patch added to -mm tree
References: <200602120605.k1C65QFE028051@shell0.pdx.osdl.net> <2cd57c900602141847m7af4ec7ap@mail.gmail.com>
In-Reply-To: <2cd57c900602141847m7af4ec7ap@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> 2006/2/12, akpm@osdl.org <akpm@osdl.org>:
> 
>>The patch titled
>>
>>     vmscan: rename functions
>>
>>has been added to the -mm tree.  Its filename is
>>
>>     vmscan-rename-functions.patch
>>
>>See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
>>out what to do about this
>>
>>
>>From: Andrew Morton <akpm@osdl.org>
>>
>>We have:
>>
>>        try_to_free_pages
>>        ->shrink_caches(struct zone **zones, ..)
>>          ->shrink_zone(struct zone *, ...)
>>            ->shrink_cache(struct zone *, ...)
>>              ->shrink_list(struct list_head *, ...)
>>
>>which is fairly irrational.
>>
>>Rename things so that we have
>>
>>        try_to_free_pages
>>        ->shrink_zones(struct zone **zones, ..)
>>          ->shrink_zone(struct zone *, ...)
>>            ->do_shrink_zone(struct zone *, ...)
>>              ->shrink_page_list(struct list_head *, ...)
> 
> 
> Every time I read this part it annoys me. Thanks.

I don't much care, but if there is renaming afoot, I'd vote for

->shrink_zones(struct zone **zones, ..)
  ->shrink_zone(struct zone *, ...)
   ->shrink_inactive_list(struct zone *, ...)
    ->shrink_page_list(struct list_head *, ...)
   ->shrink_active_list (alternatively, leave as refill_inactive_list)

shrink_zone and do_shrink_zone don't really say any more to me than
shrink_zone and shrink_cache.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
