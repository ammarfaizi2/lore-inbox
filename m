Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbTKJS1g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 13:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbTKJS1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 13:27:35 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:7052 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S264045AbTKJS1d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 13:27:33 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 10:27:33 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Andrea Arcangeli <andrea@suse.de>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <3FAFD1E5.5070309@zytor.com>
Message-ID: <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, H. Peter Anvin wrote:

> >>The best way to fix this isn't to add locking to rsync, but to add two
> >>files inside or outside the tree, each one is a sequence number, so you
> >>fetch file1 first, then you rsync and you fetch file2, then you compare
> >>them. If they're the same, your rsync copy is coherent. It's the same
> >>locking we introduced with vgettimeofday.
> >>
> >>Ideally rsync could learn to check the sequence numbers by itself but I
> >>don't mind a bit of scripting outside of rsync.
> > 
> > Wouldn't a simpler  "stop-rsync -> update-root -> start-rsync" work? If 
> > you'll hit an update you will get a error from your local rsync, that will 
> > let you know to retry the operation.
> 
> Part of the problem is that there are multiple steps in the rsync chain, 
> some of which can't be stopped in this way.
> 
> The sequence number idea looks sensible to me.  Larry, would it be too 
> much work to have the cvs repository generator generate these files?

So the update of the rsync repo should do something like:

update file1
update repo
update file2

Isn't it? I do not understand how this guarantee coherency:

Kernel.org             Me
                       get file1 (old value)
update file1           get repo-file1 (old value)
update repo-file1
...
update repo-fileJ
...                    get repo-fileJ (new value)
update repo-fileN      get file2 (old value)
update file2




- Davide



