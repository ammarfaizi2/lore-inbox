Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbTCOUAj>; Sat, 15 Mar 2003 15:00:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261503AbTCOUAj>; Sat, 15 Mar 2003 15:00:39 -0500
Received: from packet.digeo.com ([12.110.80.53]:37006 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261502AbTCOUAi>;
	Sat, 15 Mar 2003 15:00:38 -0500
Date: Sat, 15 Mar 2003 12:11:25 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alex Tomas <bzzz@tmi.comex.ru>
Cc: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove BKL from ext2's readdir
Message-Id: <20030315121125.48294975.akpm@digeo.com>
In-Reply-To: <m3wuj0fvls.fsf@lexa.home.net>
References: <m3vfyluedb.fsf@lexa.home.net>
	<20030315023614.3e28e67b.akpm@digeo.com>
	<20030315030322.792fa598.akpm@digeo.com>
	<m3wuj0fvls.fsf@lexa.home.net>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 20:11:11.0731 (UTC) FILETIME=[060D2430:01C2EB2F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas <bzzz@tmi.comex.ru> wrote:
>
> >>>>> Andrew Morton (AM) writes:
> 
>  AM> hm, no.  lseek is using the directory's i_sem now, and readdir
>  AM> runs under that too.  So we should be able to remove
>  AM> lock_kernel() from the readdir implementation of all filesystems
>  AM> which are using generic_file_llseek().
> 
> looks like only coda and ntfs use generic_file_llseek(). other use
> default_llseek(). what's the reason do not use generic_file_llseek().
> historical only? or not?

grep again.

I've made the change to ext2 and ext3.  Other filesystems will require
some thought to verify that the lock_kernel()s are not protecting
against some other random codepath.
