Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293526AbSCFNov>; Wed, 6 Mar 2002 08:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293525AbSCFNon>; Wed, 6 Mar 2002 08:44:43 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:32275 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S293518AbSCFNof>;
	Wed, 6 Mar 2002 08:44:35 -0500
Date: Tue, 5 Mar 2002 21:59:40 +0100
From: Pavel Machek <pavel@suse.cz>
To: fchabaud@free.fr
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp is at it... again
Message-ID: <20020305205940.GE318@elf.ucw.cz>
In-Reply-To: <20020304230623.GA16601@elf.ucw.cz> <200203051618.g25GIMw20412@fuji.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200203051618.g25GIMw20412@fuji.home.perso>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > After about 20 resume cycles (compiled kernel with swsusp making
> > machine suspend/resume) I got that nasty FS corruption, again.
> > 
> > So... 
> > 
> > 1) Maybe your ext3 patches are not at fault.
> 
> I suspect all this come from suspension failure and immediate resume. I
> have reenabled your panic ! I believe that if a task isn't stopped

Okay, I think I can try that. [Do you think you can send me your diffs
to ext3?]

> I also made a modification in stopping task to stop normal task and then
> kernel threads (I had to add a new PF_KERNTHREAD flag). Perhaps the bug
> has to do with the *order* of stopping processes (I think of that
> because kernel messages are written to log files: what happens if
> kjournald thread is stopped and a task still writes ?)

Nothing that bad should happen... kjournald is only _delayed_ right?
And it could be delayed by scheduling as well.

> > 2) Be carefull using swsusp patch. Real carefull.
> > 
> > 3) Don't trust fsck. At this kind of corruption, e2fsck 1.19 will
> > report "clean" but will not repair it, putting your fs into
> > self-destruct mode. Bad bad. Its fixed on new versions. Always run
> > fsck twice, second time with -f.
> 
> tune2fs -e panic 
> is also a good precaution at least for ext3 filesystems because all my
> root inode crashes were preceded by ext3-error messages and these
> messages were sometimes several hours before effective crash. 

Yes.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
