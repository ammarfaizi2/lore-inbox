Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVGMU2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVGMU2y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 16:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbVGMU05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 16:26:57 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:22970 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262718AbVGMUZP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 16:25:15 -0400
Subject: Re: supporting functions missing from inotify patch
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org, rml@novell.com
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1121286081.5555.73.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 13 Jul 2005 15:21:21 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I don't see an inode operation for registering inotify events in the fs
>> (there is a file operation for dir_notify to register its events).  In
>> create_watch in fs/inotify.c I expected to see something like:
>Why not use the existing dir_notify method?  No point in adding another.

I did not think that inotify_add_watch called dir_notify.  I don't see a path in which 
calls to add a new inotify watch end up in a call to fcntl_dirnotify or file->dir_notify 
This is for the case in which an app only calls inotify ioctl - ie does not [also] do a call 
to dnotify. 

Without such a call - an app that does your new ioctl to add a watch on a file or directory will
not cause the network/cluster fs to turn on notification on the server since the watch
will be not seen by the client filesystem.

>> I also don't see exports for 
>> 	fsnotify_access
>> 	fsnotify_modify
>> 
>> Without these exports, network and cluster filesystems can't notify the
>> local system about changes.
>>
>Eh?
>
>They are in <linux/fsnotify.h>.

OK - you exported a common underlying function
	inotify_inode_queue_event
under the inline functions which the network/cluster fs would call to notify of remote changes.
That makes sense. I had missed that.



