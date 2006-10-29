Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWJ2JQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWJ2JQI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 04:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbWJ2JQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 04:16:08 -0500
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:48249 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S932120AbWJ2JQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 04:16:04 -0500
Message-ID: <4544714F.7070203@qumranet.com>
Date: Sun, 29 Oct 2006 11:15:59 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Anthony Liguori <aliguori@us.ibm.com>
CC: Arnd Bergmann <arnd@arndb.de>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [kvm-devel] [PATCH 6/13] KVM: memory slot management
References: <4540EE2B.9020606@qumranet.com> <200610270044.31382.arnd@arndb.de>	<45419D73.1070106@qumranet.com> <200610270937.11646.arnd@arndb.de> <454208EB.7080007@qumranet.com> <4542292C.3080409@us.ibm.com>
In-Reply-To: <4542292C.3080409@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Oct 2006 09:16:04.0276 (UTC) FILETIME=[DBE87F40:01C6FB3A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony Liguori wrote:
>>
>> It's not about tlb entries.  The shadow page tables collaples a GV -> 
>> HV -> HP  double translation into a GV -> HP page table.  When the 
>> Linux vm goes around evicting pages, it invalidates those mappings.
>>
>> There are two solutions possible: lock pages which participate in 
>> these translations (and their number can be large) or modify the 
>> Linux vm to consult a reverse mapping and remove the translations (in 
>> which case TLB entries need to be removed).
>>   
>
> If you locked pages that have active shadow mappings, you could then 
> use a secondary mechanism to invalidate existing mappings when necessary.
>

Yes.

There are two needs: to propagate virtual machine activity to the host 
(by folding dirty and accessed bits from multiple shadow ptes into a 
single struct page), and to apply pressure from the vm to the guest (by 
invalidating all mappings of a given page).

-- 
error compiling committee.c: too many arguments to function

