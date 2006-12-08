Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164349AbWLHBxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164349AbWLHBxJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164370AbWLHBxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:53:09 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:12340 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1164349AbWLHBxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:53:08 -0500
In-Reply-To: <20061207174627.63300ccf.akpm@osdl.org>
References: <45789124.1070207@mvista.com> <20061207143611.7a2925e2.akpm@osdl.org> <04710480e9f151439cacdf3dd9d507d1@mvista.com> <20061207174627.63300ccf.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <df54053fca85900fab7864e0f05ed2c8@mvista.com>
Content-Transfer-Encoding: 7bit
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
From: david singleton <dsingleton@mvista.com>
Subject: Re: new procfs memory analysis feature
Date: Thu, 7 Dec 2006 17:53:06 -0800
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7, 2006, at 5:46 PM, Andrew Morton wrote:

> On Thu, 7 Dec 2006 17:07:22 -0800
> david singleton <dsingleton@mvista.com> wrote:
>
>> Attached is the 2.6.19 patch.
>
> It still has the overflow bug.
>> +       do {
>> +               ptent = *pte;
>> +               if (pte_present(ptent)) {
>> +                       page = vm_normal_page(vma, addr, ptent);
>> +                       if (page) {
>> +                               if (pte_dirty(ptent))
>> +                                       mapcount = 
>> -page_mapcount(page);
>> +                               else
>> +                                       mapcount = 
>> page_mapcount(page);
>> +                       } else {
>> +                               mapcount = 1;
>> +                       }
>> +               }
>> +               seq_printf(m, " %d", mapcount);
>> +
>> +       } while (pte++, addr += PAGE_SIZE, addr != end);
>
> Well that's cute.  As long as both seq_file and pte-pages are of size
> PAGE_SIZE, and as long as pte's are more than three bytes, this will 
> not
> overflow the seq_file output buffer.
>
> hm.  Unless the pages are all dirty and the mapcounts are all 10000.  I
> think it will overflow then?
>

I guess that could happen?    Any suggestions?

