Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVKUFx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVKUFx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 00:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbVKUFx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 00:53:56 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:33982 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932197AbVKUFxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 00:53:55 -0500
Message-ID: <438160F0.4010903@us.ibm.com>
Date: Sun, 20 Nov 2005 21:53:52 -0800
From: Matthew Dobson <colpatch@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@sgi.com>
CC: linux-kernel@vger.kernel.org, Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/8] Critical Page Pool
References: <5511.1132472758@ocs3.ocs.com.au>
In-Reply-To: <5511.1132472758@ocs3.ocs.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Fri, 18 Nov 2005 11:32:57 -0800, 
> Matthew Dobson <colpatch@us.ibm.com> wrote:
> 
>>We have a clustering product that needs to be able to guarantee that the
>>networking system won't stop functioning in the case of OOM/low memory
>>condition.  The current mempool system is inadequate because to keep the
>>whole networking stack functioning, we need more than 1 or 2 slab caches to
>>be guaranteed.  We need to guarantee that any request made with a specific
>>flag will succeed, assuming of course that you've made your "critical page
>>pool" big enough.
>>
>>The following patch series implements such a critical page pool.  It
>>creates 2 userspace triggers:
>>
>>/proc/sys/vm/critical_pages: write the number of pages you want to reserve
>>for the critical pool into this file
>>
>>/proc/sys/vm/in_emergency: write a non-zero value to tell the kernel that
>>the system is in an emergency state and authorize the kernel to dip into
>>the critical pool to satisfy critical allocations.
> 
> 
> FWIW, the Kernel Debugger (KDB) has similar problems where the system
> is dying because of lack of memory but KDB must call some functions
> that use kmalloc.  A related problem is that sometimes KDB is invoked
> from a non maskable interrupt, so I could not even trust the state of
> the spinlocks and the chains in the slab code.
> 
> I worked around the problem by adding a last ditch allocator.  Extract
> from the kdb patch.

Ahh... very interesting.  And dissapointingly much smaller than mine. :(

Thanks for the patch and the feedback!

-Matt
