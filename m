Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261603AbVCNAf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVCNAf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 19:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVCNAf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 19:35:26 -0500
Received: from nevyn.them.org ([66.93.172.17]:14569 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261603AbVCNAfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 19:35:17 -0500
Date: Sun, 13 Mar 2005 19:35:12 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Junfeng Yang <yjf@stanford.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [CHECKER] inconsistent NFS stat cache (NFS on ext3, 2.6.11)
Message-ID: <20050314003512.GA16875@nevyn.them.org>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Junfeng Yang <yjf@stanford.edu>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.44.0503120335160.12085-100000@elaine24.Stanford.EDU> <1110690267.24123.7.camel@lade.trondhjem.org> <20050313200412.GA21521@nevyn.them.org> <1110746550.23876.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110746550.23876.8.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2005 at 03:42:29PM -0500, Trond Myklebust wrote:
> su den 13.03.2005 Klokka 15:04 (-0500) skreiv Daniel Jacobowitz:
> 
> > I can't find any documentation about this, but it seems like the same
> > problem that has been causing me headaches lately; when I replace glibc
> > from the server side of an nfsroot, the client has a couple of
> > variously wrong reads before it sees the new files.  If it breaks NFS
> > so badly, why is it the default for the Linux NFS server?
> 
> No, that's a very different issue: you are violating the NFS cache
> consistency rules if you are changing a file that is being held open by
> other machines.
> The correct way to do the above is to use GNU install with the '-b'
> option: that will rename the version of glibc that is in use, and then
> install the new glibc in a different inode.

[closed and/or irrelevant lists removed from CC:]

No, the copy of glibc in question is not in use at the time.  The next
attempt to open it on the client will sometimes generate a "stale NFS
handle" message, or if the open succeeds a read will sometimes return
EIO.  But it sounds like this is a different problem than the original
poster was testing for.

I'm still curious about the answer to my question above :-)

-- 
Daniel Jacobowitz
CodeSourcery, LLC
