Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVD0U4E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVD0U4E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVD0U4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:56:03 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:44942 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262010AbVD0Uzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:55:41 -0400
Message-ID: <426FFC30.1060700@tmr.com>
Date: Wed, 27 Apr 2005 16:55:12 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ram <linuxram@us.ibm.com>
CC: Miklos Szeredi <miklos@szeredi.hu>, lmb@suse.de, mj@ucw.cz,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
References: <E1DQqyY-0002WW-00@dorka.pomaz.szeredi.hu><20050426094727.GA30379@infradead.org> <1114630811.4180.20.camel@localhost>
In-Reply-To: <1114630811.4180.20.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> On Wed, 2005-04-27 at 11:09, Miklos Szeredi wrote:
> 
>>>eg:
>>> 
>>>user 1 does a invisible mount on /mnt/mnt1
>>>root does a visible mount on /mnt/mnt1
>>>
>>>user 1 will no longer be able to access his /mnt/mnt1
>>>
>>>in fact even if root mounts something on /mnt, the problem still exists.
>>
>>This is not something specific to FUSE.  Root can overmount any of
>>your directories after which you won't be able to access it (unless
>>some of your processes have a CWD there).
> 
> 
> sorry, I think I have not raised by concern clearly.
> 
> I am mostly talking about the semantics of 'invisible/private mount' not
> FUSE in particular, since the kernel patch brings in new feature
> to VFS.
> 
> My understanding of private mount is:
> 1. The contents of the private mount is visible only to the 
>     mount owner.
> 2. The vfsmount of the private mount is only accessible to
>    the mount owner, and only the mount owner can mount anything
>    on top of it.
> 
> But I dont see (2) is being checked for.
> 
> I can overmount something on top of a private mount owned by someother
> user. I verified that with your patch.
> 
> 1. do a invisible mount as user 'x' on /mnt
> 2. do a visible mount as root on /mnt  and it *succeeds* and also masks
>     the earlier mount to the user 'x'.
> 
> I am not concerned about the masking effect so much. But I am concerned
> that the private vfsmount at /mnt is accessible to someother user 
> to mount something else on top of it. **The dentry on top of which  the
> new vfsmount is done belongs to the private vfsmount**.
> 
> 
> Am I making sense? If I do make sense, than all we need is a patch on
> top of your patch which disallows non-owner to mount something on top of
> a private/invisible vfsmount owned by some owner.
> 
> If I am not making sense, I keep quite :)

I think you point out a solution could be worse that what it cures. 
There are clearly problems with mount over, but imagine that a user does 
an invisible mount over /mnt, doesn't that prevent other mounts which 
are usually made, like /mnt/cdrom, /mnt/loopN, etc?

Every time someone suggests a solution it seems to open a new path to 
possible abuse. And features which only work with a monotonic kernel 
rather than modules would seem to indicate that the feature is nice but 
the implementation might benefit from more thinking time.

Frankly the whole statement that the controversial code MUST go in now 
and could be removed later sounds like a salesman telling me I MUST sign 
the contract today, but he will let me out of it if I decide it was a 
mistake.

I'm not against the feature, but a lot of people I consider competent 
seem to find the implementation controversial, which argues for waiting 
until more eyes are on the code. If the rest of the code is useless 
without the controversial part, maybe it should all stay a patch to use 
or not as people decide.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
