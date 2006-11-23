Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933283AbWKWIvA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933283AbWKWIvA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933284AbWKWIvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:51:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:16283 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S933283AbWKWIu7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:50:59 -0500
Date: Thu, 23 Nov 2006 08:50:56 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
Cc: Greg KH <greg@kroah.com>, ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] libfs : file/directory removal fix, 2.6.18
Message-ID: <20061123085056.GJ3078@ftp.linux.org.uk>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123082244.GF1703@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061123082244.GF1703@Krystal>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 03:22:44AM -0500, Mathieu Desnoyers wrote:
> Fix file and directory removal in libfs. Add inotify support for file removal.
> 
> The following scenario :
> create dir a
> create dir a/b
> 
> cd a/b (some process goes in cwd a/b)
> 
> rmdir a/b
> rmdir a
>
> fails due to the fact that "a" appears to be non empty.

What?  Caller will do d_delete() itself.  Care to show a version where
that would happen and post an strace of the second rmdir?

> It is because the "b"
> dentry is not deleted from "a" and still in use. The same problem happens if
> "b" is a file. d_delete is nice enough to know when it needs to unhash and free
> the dentry if nothing else is using it or, if someone is using it, to remove it
> from the hash queues and wait for it to be deleted when it has no users.
> 
> The nice side-effect of this fix is that it calls the file removal
> notification.

NAK.  First of all, I won't believe you without actual strace.

What's more, WTF would fs _method_ call idiotify?  Keep that crap
out of filesystems; caller will do it for us just fine.
