Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751590AbWCAEiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590AbWCAEiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 23:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbWCAEiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 23:38:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58853 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751590AbWCAEiI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 23:38:08 -0500
To: Paul Jackson <pj@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: + proc-dont-lock-task_structs-indefinitely-cpuset-fix-2.patch
 added to -mm tree
References: <200603010120.k211KqVP009559@shell0.pdx.osdl.net>
	<20060228181849.faaf234e.pj@sgi.com>
	<20060228183610.5253feb9.akpm@osdl.org>
	<20060228194525.0faebaaa.pj@sgi.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 28 Feb 2006 21:31:47 -0700
In-Reply-To: <20060228194525.0faebaaa.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Feb 2006 19:45:25 -0800")
Message-ID: <m1slq2pyyy.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> writes:

>> -rc5-mm1 appears to be a trainwreck.  It's a bit of a mystery - I've tried
>> several further configs and it all works swimmingly.
>
> Getting closer.
>
> Without the patches:
>
>     proc-dont-lock-task_structs-indefinitely.patch
>     proc-dont-lock-task_structs-indefinitely-git-nfs-fix.patch
>     proc-dont-lock-task_structs-indefinitely-cpuset-fix.patch

That definitely makes sense if there is a reference counting bug
somewhere.

What is also possible but scary is that I don't have a reference
counting bug and something else is wrong with process management,
and by holding a much lighter grasp on the tasks in /proc
I have managed to make the bug much easier to trigger.

Hmm.  I think I can see at least one reference counting bug..
Unfortunately it is in the wrong direction.

> With these patches, it still boots, and looks fine ... until
> I fire up my SGI specific application, and then it dies.
> Once it died with some complaint (lost now) from a swap
> daemon.  This latest time, it died with just:
>
>   Kernel panic - not syncing: Attempted to kill init!

Ouch.

> So I think the above 3 patches make it easy for user space
> to kill the kernel.

The intent was the opposite...  But until the bugs get out...

Eric
