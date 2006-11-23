Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757448AbWKWR2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757448AbWKWR2f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757444AbWKWR2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:28:34 -0500
Received: from tomts36-srv.bellnexxia.net ([209.226.175.93]:12012 "EHLO
	tomts36-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1757448AbWKWR2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:28:33 -0500
Date: Thu, 23 Nov 2006 12:28:28 -0500
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Greg KH <greg@kroah.com>, ltt-dev@shafik.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] libfs : file/directory removal fix, 2.6.18
Message-ID: <20061123172828.GB14803@Krystal>
References: <20061120181838.GB7328@Krystal> <20061122052730.GD20836@kroah.com> <20061123082244.GF1703@Krystal> <20061123085056.GJ3078@ftp.linux.org.uk> <20061123090116.GK3078@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <20061123090116.GK3078@ftp.linux.org.uk>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:26:18 up 92 days, 14:34,  3 users,  load average: 1.83, 1.29, 1.25
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Al Viro (viro@ftp.linux.org.uk) wrote:
> On Thu, Nov 23, 2006 at 08:50:56AM +0000, Al Viro wrote:
> > On Thu, Nov 23, 2006 at 03:22:44AM -0500, Mathieu Desnoyers wrote:
> > > Fix file and directory removal in libfs. Add inotify support for file removal.
> > > 
> > > The following scenario :
> > > create dir a
> > > create dir a/b
> > > 
> > > cd a/b (some process goes in cwd a/b)
> > > 
> > > rmdir a/b
> > > rmdir a
> > >
> > > fails due to the fact that "a" appears to be non empty.
> > 
> > What?  Caller will do d_delete() itself.  Care to show a version where
> > that would happen and post an strace of the second rmdir?
> > 
> > > It is because the "b"
> > > dentry is not deleted from "a" and still in use. The same problem happens if
> > > "b" is a file. d_delete is nice enough to know when it needs to unhash and free
> > > the dentry if nothing else is using it or, if someone is using it, to remove it
> > > from the hash queues and wait for it to be deleted when it has no users.
> > > 
> > > The nice side-effect of this fix is that it calls the file removal
> > > notification.
> > 
> > NAK.  First of all, I won't believe you without actual strace.
> > 
> > What's more, WTF would fs _method_ call idiotify?  Keep that crap
> > out of filesystems; caller will do it for us just fine.
> 
> PS: debugfs, sysfs et sodding alia should take care to do things equivalent
> to vfs_unlink(), etc.  _That_ is definitive user of fs methods, which, in
> turn, sets the rules for library helpers used by such.
> 

Ok, I will tweak my modification so it sits in debugfs then.

Thanks,

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
