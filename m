Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293627AbSB1STG>; Thu, 28 Feb 2002 13:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293647AbSB1SPn>; Thu, 28 Feb 2002 13:15:43 -0500
Received: from 216-42-72-159.ppp.netsville.net ([216.42.72.159]:61904 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S293477AbSB1SNl>; Thu, 28 Feb 2002 13:13:41 -0500
Date: Thu, 28 Feb 2002 13:12:40 -0500
From: Chris Mason <mason@suse.com>
To: James Bottomley <James.Bottomley@steeleye.com>,
        "Stephen C. Tweedie" <sct@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] 2.4.x write barriers (updated for ext3) 
Message-ID: <3903140000.1014919960@tiny>
In-Reply-To: <3746210000.1014911746@tiny>
In-Reply-To: <200202281536.g1SFaqF02079@localhost.localdomain> <3746210000.1014911746@tiny>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, February 28, 2002 10:55:46 AM -0500 Chris Mason <mason@suse.com> wrote:

>> 
>> A longer term solution might be to keep the writeback cache but send down a 
>> SYNCHRONIZE CACHE command as part of the back end completion of a barrier 
>> write, so the fs wouldn't get a completion until the write was done and all 
>> the dirty cache blocks flushed to the medium.
> 
> Right, they could just implement ORDERED_FLUSH in the barrier patch.

So, a little testing with scsi_info shows my scsi drives do have
writeback cache on.  great.  What's interesting is they
must be doing additional work for ordered tags.  If they were treating
the block as written once in cache, using the tags should not change 
performance at all.  But, I can clearly show the tags changing
performance, and hear the drive write pattern change when tags are on.

-chris

