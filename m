Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310270AbSCGKTz>; Thu, 7 Mar 2002 05:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310271AbSCGKTq>; Thu, 7 Mar 2002 05:19:46 -0500
Received: from smtp4.vol.cz ([195.250.128.43]:20998 "EHLO majordomo.vol.cz")
	by vger.kernel.org with ESMTP id <S310270AbSCGKTi>;
	Thu, 7 Mar 2002 05:19:38 -0500
Date: Thu, 7 Mar 2002 00:35:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: fchabaud@free.fr
Cc: linux-kernel@vger.kernel.org, swsusp@lister.fornax.hu
Subject: Re: swsusp is at it... again and again
Message-ID: <20020306233509.GA576@elf.ucw.cz>
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
> have reenabled your panic ! I believe that if a task isn't stopped and
> suspension is aborted (calling thaw_process and so on) something is
> altered. Maybe resuming assumes implicitely a state that is not
> completely reached when a task cannot be stopped.

I don't think that's it. But I have another suspect:

mark_swapfiles in do_magic_resume_2. Oh, and you should also kill it
from do_magic_suspend_*. Its writing on filesystem during resume, and
it does not seem too safe.

However my test machine is hosed so badly I can not repair it with
fsck. [Another day, another bug in fsck ;-)], so it would be great if
you could test this....
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
