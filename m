Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132548AbRDQMbP>; Tue, 17 Apr 2001 08:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132526AbRDQMbF>; Tue, 17 Apr 2001 08:31:05 -0400
Received: from ns.caldera.de ([212.34.180.1]:65285 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S132548AbRDQMay>;
	Tue, 17 Apr 2001 08:30:54 -0400
Date: Tue, 17 Apr 2001 14:30:14 +0200
Message-Id: <200104171230.OAA23346@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: mike@bangstate.com ("Michael L. Welles")
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel space getcwd()? (using current() to find out cwd)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <15067.30060.436790.458922@bangstate.com>
User-Agent: tin/1.4.1-19991201 ("Polish") (UNIX) (Linux/2.2.14 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <15067.30060.436790.458922@bangstate.com> you wrote:
> So, a little ignorance being a dangerous thing, I thought I'd be clever
> and manually reconstruct the full path by walking up
> current->fs->pwd->d_parent and padding d_name to the filename until it
> hits root.
>
> Unfortunatly, this approach causes kernel panics.  e.g., the attached
> code snippet will inevitably bring down the machine if I call it
> during in my replacement open, mkdir, rmdir, unlink routines -- and
> tehy all work fine without itq. 


Use d_path.  NOTE:  the buffer in which the pathname is returned is
the return value of the function and _not_ the buffer you gave to it.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
