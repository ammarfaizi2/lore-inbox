Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317337AbSFLWdH>; Wed, 12 Jun 2002 18:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317339AbSFLWdG>; Wed, 12 Jun 2002 18:33:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28932 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317337AbSFLWdG>;
	Wed, 12 Jun 2002 18:33:06 -0400
Date: Wed, 12 Jun 2002 23:33:06 +0100
From: Matthew Wilcox <willy@debian.org>
To: Saurabh Desai <sdesai@austin.ibm.com>
Cc: Matthew Wilcox <willy@debian.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/locks.c: Fix posix locking for threaded tasks
Message-ID: <20020612233306.Z27449@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20020610034843.W27186@parcelfarce.linux.theplanet.co.uk> <E17I4bn-0007Rn-00@the-village.bc.nu> <20020612124536.T27449@parcelfarce.linux.theplanet.co.uk> <3D07C8D0.60B49C6D@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2002 at 05:18:56PM -0500, Saurabh Desai wrote:
> Yes, it's needed for M:N threading library. Here is scenario: Task A
> holds a lock and waiting for some event in library, now task B tries
> to acquire that lock and waits in kernel and this can create a deadlock.
> These tasks are created with CLONE_THREAD (for M:N) flag. 
> This change (removing pid check) may cause problem for 1:1 (linuxthreads),
> where each task has unique pid and tgid. Again, whether that's a right 
> behavior or not is questionable. 
> However, with CLONE_THREAD flag, all tasks shares "tgid" value with unique
> pid and that's why I suggested earlier to change the "fl_pid" from "pid" 
> to "tgid" and it works for both the cases (M:N and 1:1).

But then we have different behaviour for applications which are linked
against a 1:1 library and an M:N library.  That makes no sense.

-- 
Revolutions do not require corporate support.
