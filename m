Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265705AbSLBISP>; Mon, 2 Dec 2002 03:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265700AbSLBISP>; Mon, 2 Dec 2002 03:18:15 -0500
Received: from dial-ctb05213.webone.com.au ([210.9.245.213]:14855 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S265705AbSLBISN>;
	Mon, 2 Dec 2002 03:18:13 -0500
Message-ID: <3DEB192C.2080800@cyberone.com.au>
Date: Mon, 02 Dec 2002 19:26:20 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: lkml <linux-kernel@vger.kernel.org>,
       "ext3-users@redhat.com" <ext3-users@redhat.com>
Subject: Re: data corrupting bug in 2.4.20 ext3, data=journal
References: <3DE9C43D.61FF79C5@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Nick Piggin wrote:
>> 
>> Andrew Morton wrote:
>> 
>> >In 2.4.20-pre5 an optimisation was made to the ext3 fsync function
>> >which can very easily cause file data corruption at unmount time.  This
>> >was first reported by Nick Piggin on November 29th (one day after 2.4.20 was
>> >released, and three months after the bug was merged.  Unfortunate timing)
>> >
>> In fact it was reported on lkml on 18th July IIRC before 2.4.19 was
>> released if that is any help to you. 2.4.19 and 2.4.20 are affected
>> and I haven't tested previous releases. I was going to re-report it
>> sometime, but Alan brought it to light just the other day.
>> 
>
>Are you sure?  I can't make it happen on 2.4.19.  And disabling the new
>BH_Freed logic (which went into 2.4.20-pre5) makes it go away.
>
>
>--- linux-akpm/fs/jbd/commit.c~a	Sun Dec  1 23:10:12 2002
>+++ linux-akpm-akpm/fs/jbd/commit.c	Sun Dec  1 23:10:27 2002
>@@ -695,7 +695,7 @@ skip_commit: /* The journal should be un
> 		 * use in a different page. */
> 		if (__buffer_state(bh, Freed)) {
> 			clear_bit(BH_Freed, &bh->b_state);
>-			clear_bit(BH_JBDDirty, &bh->b_state);
>+//			clear_bit(BH_JBDDirty, &bh->b_state);
> 		}
> 			
> 		if (buffer_jdirty(bh)) {
>
I reported the bug for 2.4.19-rc1 and 2 but I can't remember if I tested 
2.4.19
when it was released. It has an external journal on a seperate disk. I can't
really do any testing with the machine unfortunately.

Regards,
Nick

