Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751543AbWHJUOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbWHJUOZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932140AbWHJUNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:13:11 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:27267 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751538AbWHJUMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 16:12:41 -0400
Message-ID: <44DB9335.9060304@garzik.org>
Date: Thu, 10 Aug 2006 16:12:37 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Badari Pulavarty <pbadari@us.ibm.com>, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] Forking ext4 filesystem from ext3 filesystem
References: <1155172622.3161.73.camel@localhost.localdomain>	<20060809233914.35ab8792.akpm@osdl.org>	<44DB8036.5020706@us.ibm.com> <20060810122340.185b8d8f.akpm@osdl.org>
In-Reply-To: <20060810122340.185b8d8f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 10 Aug 2006 11:51:34 -0700
> Badari Pulavarty <pbadari@us.ibm.com> wrote:
> 
>> Andrew Morton wrote:
>>> Also, JBD is presently feeding into submit_bh() buffer_heads which span two
>>> machine pages, and some device drivers spit the dummy.  It'd be better to
>>> fix that once, rather than twice..  
>>>   
>> Andrew,
>>
>> I looked at this few days ago. I am not sure how we end up having 
>> multiple pages (especially,
>> why we end up having buffers with bh_size > pagesize) ? Do you know why ?
>>
> 
> It's one or both of the jbd_kmalloc(bh->b_size) calls in
> fs/jbd/transaction.c.  Here we're allocating data to attach to a bh which
> later gets fed into submit_bh().
[...]

I respectfully submit that this sort of urge to clean up all the 
narstiness (a local term) in ext3 is _precisely_ the reason why we need 
ext4 in the tree ASAP.

Once people start pushing a large volume of changes into ext[34], the 
"obvious cleanups" start popping up.  Look at the ratholes we are 
_already_ diving down, in this thread, trying to clean up ext3 before 
the copy.

ext4 will exist precisely to enable these sort of rapid cleanups.  If 
obvious stuff starts popping up, the cleanups can go in immediately 
without worry of destabilization.

Just let ext3 sit.  Other filesystems use submit_bh(), brelse(), etc. 
If ext3 is to stop using those, let it be when others stop using them as 
well.

ext4 is the devel tree.  ext3 is the stable tree.  Just go ahead and "cp 
fs/ext3 fs/ext4" immediately, otherwise the cleanups will pile up, and 
the branch will take place a year from now.

	Jeff, still waiting for submit_bio() to be used in fs's :)



