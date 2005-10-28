Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbVJ1Oya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbVJ1Oya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 10:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030205AbVJ1Oya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 10:54:30 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:36741 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S1030203AbVJ1Oy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 10:54:29 -0400
Date: Fri, 28 Oct 2005 10:54:15 -0400
Message-Id: <200510281454.j9SEsF4N031395@agora.fsl.cs.sunysb.edu>
From: Erez Zadok <ezk@cs.sunysb.edu>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, hooanon05@yahoo.co.jp,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Unionfs mailing list <unionfs@fsl.cs.sunysb.edu>
Subject: Re: [Unionfs] Re: NFS Permission denied instead of EROFS 
In-reply-to: Your message of "Fri, 28 Oct 2005 08:48:50 +0200."
             <Pine.LNX.4.61.0510280843340.6910@yvahk01.tjqt.qr> 
X-MailKey: Erez_Zadok
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.61.0510280843340.6910@yvahk01.tjqt.qr>, Jan Engelhardt writes:

> >How would knfsd or mountd know? There is no way for the client to
> >communicate to the server that it is mounting for read-write.
> 
> What, the client does not pass the ro/rw flag along? Humm.

NFSv2/3 has no such flags I know of to pass during MOUNT.

> But knfsd knows that a certain export is ro, and therefore should return
> EROFS for all write operations that it receives.

That it probably should.  It's more correct and consistent w/ what you get
from other file systems mounted ro.

IIRC, other servers (Solaris) _do_ return EROFS.  The best way we can
convince linux-nfs to change this behavior is if the majority of other NFS
servers return EROFS.

> Jan Engelhardt

So it's not clear whether it's even possible for an NFS client to find out
that a server is exporting the f/s read-only.

Even if it were possible, I suspect that some people would still like the
current behavior for the following logic: some times sysadmins want to take
down a file server for a period of time, possibly for emergency maintenance,
and they don't want any nfs client-side user to write anything to that
server (which the client mounted).  So they re-export the f/s as readonly.
Existing clients start getting all sorts of errors but they can't change the
state of the server's disk.  In most cases where I've seen when this
happens, it's some sort of maintenance like replacing a failed disk in a
RAID array: you want the array to rebuild quickly, so you don't want to have
users write new files while it's rebuilding.

Erez.
