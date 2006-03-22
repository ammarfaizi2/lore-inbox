Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWCVExt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWCVExt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 23:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWCVExt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 23:53:49 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:32933 "HELO
	smtp106.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750763AbWCVExs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 23:53:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Ody2BFxNeb0CMv1ZQMUTThNd2JeaJUXttvZZ9vrZ9VS/+91nukiLeLYvqS7sKvNSe85H+syuGY7zVIacdulBlGPMs+e2533cF1+xKLoSa/bPcvsqIqZwp6Ddwpsm9BrjOBVv2IOwUUCe3GokfCLx9gFYNH+gcmwYcZGjn00t1wU=  ;
Message-ID: <4420D82B.6080504@yahoo.com.au>
Date: Wed, 22 Mar 2006 15:52:59 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Shaohua Li <shaohua.li@intel.com>
CC: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] less tlb flush in unmap_vmas
References: <1142995088.11430.34.camel@sli10-desk.sh.intel.com>
In-Reply-To: <1142995088.11430.34.camel@sli10-desk.sh.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li wrote:

>In unmaping region, if current task doesn't need reschedule, don't do a
>tlb_finish_mmu. This can reduce some tlb flushes.
>
>In the lmbench tests, this patch gives 2.1% improvement on exec proc
>item and 4.2% on sh proc item.
>
>

The problem with this is that by the time we _do_ determine that a
reschedule is needed, we might have built up a huge amount of work
to do (which can probably be as much if not more exensive per-page
as the unmapping), so scheduling latency can still be unacceptable
so I'm afraid I don't think we can include this patch.

One option I've been looking into is my "mmu gather in-place" that
never needs extra tlb flushes and is always preemptible... so that
may be a way forward.

---

Send instant messages to your online friends http://au.messenger.yahoo.com 
