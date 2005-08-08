Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752651AbVHHBQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbVHHBQG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753189AbVHHBQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:16:06 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:59917 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1752651AbVHHBQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:16:06 -0400
Message-ID: <42F6B254.2090404@vmware.com>
Date: Sun, 07 Aug 2005 18:16:04 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel@vger.kernel.org, Pratap Subrahmanyam <pratap@vmware.com>,
       virtualization@lists.osdl.org
Subject: Re: [PATCH] abstract out bits of ldt.c
References: <372830000.1123456808@[10.10.2.4]> <20050807234411.GE7991@shell0.pdx.osdl.net> <374910000.1123459025@[10.10.2.4]> <20050807174129.20c7202f.akpm@osdl.org> <20050808004645.GT7762@shell0.pdx.osdl.net> <42F6AF8E.60107@vmware.com> <20050808010828.GU7762@shell0.pdx.osdl.net>
In-Reply-To: <20050808010828.GU7762@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Aug 2005 01:16:03.0375 (UTC) FILETIME=[BE9583F0:01C59BB6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:

>* Zachary Amsden (zach@vmware.com) wrote:
>  
>
>>Does Xen assume page aligned descriptor tables?  I assume from this 
>>    
>>
>
>Yes.
>
>  
>
>>patch and snippets I have gathered from others, that is a yes, and other 
>>things here imply that DT pages are not shadowed.  If so, Xen itself 
>>must have live segments in the GDT pages, so how do you allocate space 
>>for the per-CPU GDT pages on SMP?
>>    
>>
>
>early during boot.
>  
>

Doesn't that require 16 pages per CPU?  That seems excessive to impose 
on a native build.  Perhaps we could get away with 1 page per CPU for 
the GDT on native boots and bump that up to 16 if compiling for a 
virtualized sub-architecture - i.e. move GDT to a page aligned struct 
for native (doesn't cost too much), and give it MACH_GDT_PAGES of space 
which is defined by the sub-architecture.

Let's take this thread over to virtualization@lists.osdl.org as well.

Zach
