Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbUKCCtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbUKCCtM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 21:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbUKCCtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 21:49:11 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:14804 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261338AbUKCCtJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 21:49:09 -0500
Message-ID: <418846E9.1060906@us.ibm.com>
Date: Tue, 02 Nov 2004 18:48:09 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
CC: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: fix iounmap and a pageattr memleak (x86 and x86-64)
References: <4187FA6D.3070604@us.ibm.com> <20041102220720.GV3571@dualathlon.random> <41880E0A.3000805@us.ibm.com> <4188118A.5050300@us.ibm.com> <20041103013511.GC3571@dualathlon.random> <418837D1.402@us.ibm.com> <20041103022606.GI3571@dualathlon.random>
In-Reply-To: <20041103022606.GI3571@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Tue, Nov 02, 2004 at 05:43:45PM -0800, Dave Hansen wrote:
> 
>>Oh, crap.  I meant to clear ->mapped when change_attr(__pgprot(0)) was 
>>done on it, and set it when it was changed back.  Doing that correctly 
>>preserves the symmetry, right?
> 
> yes it should. I agree with Andrew a bitflag would be enough. I'd call
> it PG_prot_none.

It should be enough, but I don't think we want to waste a bitflag for 
something that's only needed for debugging anyway.  They're getting 
precious these days.  Might as well just bloat the kernel some more when 
the alloc debugging is on.

I'll see what I can do to get some backtraces of the __pg_prot(0) &&
page->mapped cases.
