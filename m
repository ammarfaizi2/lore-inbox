Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261380AbTCOKwg>; Sat, 15 Mar 2003 05:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261381AbTCOKwg>; Sat, 15 Mar 2003 05:52:36 -0500
Received: from packet.digeo.com ([12.110.80.53]:48264 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261380AbTCOKwf>;
	Sat, 15 Mar 2003 05:52:35 -0500
Date: Sat, 15 Mar 2003 03:03:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: bzzz@tmi.comex.ru, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [PATCH] remove BKL from ext2's readdir
Message-Id: <20030315030322.792fa598.akpm@digeo.com>
In-Reply-To: <20030315023614.3e28e67b.akpm@digeo.com>
References: <m3vfyluedb.fsf@lexa.home.net>
	<20030315023614.3e28e67b.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Mar 2003 11:03:12.0012 (UTC) FILETIME=[78362CC0:01C2EAE2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
> Alex Tomas <bzzz@tmi.comex.ru> wrote:
> >
> > 
> > hi!
> > 
> > I took a look at readdir() in 2.5.64's ext2 and found it serialized by BKL.
> 
> Yes, I had this in -mm for ages, seem to have lost it.  Also removal of BKL
> from lseek().
> 
> The theory is that the lock is there to avoid f_pos races against lseek.  We
> ended up deciding that the way to address this is to ensure that all readdir
> implementations do:
> 

hm, no.  lseek is using the directory's i_sem now, and readdir runs
under that too.  So we should be able to remove lock_kernel() from
the readdir implementation of all filesystems which are using
generic_file_llseek().
