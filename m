Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261483AbUKWSlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261483AbUKWSlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261489AbUKWSka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:40:30 -0500
Received: from iris.icglink.com ([216.183.105.244]:50904 "HELO
	iris.icglink.com") by vger.kernel.org with SMTP id S261483AbUKWS30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:29:26 -0500
Date: Tue, 23 Nov 2004 12:29:24 -0600
From: Phil Dier <phil@dier.us>
To: linux-kernel@vger.kernel.org
Cc: scott@icglink.com, ziggy@icglink.com, webmaster@icglink.com
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm,
 and xfs
Message-Id: <20041123122924.1137ebdb.phil@dier.us>
In-Reply-To: <20041123170222.GS4469@unthought.net>
References: <20041122130622.27edf3e6.phil@dier.us>
	<20041122161725.21adb932.akpm@osdl.org>
	<20041123093744.25c09245.phil@dier.us>
	<20041123170222.GS4469@unthought.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 18:02:23 +0100
Jakob Oestergaard <jakob@unthought.net> wrote:

> If you'll be exporting via. NFS, it seems that there are still problems
> with XFS+NFS.
> 
> With SMP, what I see is that sometimes a directory might decide that
> it's a file - but I can't delete it, becuase it isn't 'empty' (it's
> still somehow a directory).  Waiting a day or two, the system will
> change its mind back to letting the directory be a directory. Sometimes
> modes will be fscked up as well - a regular file can change owner, or it
> can change modes from '-rw-rw---' to '?---------'.    Weird stuff, no
> way to reproduce it reliably.
> 
> With UP, I know someone who's seeing stale handles reported by the NFS
> server. The only known workaround is to stat the directories in question
> on the *server* side - a little bash with 'while true; sleep 5; ls -l
> /directory; do' will do the trick.
> 
> All of what I describe here are production environments - so it sucks to
> have that kind of problems.  Some of it can be reproduced (the stale
> handle errors), and some of it can't.
> 
> I guess the good news would be, that I don't know of any problems with
> XFS+LVM+MD if you do not export the FS via. NFS    :)
> 
> That is, if you run 2.6.9.  Any earlier kernel will b0rk your XFS under
> load.

Thanks for the tips, Jakob.

I *will* be exporting via NFS, so this is definetly good to know. I've
been looking at using jfs and reiser as well, but some preliminary
benchmarks suggested that xfs was the best performer for the kind of
workload that I'm anticipating. I guess xfs is out of the question now,
as I definetly don't want to deal with weird interactions like that.

Can anyone speak on the stability of (reiser|jfs|other) with nfs? My
biggest requirements are online resizing and stability (ext3 online
resize is still beta IIRC, but I wouldn't be opposed to using it if
someone could tell me otherwise); speed would be nice, but I'm willing
to sacrifice speed for the sake of reliability.

I'm personally using lvm + reiser + nfs without consequence on my
fileserver at home, but it's not seeing nearly the loads that this box
is going to see.

Thanks again,
--

Phil Dier (ICGLink.com -- 615 370-1530 x733)

/* vim:set noai nocindent ts=8 sw=8: */
