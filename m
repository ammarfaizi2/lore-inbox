Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281156AbRKOXFv>; Thu, 15 Nov 2001 18:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281157AbRKOXFc>; Thu, 15 Nov 2001 18:05:32 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:51960 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S281156AbRKOXFV>; Thu, 15 Nov 2001 18:05:21 -0500
Date: Thu, 15 Nov 2001 23:05:14 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
        Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: synchronous mounts
Message-ID: <20011115230514.T1914@redhat.com>
In-Reply-To: <3BF376EC.EA9B03C8@zip.com.au>, <3BF376EC.EA9B03C8@zip.com.au>; <20011115214525.C14221@redhat.com> <3BF43B8E.51A809D1@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BF43B8E.51A809D1@zip.com.au>; from akpm@zip.com.au on Thu, Nov 15, 2001 at 02:02:54PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 15, 2001 at 02:02:54PM -0800, Andrew Morton wrote:
> 
> So shall we try to nail this down?  Synchronous mounts and chattr +S
> provide synchronous semantics for directory contents, diretory metadata
> and directory inodes only.  And fsync() will write out a file's data,
> metadata and inode?

Sounds sane.  UFS sync mounts also update the inode bitmaps
synchronously, and in order, so that they can tell exactly when an
inode is valid.  I guess that we don't need that, at least on ext2,
since the i_dtime gives us the necessary information automatically.

> If this is correct then there are a few places where ext2 is
> syncing stuff unnecessarily - file indirect blocks, etc.  Not
> very important at this stage I guess.

It's important for people running MTAs which expect dir sync
behaviour: admins have to pay the performance cost of all file updates
being sync as well as the directory updates if they enable chattr +S
on the dir.

--Stephen
