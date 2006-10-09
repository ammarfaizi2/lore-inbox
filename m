Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWJIT7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWJIT7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbWJIT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 15:59:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16552 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964799AbWJIT7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 15:59:52 -0400
Message-ID: <452AAA1D.3020205@redhat.com>
Date: Mon, 09 Oct 2006 14:59:25 -0500
From: Eric Sandeen <esandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Eric Sandeen <sandeen@sandeen.net>
CC: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Badari Pulavarty <pbadari@us.ibm.com>, Jan Kara <jack@ucw.cz>
Subject: Re: 2.6.18 ext3 panic.
References: <20061002194711.GA1815@redhat.com>	<20061003052219.GA15563@redhat.com>	<4521F865.6060400@sandeen.net> <20061002231945.f2711f99.akpm@osdl.org> <452AA716.7060701@sandeen.net>
In-Reply-To: <452AA716.7060701@sandeen.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandeen wrote:

>>> I had thought/hoped that this was fixed by Jan's patch at 
>>> http://lkml.org/lkml/2006/9/7/236 from the thread started at 
>>> http://lkml.org/lkml/2006/9/1/149, but it seems maybe not.  Dave hit this bug 
>>> first by going through that new codepath....
>> Yes, Jan's patch is supposed to fix that !buffer_mapped() assertion.  iirc,
>> Badari was hitting that BUG and was able to confirm that Jan's patch
>> (3998b9301d3d55be8373add22b6bc5e11c1d9b71 in post-2.6.18 mainline) fixed
>> it.
> 
> Looking at some BH traces*, it appears that what Dave hit is a truncate
> racing with a sync...

(oh btw this is -with the above patch from Jan in place...)

-Eric

> truncate ...
>   ext3_invalidate_page
>     journal_invalidatepage
>       journal_unmap buffer
> 
> going off at the same time as
> 
> sync ...
>   journal_dirty_data
>     sync_dirty_buffer
>       submit_bh <-- finds unmapped buffer, boom.
> 
> I'm not sure what should be coordinating this, and I'm not sure why
> we've not yet seen it on a stock kernel, but only FC6... I haven't found
> anything in FC6 that looks like it may affect this.
> 
> -Eric
> 
> *http://people.redhat.com/esandeen/traces/davej_ext3_oops1.txt

