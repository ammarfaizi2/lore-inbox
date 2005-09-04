Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVIDGhp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVIDGhp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 02:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVIDGhp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 02:37:45 -0400
Received: from smtp.istop.com ([66.11.167.126]:47303 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S1751231AbVIDGho (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 02:37:44 -0400
From: Daniel Phillips <phillips@istop.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Date: Sun, 4 Sep 2005 02:40:08 -0400
User-Agent: KMail/1.8
Cc: Joel.Becker@oracle.com, linux-cluster@redhat.com, wim.coekaerts@oracle.com,
       linux-fsdevel@vger.kernel.org, ak@suse.de, linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040022.37102.phillips@istop.com> <20050903214653.1b8a8cb7.akpm@osdl.org>
In-Reply-To: <20050903214653.1b8a8cb7.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509040240.08467.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 04 September 2005 00:46, Andrew Morton wrote:
> Daniel Phillips <phillips@istop.com> wrote:
> > The model you came up with for dlmfs is beyond cute, it's downright
> > clever.
>
> Actually I think it's rather sick.  Taking O_NONBLOCK and making it a
> lock-manager trylock because they're kinda-sorta-similar-sounding?  Spare
> me.  O_NONBLOCK means "open this file in nonblocking mode", not "attempt to
> acquire a clustered filesystem lock".  Not even close.

Now, I see the ocfs2 guys are all ready to back down on this one, but I will 
at least argue weakly in favor.

Sick is a nice word for it, but it is actually not that far off.  Normally, 
this fs will acquire a lock whenever the user creates a virtual file and the 
create will block until the global lock arrives.  With O_NONBLOCK, it will 
return, erm... ETXTBSY (!) immediately.  Is that not what O_NONBLOCK is 
supposed to accomplish?

> It would be much better to do something which explicitly and directly
> expresses what you're trying to do rather than this strange "lets do this
> because the names sound the same" thing.
>
> What happens when we want to add some new primitive which has no posix-file
> analog?
>
> Waaaay too cute.  Oh well, whatever.

The explicit way is syscalls or a set of ioctls, which he already has the 
makings of.  If there is going to be a userspace api, I would hope it looks 
more like the contents of userdlm.c than the traditional Vaxcluster API, 
which sucks beyond belief.

Another explicit way is to do it with a whole set of virtual attributes 
instead of just a single file trying to capture the whole model.  That is 
really unappealing, but I am afraid that is exactly what a whole lot of 
sysfs/configfs usage is going to end up looking like.

But more to the point: we have no urgent need for a userspace dlm api at the 
moment.  Nothing will break if we just put that issue off for a few months, 
quite the contrary.

If the only user is their tools I would say let it go ahead and be cute, even 
sickeningly so.  It is not supposed to be a general dlm api, at least that is 
my understanding.  It is just supposed to be an interface for their tools.  
Of course it would help to know exactly how those tools use it.  Too sleepy 
to find out tonight...

Regards,

Daniel
