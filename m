Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751073AbWEIUIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbWEIUIE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWEIUIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 16:08:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:15069 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751073AbWEIUIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 16:08:02 -0400
Message-ID: <4460F69E.4070800@us.ibm.com>
Date: Tue, 09 May 2006 13:07:58 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       bcrl@kvack.org, cel@citi.umich.edu
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
References: <1146582438.8373.7.camel@dyn9047017100.beaverton.ibm.com> <1147197826.27056.4.camel@dyn9047017100.beaverton.ibm.com> <1147198025.28388.0.camel@dyn9047017100.beaverton.ibm.com> <20060509120105.7255e265.akpm@osdl.org> <20060509190310.GA19124@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Christoph Hellwig wrote:

>On Tue, May 09, 2006 at 12:01:05PM -0700, Andrew Morton wrote:
>
>>Together these three patches shrink the kernel by 113 lines.  I don't know
>>what the effect is on text size, but that's a pretty modest saving, at a
>>pretty high risk level.
>>
>>What else do we get in return for this risk?
>>
>
>there's another patch ontop which I didn't bother to redo until this is
>accepted which kills a lot more code.  After that filesystems only have
>to implement one method each for all kinds of read/write calls.  Which
>allows to both make the mm/filemap.c far less complex and actually
>understandable aswell as for any filesystem that uses more complex
>read/write variants than direct filemap.c calls.  In addition to these
>simplification we also get a feature (async vectored I/O) for free.
>
Yep. I am currently killing read/write methods for all filesystems and also
getting rid of generic_file_read() and generic_file_write().

Thanks,
Badari


