Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbVDZSzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbVDZSzp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 14:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVDZSzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 14:55:45 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:28045 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261713AbVDZSzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 14:55:35 -0400
In-Reply-To: <20050426100412.GA30762@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: 7eggert@gmx.de, Andrew Morton <akpm@osdl.org>, bulb@ucw.cz,
       hch@infradead.org, jamie@shareable.org, linux-fsdevel@vger.kernel.org,
       linux-fsdevel-owner@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk
MIME-Version: 1.0
Subject: Re: [PATCH] private mounts
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF1B93E71A.E3220FB2-ON88256FEF.005F16B8-88256FEF.00681383@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Tue, 26 Apr 2005 11:55:28 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/26/2005 14:55:32,
	Serialize complete at 04/26/2005 14:55:32
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, Apr 26, 2005 at 03:00:10AM -0700, Andrew Morton wrote:
>> Not as thick as mine!  Could someone please explain in small words 
what's
>> wrong with an suid mount helper?
>
>Nothing per-se.  What makes it bad is the context of a userland 
filesystem
>where the actual filesystem operations in the mounted filesystem happen
>in context of a non-privileged user.

How did the fact that the file access system calls involve user-controlled 
code come into this?  I thought the FUSE kernel code already shielded the 
system from said code to everyone's satisfaction.

We've been talking, rather, about the namespace changes.  The exact same 
issue exists with a non-userspace filesystem where the user controls the 
filesystem contents.  For example, a filesystem on a user-supplied CD.  A 
system administrator -- personally or through his setuid proxy -- might 
want to mount this CD for the benefit of some users/processes/whatever but 
not add it to the global namespace.

The issue of private mounts (mount = namespace change) would be good to 
resolve separately from any problem with bringing user space code into the 
kernel.

BTW, since Miklos said "mount helper" and others have said "mount 
wrapper," I think some of us may not be familiar with mount helpers.  It's 
irrelevant to this discussion, but: util-linux 'mount' has a little-known 
feature wherein it can run a filesystem-type-specific program in a child 
process to do some of the mount function.  A "mount wrapper" would be the 
opposite -- a filesystem-type-specific program that runs the generic 
'mount' program in a child process.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
