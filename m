Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262757AbVGMUmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262757AbVGMUmN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262791AbVGMUmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:42:00 -0400
Received: from peabody.ximian.com ([130.57.169.10]:9607 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S262757AbVGMUkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:40:16 -0400
Subject: Re: supporting functions missing from inotify patch
From: Robert Love <rml@novell.com>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1121286081.5555.73.camel@stevef95.austin.ibm.com>
References: <1121286081.5555.73.camel@stevef95.austin.ibm.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 16:39:49 -0400
Message-Id: <1121287189.6384.57.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 15:21 -0500, Steve French wrote:

> I did not think that inotify_add_watch called dir_notify.  I don't see a path in which 
> calls to add a new inotify watch end up in a call to fcntl_dirnotify or file->dir_notify 
> This is for the case in which an app only calls inotify ioctl - ie does not [also] do a call 
> to dnotify. 

No, you are right, they do not, right now.

Is dir_notify suitable for inotify and your uses?  In the 10 months of
inotify development, I had hoped that a remote filesystem developer
would add support so we could test it.  But there is no rush to get this
hook added, so its okay.

The problem with dir_notify is that the args parameter is dnotify flags.
Those don't map directly to inotify flags.

What I'd like is

	(a) a patch adding the requisite inotify hook (really, 4 lines)
	(b) a filesystem successfully using the hook

> Without such a call - an app that does your new ioctl to add a watch on a file or directory will
> not cause the network/cluster fs to turn on notification on the server since the watch
> will be not seen by the client filesystem.

It is a system call, now.  ;-)

> OK - you exported a common underlying function
> 	inotify_inode_queue_event
> under the inline functions which the network/cluster fs would call to notify of remote changes.
> That makes sense. I had missed that.

Nod.

	Robert Love


