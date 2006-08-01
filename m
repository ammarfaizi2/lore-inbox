Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932545AbWHAJam@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932545AbWHAJam (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 05:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWHAJam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 05:30:42 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:55218 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932545AbWHAJam
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 05:30:42 -0400
Message-ID: <44CEBCBC.9070707@namesys.com>
Date: Mon, 31 Jul 2006 20:30:20 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda.linux@googlemail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: reiser4: maybe just fix bugs?
References: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
In-Reply-To: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

> And second, reiser team was a bit lax at fixing bugs.
> Not too bad when compared to other FSes, but still.

If we feel a bug should be fixed without waiting for a major release
(98%+ of bugs), we try to fix it in 3 days, and usually succeed at
that.  Not all users agree with us that a given bug should wait for a
major release.

> Frankly, on the first problem I think that you are right, Hans,
> and putting plugins into VFS _now_ makes little sense because
> we can't know whether anybody will ever want to have plugins
> for some other FS, so requiring reiser people to do all the shuffling
> _now_
> for questionable gain is simply not fair. It can be done later if needed.
>
> It leaves you with the other option: remove the second problem.
> Try to fix bugs. Including reiser3 ones.
> I'm not saying that you are not doing this at all,
> but I distinctly remember that some discussions (about locking
> problems IIRC) were "brushed aside" by reiser people instead of plainly
> admitting that problem exists and they will work on fixing it.
>
> * What is that story about hash chain size limit?
>  Is it present on reiser4 also? Will it be addressed?

Now that we  (Nikita actually) solved it in Reiser4 by handling
duplicate keys  I now realize that I could have solved it in V3 years
ago if I had been brighter, but since V4 is ready I think it is better
to not destabilize code in V3 by changing things now.  It might touch a
lot of lines of code to fix in V3, Nikita would know better than I.

>
> For the problems I personally seen:
>
> * I had 3 reiser3 partitions on a 32Mb RAM box, and massive inode
>  updates (chown -R) ate all RAM and deadlocked the box.

This is VFS/VM not us.  You are right that it should be fixed, as it is
indicative of deep problems with the memory management code that require
fundamental changes.

>  You adviced me to reduce journal size. It works,
>  but shouldn't reiser do it dynamically on mount if needed?

Yes, it would be nice, could you email chris@suse.com about it?  This is
a feature that is ok to add to a stable branch, I cannot logically
define why but I feel it is so....   after much testing and a beta
though....   Note that V4 fixes this by using wandering logs.....

>  Are there any other known oom deadlocks?

That are specific to reiserfs rather than all of Linux, I think not.....

> * Does reiser still requires 100.00% defect-free media?

Not if you use device mapper.

> * Are there plans for making reiserfsck interface compatible with fsck?
>  I mean, making it so that reiserfsck can be symlinked to fsck.reiser
>  and it will work? Currently, there seems to be some incompatibility
>  in command-line switches. (I will dig out details and send separately
>  when I'll get back to my Linux box.)

Not sure what you mean.  Forgive me, I have not supervised fsck as
closely as other things.

>
> P.S. I am a reiser3 user on all my boxes.
> Thanks Hans for your work.
> -- 
> vda
>
>
Thank you for your suggestions and advice,

Hans
