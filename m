Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbUKWViU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbUKWViU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbUKWRoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 12:44:05 -0500
Received: from unthought.net ([212.97.129.88]:27343 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261380AbUKWRCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 12:02:24 -0500
Date: Tue, 23 Nov 2004 18:02:23 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Phil Dier <phil@dier.us>
Cc: linux-kernel@vger.kernel.org, Scott Holdren <scott@icglink.com>,
       ziggy <ziggy@icglink.com>, Jack Massari <webmaster@icglink.com>
Subject: Re: oops with dual xeon 2.8ghz  4gb ram +smp, software raid, lvm, and xfs
Message-ID: <20041123170222.GS4469@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Phil Dier <phil@dier.us>, linux-kernel@vger.kernel.org,
	Scott Holdren <scott@icglink.com>, ziggy <ziggy@icglink.com>,
	Jack Massari <webmaster@icglink.com>
References: <20041122130622.27edf3e6.phil@dier.us> <20041122161725.21adb932.akpm@osdl.org> <20041123093744.25c09245.phil@dier.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123093744.25c09245.phil@dier.us>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 09:37:44AM -0600, Phil Dier wrote:
...
> I'm building this system with stability and flexibility foremost in
> mind. Am I foolish in using all of these technologies with a new-ish
> version of 2.6? Is there a particular version that would be better
> suited for my application? Any other suggestions you (or anyone else
> on the list) could give regarding stability would be greatly appreciated.

If you'll be exporting via. NFS, it seems that there are still problems
with XFS+NFS.

With SMP, what I see is that sometimes a directory might decide that
it's a file - but I can't delete it, becuase it isn't 'empty' (it's
still somehow a directory).  Waiting a day or two, the system will
change its mind back to letting the directory be a directory. Sometimes
modes will be fscked up as well - a regular file can change owner, or it
can change modes from '-rw-rw---' to '?---------'.    Weird stuff, no
way to reproduce it reliably.

With UP, I know someone who's seeing stale handles reported by the NFS
server. The only known workaround is to stat the directories in question
on the *server* side - a little bash with 'while true; sleep 5; ls -l
/directory; do' will do the trick.

All of what I describe here are production environments - so it sucks to
have that kind of problems.  Some of it can be reproduced (the stale
handle errors), and some of it can't.

I guess the good news would be, that I don't know of any problems with
XFS+LVM+MD if you do not export the FS via. NFS    :)

That is, if you run 2.6.9.  Any earlier kernel will b0rk your XFS under
load.

-- 

 / jakob

