Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422796AbWBIEqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422796AbWBIEqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 23:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422797AbWBIEqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 23:46:33 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:52565 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1422796AbWBIEqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 23:46:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=X8uZQNnPPuRra+qthHuwlK4bdrLfcIPr7zSKeZHO4tg7xBCA05np/U9tX3NalMtBa7l9jqhFTZ2FEDTtQ4Zra8JRwP1kuBURlEkQdQZbr9JyntshVH/TzTDfqxvX8eBGy1d1V0XXzi9UgNSLuDt5lfJpaqz2To+8vdHbiugEk/A=  ;
Message-ID: <43EAC925.1010202@yahoo.com.au>
Date: Thu, 09 Feb 2006 15:46:29 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@g5.osdl.org>
Subject: Re: [PATCH] percpu data: only iterate over possible CPUs
References: <200602051959.k15JxoHK001630@hera.kernel.org> <Pine.LNX.4.63.0602081728590.31711@cuia.boston.redhat.com> <43EAC78E.8000908@cosmosbay.com>
In-Reply-To: <43EAC78E.8000908@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Rik van Riel a écrit :
> 
>> On Sun, 5 Feb 2006, Linux Kernel Mailing List wrote:
>>
>>> [PATCH] percpu data: only iterate over possible CPUs
>>
>>
>> This sched.c bit breaks Xen, and probably also other architectures
>> that have CPU hotplug.  I suspect the reason is that during early 
>> bootup only the boot CPU is online, so nothing initialises the
>> runqueues for CPUs that are brought up afterwards.
>>
>> I suspect we can get rid of this problem quite easily by moving
>> runqueue initialisation to init_idle()...
> 
> 
> Please fix Xen to match include/linux/cpumask.h documentation that says :
> 
> /*
>  * The following particular system cpumasks and operations manage
>  * possible, present and online cpus.  Each of them is a fixed size
>  * bitmap of size NR_CPUS.
>  *
>  *  #ifdef CONFIG_HOTPLUG_CPU
>  *     cpu_possible_map - all NR_CPUS bits set

Note that this shouldn't have to be all NR_CPUs if the platform
can determine all possible hotpluggable CPUs.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
