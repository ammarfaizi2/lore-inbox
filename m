Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWHVDdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWHVDdb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 23:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbWHVDdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 23:33:31 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:57022 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP
	id S1751184AbWHVDda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 23:33:30 -0400
Date: Tue, 22 Aug 2006 11:29:29 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list
 [try #2]
In-Reply-To: <15387.1156173472@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0608221124420.4543@raven.themaw.net>
References: <Pine.LNX.4.64.0608212112350.28902@raven.themaw.net> 
 <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net>
 <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net> <20060819094840.083026fd.akpm@osdl.org>
 <13319.1155744959@warthog.cambridge.redhat.com> <1155743399.5683.13.camel@localhost>
 <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org>
 <5910.1155741329@warthog.cambridge.redhat.com> <2138.1155893924@warthog.cambridge.redhat.com>
 <3976.1156079732@warthog.cambridge.redhat.com> <30856.1156153373@warthog.cambridge.redhat.com>
 <323.1156162567@warthog.cambridge.redhat.com>  <15387.1156173472@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006, David Howells wrote:

> 
> The NFS client's automounting facilities handle automatic expiration and
> implicit recursive unmounting of xdev submounts.
> 
> For example, on my test machine:
> 
> 	[root@andromeda ~]# /root/mount warthog:/ /warthog -o fsc
> 	[root@andromeda ~]# ls /warthog/warthog
> 	[root@andromeda ~]# cat /proc/mounts 
> 	...
> 	warthog:/ /warthog nfs rw,vers=3,rsize=32768,wsize=32768,hard,fsc,proto=tcp,timeo=600,retrans=2,sec=sys,addr=warthog 0 0
> 	warthog:/warthog /warthog/warthog nfs rw,vers=3,rsize=32768,wsize=32768,hard,fsc,proto=tcp,timeo=600,retrans=2,sec=sys,addr=warthog 0 0
> 	[root@andromeda ~]# umount /warthog/
> 	[root@andromeda ~]# 
> 
> The "ls" command caused the client to mount warthog:/warthog off of the server
> onto /warthog/warthog automatically.  I was then able to just unmount
> /warthog, which took away /warthog/warthog also without me having to do
> anything special.
> 

This is going to be fun after all.

There isn't any way to tell a nohide from a non-nohide mount from the 
expots list.
There are inconsistencies with the contents of /proc/mounts between OS 
versions (perhaps kernel version).
There is no way to tell a nohide mounted filesystem from the output of 
/proc/mounts if it does happen to appear in it.

*sigh*

Ian

