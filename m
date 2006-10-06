Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932571AbWJFUNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWJFUNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 16:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWJFUNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 16:13:18 -0400
Received: from 1-1-5-8a.ehn.lk.bostream.se ([82.183.137.225]:47857 "EHLO
	1-1-5-8a.ehn.lk.bostream.se") by vger.kernel.org with ESMTP
	id S932571AbWJFUNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 16:13:17 -0400
Date: Fri, 6 Oct 2006 22:13:14 +0200
From: Henrik Carlqvist <Henrik@LinkopingJudo.org>
To: linux-kernel@vger.kernel.org
Cc: mark.fasheh@oracle.com
Subject: Re: ocfs2 problem with nfs v2
Message-Id: <20061006221314.0b961635.Henrik@LinkopingJudo.org>
In-Reply-To: <20060914202423.56314cf5.hc8@uthyres.com>
References: <20060913223320.008bdcf7.hc8@uthyres.com>
	<20060914202423.56314cf5.hc8@uthyres.com>
Organization: =?ISO-8859-1?Q?Link=F6ping?= Judo
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Carlqvist <hc8@uthyres.com> wrote:
> Using NFS v3 in Slackware 9.1 the server works fine, but with NFS v2 I
> was able to repeat the bug.
> 
> This is what it looks like on the NFS client:

> # mount -o nfsvers=2 ekorrapa:/san/old /mnt/hd/ 

> # ls -al /mnt/hd/ 
> ls:/mnt/hd/lost+found: Input/output error 
> ls: /mnt/hd/1: Input/output error
> ls: /mnt/hd/2: Input/output error

> However, on the NFS server things look exactly the same as before:
> Sep 14 10:53:23 kattapa kernel: (5380,0):ocfs2_encode_fh:155 ERROR: fh
> buffer is too small for encoding 

This message is posted only to make this thread useful by others which
encounter the same problem. The problem got into bugzilla at
http://oss.oracle.com/bugzilla/show_bug.cgi?id=777 but unfortunately
because of limitations in NFS v2 it would be very hard to make ocfs2 to
work with the default settings of an NFS v2 server.

One solution to the problem is to export with the no_subtree_check
option. This solution has some mild security implications so reading
and understanding the manpage of exportfs should be done before trying
this. With the no_subtree_check option NFS v2 clients are able to use
mounts directly from the NFS server with ocfs2.

Another workaround is to configure an "NFS proxy" which does NFS v3 mounts
from the server with ocfs2 and then reexports those mounts with NFS v2. To
be able to reexport an NFS mounted directory a user space NFS server is
needed. I have tried the old and obsolete server from
http://sourceforge.net/projects/unfs which was able to do NFS v2 reexports
of NFS v3 mounted directories from the NFS v3 server with ocfs2.

regards Henrik
