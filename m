Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289092AbSAGC70>; Sun, 6 Jan 2002 21:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289094AbSAGC7R>; Sun, 6 Jan 2002 21:59:17 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:12814 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289092AbSAGC7D>; Sun, 6 Jan 2002 21:59:03 -0500
Message-ID: <3C390DAA.3339768C@zip.com.au>
Date: Sun, 06 Jan 2002 18:53:30 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Alexander Viro <viro@math.psu.edu>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate fixes
In-Reply-To: <3C36DEA9.AEA2A402@zip.com.au>,
		<3C36DEA9.AEA2A402@zip.com.au>; from akpm@zip.com.au on Sat, Jan 05, 2002 at 03:08:25AM -0800 <20020107034654.G1561@athlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> I prefer my fix that simply recalls the ->truncate callback if -ENOSPC
> is returned by prepare_write. vmtruncate seems way overkill,

No opinion on that here.  This is what was in -ac.  Perhaps Al can
comment?

> and after
> calling ->truncate the __block_prepare_changes above won't be necessary
> because the leftover will be correctly deallocated (no need to clear
> them out and to mark them dirty, they will just go away before any
> readpage can see them).

No, this code is needed if the write is _inside_ i_size, to an
uninstantiated block.  truncate won't remove those blocks, and we've
gone and added them to the file.

-
