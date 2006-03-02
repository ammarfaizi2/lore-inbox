Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750722AbWCBDWW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWCBDWW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 22:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWCBDWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 22:22:22 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:34769 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750722AbWCBDWV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 22:22:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eVt1tbHeSxYPHuuE4fLqqh+z+Sx/EZNjxhSAkm4CAXgnNM9FxCOx1KQVc/ZQkcBNTL18lar1NrcmbgEuMtw0K/3mgcgT8bP6haluPq0Pj5pk73N43aeIA4QbskR6gxFcoWMHuHNgpapev26hmChSj29UUoBIBTO993fnQuMLlEo=
Message-ID: <bda6d13a0603011922s2a009b9dl8f91b7a382240d59@mail.gmail.com>
Date: Wed, 1 Mar 2006 19:22:21 -0800
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Possible deadlock in vfs layer, namei.c
In-Reply-To: <bda6d13a0603011901x4b54c5a5jfed30f5fc629a3e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <bda6d13a0603011846s6bfed498ha9fb78c4ba74963c@mail.gmail.com>
	 <20060302025406.GV27946@ftp.linux.org.uk>
	 <bda6d13a0603011901x4b54c5a5jfed30f5fc629a3e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Al Viro <viro@ftp.linux.org.uk> wrote:
> On Wed, Mar 01, 2006 at 06:46:42PM -0800, Joshua Hudson wrote:
> > I've been hunting down various deadlocks caused by hard links to directories.
> > I found one that can happen *without* such things.
>
> > process 1 does: rename("dir/subdir/file", "dir/file")
> > process 2 does: rmdir("dir/subdir")
> >
> > from namei.c (function: lock_rename), rename takes:
> > 1. s_vfs_rename_sem,
> > 2. dir/subdir: p1->d_inode->i_sem
> > 3. dir: p2->d_inode->i_sem
>
> No, it doesn't.  Wrong order - it will take dir before dir/subdir.
> RTFM - Documentation/filesystems/directory-locking is there for
> purpose.
>
Well, bloody stupid of me, didn't notice the slight differences of the
locking in the for loops.
