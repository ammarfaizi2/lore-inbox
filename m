Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293409AbSCEQXa>; Tue, 5 Mar 2002 11:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293411AbSCEQXU>; Tue, 5 Mar 2002 11:23:20 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:25984 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S293409AbSCEQXI>; Tue, 5 Mar 2002 11:23:08 -0500
Message-Id: <200203051618.g25GIMw20412@fuji.home.perso>
Date: Tue, 5 Mar 2002 17:18:19 +0100 (CET)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: swsusp is at it... again
To: pavel@ucw.cz
Cc: linux-kernel@vger.kernel.org, swsusp@lister.fornax.hu
In-Reply-To: <20020304230623.GA16601@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le  5 Mar, Pavel Machek a écrit :
> Hi!
> 
> After about 20 resume cycles (compiled kernel with swsusp making
> machine suspend/resume) I got that nasty FS corruption, again.
> 
> So... 
> 
> 1) Maybe your ext3 patches are not at fault.

I suspect all this come from suspension failure and immediate resume. I
have reenabled your panic ! I believe that if a task isn't stopped and
suspension is aborted (calling thaw_process and so on) something is
altered. Maybe resuming assumes implicitely a state that is not
completely reached when a task cannot be stopped.

I also made a modification in stopping task to stop normal task and then
kernel threads (I had to add a new PF_KERNTHREAD flag). Perhaps the bug
has to do with the *order* of stopping processes (I think of that
because kernel messages are written to log files: what happens if
kjournald thread is stopped and a task still writes ?)
 
> 2) Be carefull using swsusp patch. Real carefull.
> 
> 3) Don't trust fsck. At this kind of corruption, e2fsck 1.19 will
> report "clean" but will not repair it, putting your fs into
> self-destruct mode. Bad bad. Its fixed on new versions. Always run
> fsck twice, second time with -f.

tune2fs -e panic 
is also a good precaution at least for ext3 filesystems because all my
root inode crashes were preceded by ext3-error messages and these
messages were sometimes several hours before effective crash. 


--
Florent Chabaud
http://www.ssi.gouv.fr | http://fchabaud.free.fr

