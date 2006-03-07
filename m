Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWCGBBA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWCGBBA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 20:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWCGBA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 20:00:59 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35981 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932567AbWCGBA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 20:00:58 -0500
Message-ID: <440D4BBD.20405@us.ibm.com>
Date: Tue, 07 Mar 2006 01:00:45 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Suparna Bhattacharya <suparna@in.ibm.com>, christoph <hch@lst.de>,
       mcao@us.ibm.com, akpm@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, vs@namesys.com,
       zam@namesys.com
Subject: Re: [PATCH 0/3] map multiple blocks in get_block() and mpage_readpages()
References: <1140470487.22756.12.camel@dyn9047017100.beaverton.ibm.com> <20060222151216.GA22946@lst.de> <1140801549.22756.195.camel@dyn9047017100.beaverton.ibm.com> <20060306100321.GA27319@in.ibm.com> <20060307093930.D219568@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nathan Scott wrote:

>On Mon, Mar 06, 2006 at 03:33:21PM +0530, Suparna Bhattacharya wrote:
>
>>On Fri, Feb 24, 2006 at 09:19:08AM -0800, Badari Pulavarty wrote:
>>
>>>I am thinking of having a "fast path" which doesn't deal with any
>>>of those and "slow" path to deal with all that non-sense.
>>>...
>>>slow_path is going to be slow & ugly. How important is to handle
>>>1k, 2k filesystems efficiently ? Should I try ?
>>>
>>With 64K page size that could include 4K, 8K, 16K, 32K block size filesystems
>>as well, not sure how likely that would be ?
>>
>
>A number of architectures have a pagesize greater than 4K.  Most
>(OK, sample size of 2) mkfs programs default to using 4K blocksizes.
>So, any/all platforms not having a 4K pagesize will be disadvantaged.
>Search on the definition of PAGE_SHIFT in asm-*/page.h and for all
>platforms where its not defined to 12, this will hurt.
>

I agree,  I haven't made up my mind either on if its really worth doing.

I was hoping that it will help simple cases + it will help filesystems 
which use
page->private for something other than buffer heads.

Thanks,
Badari

>



