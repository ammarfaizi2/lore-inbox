Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266977AbTAPP6d>; Thu, 16 Jan 2003 10:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267122AbTAPP6d>; Thu, 16 Jan 2003 10:58:33 -0500
Received: from angband.namesys.com ([212.16.7.85]:35729 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S266977AbTAPP63>; Thu, 16 Jan 2003 10:58:29 -0500
Date: Thu, 16 Jan 2003 19:07:22 +0300
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: linux-kernel@vger.kernel.org, eazgwmir@umail.furryterror.org,
       viro@math.psu.edu, nikita@namesys.com
Subject: Re: [2.4] VFS locking problem during concurrent link/unlink
Message-ID: <20030116190722.A4646@namesys.com>
References: <20030116140015.A17612@namesys.com> <1042731580.31099.2195.camel@tiny.suse.com> <20030116184352.A32192@namesys.com> <1042732927.31100.2205.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1042732927.31100.2205.camel@tiny.suse.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 16, 2003 at 11:02:08AM -0500, Chris Mason wrote:
> > Yes we do.
> > But on the other hand I've put a check at the beginning of reiserfs_link
> > and I am still seeing these links on inodes with i_nlink == 0.
> That's because we don't inc the link count in reiserfs_link before we
> schedule.  The bug works a little like this:
> link count at 1
> reiserfs_link: make new directory entry for link, schedule()
> reiserfs_unlink: dec link count to zero, remove file stat data
> reiserfs_link: inc link count, return thinking the stat data is still
> there

That was my original yesterday's assumption.
But debug prints I put in place did not confirmed it.
Also if we are having a dentry pinned in memory (by sys_link), inode should not
be deleted, so the statdata should stay inplace as Nikita argues.

Bye,
    Oleg
