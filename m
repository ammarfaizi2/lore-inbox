Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTKWTnn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Nov 2003 14:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTKWTnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Nov 2003 14:43:43 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:42944 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263427AbTKWTnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Nov 2003 14:43:41 -0500
From: Juergen Hasch <lkml@elbonia.de>
To: Andreas Dilger <adilger@clusterfs.com>
Subject: Re: Using get_cwd inside a module.
Date: Sun, 23 Nov 2003 20:41:58 +0100
User-Agent: KMail/1.5.4
References: <3FBEA83B.1060001@bangstate.com> <20031122101559.A30932@infradead.org> <20031122044833.R20568@schatzie.adilger.int>
In-Reply-To: <20031122044833.R20568@schatzie.adilger.int>
Cc: Christoph Hellwig <hch@infradead.org>, Michael Welles <mike@bangstate.com>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311232041.58397.lkml@elbonia.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:464ad01b81b0f762cd239ce6f3ab8323
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 22. November 2003 12:48 schrieb Andreas Dilger:
> On Nov 22, 2003  10:15 +0000, Christoph Hellwig wrote:
> > On Sat, Nov 22, 2003 at 10:33:34AM +0100, Juergen Hasch wrote:
> > > Dnotify doesn't return the file names that changed, changedfiles does.
> > > I've looked into this, because Samba would benefit from such a
> > > functionality.
> > >
> > > So maybe it would be possible to teach dnotify to return file names
> > > (e.g. using netlink) ?
> >
> > Well, you can't return filenames.  There's no unique path to a give
> > file.
>
> Since the caller is already watching a specific directory, it doesn't
> need to know the full pathname, just the inode number that changed.
> Then Samba et. al. could do an inode->name(s) lookup on the directory.

As the kernel would need to communicate with userspace anyway, I believe
getting the file name directly from the kernel shouldn't be too much to
ask for. The kernel already knows it and we save the lookup operation in
userspace that is needed each time we receive an event.

However getting inode and event type would still be a huge improvement, 
because right now we have to stat all files in a directory and compare
it with a stored version, to find out what happend.

...Juergen
 

