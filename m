Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUHaRyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUHaRyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 13:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266096AbUHaRyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 13:54:49 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:47091 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266006AbUHaRxJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 13:53:09 -0400
Message-ID: <4134BACC.60203@us.ibm.com>
Date: Tue, 31 Aug 2004 10:52:12 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@linux.ie>,
       linux-kernel@vger.kernel.org
Subject: Re: [rfc][patch] DRM initial function table support.
References: <Pine.LNX.4.58.0408311409530.18657@skynet> <20040831152015.GC22978@redhat.com> <4134A22F.7000103@us.ibm.com> <20040831180129.A23112@infradead.org>
In-Reply-To: <20040831180129.A23112@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Aug 31, 2004 at 09:07:11AM -0700, Ian Romanick wrote:
> 
>>I think the intention is to have default functions set in the 
>>device-independent code and have the device-dependent code over-ride 
>>them.  Since the defaults may not always be NULL, doing a struct like 
>>that wouldn't really work.  I suppose we could have a struct and a 
>>device-independent function that copies the non-NULL pointers from the 
>>per-device struct.  Would that be better?
> 
> Don't copy them.  Just put
> 
> if (foo->ops->method1)
> 	foo->ops->method1(args);
> else
> 	generic_method1(args);
> 
> in your code.  It's an additional branch, but you avoid the indirect
> functioncalloverhead in exchange.

<MrHorse>No sir, I didn't like it.</MrHorse>  That would not only be 
ugly to read, but it would add maintenance burden.  If the default 
changes from NULL to non-NULL, code has to be changed from doing nothing 
in the NULL case to calling generic_method1.  The one place that we miss 
is the one place that will crash Linus' box. :)

