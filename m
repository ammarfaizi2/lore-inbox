Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWEOWrX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWEOWrX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 18:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWEOWrX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 18:47:23 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:4048 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750707AbWEOWrW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 18:47:22 -0400
Message-ID: <446904F3.3010601@us.ibm.com>
Date: Mon, 15 May 2006 15:47:15 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: akpm@osdl.org, christoph <hch@lst.de>, Benjamin LaHaise <bcrl@kvack.org>,
       cel@citi.umich.edu, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] Streamline generic_file_* interfaces and filemap cleanups
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147361890.12117.11.camel@dyn9047017100.beaverton.ibm.com> <1147727945.20568.53.camel@dyn9047017100.beaverton.ibm.com> <1147728206.6181.7.camel@dyn9047017100.beaverton.ibm.com> <20060516082804.F5598@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Nathan Scott wrote:

>Hi Badari,
>
>On Mon, May 15, 2006 at 02:23:26PM -0700, Badari Pulavarty wrote:
>
>>This patch cleans up generic_file_*_read/write() interfaces.
>>Christoph Hellwig gave me the idea for this clean ups.
>>
>>In a nutshell, all filesystems should set .aio_read/.aio_write
>>methods and use do_sync_read/ do_sync_write() as their .read/.write 
>>
>
>I know its not something you're introducing here, but the naming
>convention do_sync_read/do_sync_write is pretty confused (with it
>not actually being a sync write and all, in the usual case).
>Any chance that could be renamed to something thats a bit clearer,
>maybe generic_file_non_aio_read and generic_file_non_aio_write?
>There don't seem to be many callsites (so not a huge change) and
>it'd seem a good time to do it, alongside these other changes.
>

You  mean "left-in-pagecache-not-really-written-to-disk" synchronous ? 
Yeah. I see it..
I prefer, generic_file_aio_read_and_wait(), 
generic_file_aio_write_and_wait() - but
its ugly also :(

I also have a small issue with the current do_sync_*() routines - if 
some one calls it
without setting their ->aio_read()/->aio_write(), we panic. May be we 
should add a BUG_ON(), but again I don't want to slow things down..

Thanks,
Badari



