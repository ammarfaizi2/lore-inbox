Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUATE4K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 23:56:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264144AbUATE4K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 23:56:10 -0500
Received: from mail-06.iinet.net.au ([203.59.3.38]:50074 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263584AbUATE4H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 23:56:07 -0500
Message-ID: <400CB4DC.7090807@cyberone.com.au>
Date: Tue, 20 Jan 2004 15:55:56 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: markw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: DBT-2 anticipatory scheduler and filesystem results with 2.6.1
References: <200401200005.i0K05do05666@mail.osdl.org> <20040119203845.332cd5df.akpm@osdl.org>
In-Reply-To: <20040119203845.332cd5df.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andrew Morton wrote:

>markw@osdl.org wrote:
>
>> I ran some dbt-2 tests against 5 filesystems with 2.6.1-mm4 and 2.6.1. I
>> see a degradation from 0 to 7% in throughput. 
>>
>
>-mm4 also had readahead changes which will adversely impact database-style
>workloads.  I'd suggest that you revert
>
>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1/2.6.1-mm4/broken-out/readahead-revert-lazy-readahead.patch
>
>and retest.
>
>We reverted lazy readahead because it broke NFS linear reads and was doing
>the wrong thing anyway.  We need to come up with something else for
>database-style workloads.
>
>

Oh good. I'd be a bit surprised if it were due to an as-iosched.c change 
that
caused the regression.

But there are changes in how new processes are handled, so if you have a lot
of io submitting processes being created, you might see a difference.


