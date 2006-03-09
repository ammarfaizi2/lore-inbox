Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbWCIQSQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbWCIQSQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 11:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWCIQSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 11:18:16 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:60293 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932226AbWCIQSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 11:18:15 -0500
Message-ID: <4410551D.5000303@us.ibm.com>
Date: Thu, 09 Mar 2006 08:17:33 -0800
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: akpm@osdl.org
CC: sct@redhat.com, lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>, jack@suse.cz
Subject: ext3_ordered_writepage() questions
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to cleanup ext3_ordered and ext3_writeback_writepage() routines.
I am confused on what ext3_ordered_writepage() is currently doing ? I hope
you can help me understand it little better.

1) Why do we do journal_start() all the time ? I was hoping to skip
journal_start()/stop() if the blocks are already allocated. Since we 
allocated
blocks in prepare_write() for most cases (non-mapped writes), I was
hoping to avoid the whole journal stuff in writepage(), if blocks are
already there. (we can check buffers attached to the page and find
out if they are mapped or not).

2) Why do we call journal_dirty_data_fn() on the buffers ? We already
issued IO on all those buffers() in block_full_write_page(). Why do we
need to add them to transaction ?  I understand we need to do this for
block allocation case. But do we need it for non-allocation case also ?

Can we skip the whole journal start, journal_dirty_data, journal_stop
for non-allocation cases ? I have coded up to do so, but I am confused
on what am I missing here ?

Please let me know.

Thanks,
Badari


