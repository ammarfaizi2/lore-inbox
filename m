Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262967AbVD2Uy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbVD2Uy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 16:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVD2Uwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 16:52:30 -0400
Received: from peabody.ximian.com ([130.57.169.10]:40363 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262929AbVD2UvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 16:51:05 -0400
Subject: Re: which ioctls matter across filesystems
From: Robert Love <rml@novell.com>
To: Steve French <smfrench@austin.rr.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
In-Reply-To: <42729D51.5050203@austin.rr.com>
References: <42728964.8000501@austin.rr.com>
	 <1114804426.12692.49.camel@lade.trondhjem.org>
	 <1114805033.6682.150.camel@betsy>  <42729D51.5050203@austin.rr.com>
Content-Type: text/plain
Date: Fri, 29 Apr 2005 16:50:35 -0400
Message-Id: <1114807835.6682.156.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 15:47 -0500, Steve French wrote:

> I am not sure - but it is obviously required that inotify can pass over 
> CIFS (and probably NFS) since change notification is hardest for the 
> user to figure out when they are on a network.   I am not sure how the 
> filesystem can detect that a new watch is added to one of its inodes - 
> it looks like you added an ioctl to a device but I am still reading 
> through your latest patch.   I was looking for something like an inode 
> operation that cifs could hook so the fs could be told when a new watch 
> was added or one was changed.   In any case I need to construct 
> functions somewhat similar to what is in fs/cifs/fcntl.c and need to 
> finish/modify CIFSSMBNotify in fs/cifs/cifssmb.c to map the inotify 
> flags to the flags available in the CIFS network protocol specifications.
> The existing network protocol support for ChangeNotify is more 
> straightforward than you might think and the filter flags & actions that 
> I have at my disposal for implementing notify across the network are in 
> fs/cifs/cifspdu.h already (search for FILE_ACTION_   and FILE_NOTIFY_ if 
> you are curious) but obviously they are similar to what the other Samba 
> team guys have already told you.

So a client adds a watch and the server needs to then physically add the
inotify watch?

If you have a user-space, user-space could just add an inotify watch.

But I guess you live entirely in kernel-space?  Couldn't we just export
our "add watch" interface to you?

	Robert Love


