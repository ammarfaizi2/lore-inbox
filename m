Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313638AbSETMDQ>; Mon, 20 May 2002 08:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315926AbSETMDP>; Mon, 20 May 2002 08:03:15 -0400
Received: from [66.150.46.254] ([66.150.46.254]:63104 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S313638AbSETMDP>;
	Mon, 20 May 2002 08:03:15 -0400
Message-ID: <3CE8E603.8010205@wgate.com>
Date: Mon, 20 May 2002 08:03:15 -0400
From: Michael Sinz <msinz@wgate.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.0rc1) Gecko/20020509
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ganajyoti Bhattacherjee <bgana@cmie.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Data Corruption with Dump
In-Reply-To: <Pine.LNX.4.33.0205201708170.3638-100000@saturn.cmie.ernet.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ganajyoti Bhattacherjee wrote:
> I just happenned to read Linus'opinion on using dump for backup (in a
> mail from him to linux-kernel mailing list on 27 Apr 2001). He wrote
> 
> -------------------------------------------------------------------------
> "...Note that dump simply won't work reliably at all even in 2.4.x: the
> buffer cache and the page cache (where all the actual data is) are not
> coherent. This is only going to get even worse in 2.5.x, when the
> directories are moved into the page cache as well.
> 
> So anybody who depends on "dump" getting backups right is already playing
> russian rulette with their backups.  It's not at all guaranteed to get the
> right results - you may end up having stale data in the buffer cache that
> ends up being "backed up"......"
> ---------------------------------------------------------------------------
> 
> But is the above true even in case of taking "dump" of an unmounted
> filesystem.

No - this was written about mounted filesystems.  Since dump does not go
through the VFS layer and thus does not go through the buffer cache, it
will miss things in an active filesystem.  In a filesystem that is not
mounted (I assume cleanly unmounted) there would be no problem.  To me,
the issue of dump is that it really does not work on a always-up system.
I can not just take the system off-line to backup so the backup mechanisms
I use are all via the file system layer and thus work with the VFS and
page cache and buffer cache rather than around them...

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.


