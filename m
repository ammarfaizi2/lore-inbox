Return-Path: <linux-kernel-owner+w=401wt.eu-S965003AbWLOVGu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWLOVGu (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWLOVGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:06:50 -0500
Received: from smtp.saahbs.net ([70.235.213.234]:34726 "HELO smtp.saahbs.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965003AbWLOVGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:06:49 -0500
Date: Fri, 15 Dec 2006 15:06:42 -0600
From: Michal Sabala <lkml@saahbs.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18 mmap hangs unrelated apps
Message-ID: <20061215210642.GI6220@prosiaczek>
References: <20061215023014.GC2721@prosiaczek> <1166199855.5761.34.camel@lade.trondhjem.org> <20061215175030.GG6220@prosiaczek> <1166211884.5761.49.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <1166211884.5761.49.camel@lade.trondhjem.org>
X-WWW: http://www.saahbs.net
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006/12/15 at 13:44:44 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> On Fri, 2006-12-15 at 11:50 -0600, Michal Sabala wrote:
> > On 2006/12/15 at 10:24:15 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> > > On Thu, 2006-12-14 at 20:30 -0600, Michal Sabala wrote:
> > > > 
> > > > `cat /proc/*PID*/wchan` for all hanging processes contains page_sync.
> > > 
> > > Have you tried an 'echo t >/proc/sysrq-trigger' on a client with one of
> > > these hanging processes? If so, what does the output look like?
> > 
> > Hello Trond,
> > 
> > Below is the sysrq trace output for XFree86 which entered the
> > uninterruptible sleep state on the P4 machine with nfs /home. Please
> > note that XFree86 does not have any files open in /home - as reported by
> > `lsof`. Below, I also listed the output of vmstat.
> 
> 
> It is hanging because it is trying to free up memory by reclaiming pages
> that are held by your mmaped file on NFS. Do you know why NFS is
> hanging?

Trond,

I do not have any indication that it is the server not responding. Other
applications which have NFS files open are continuing to work while in
this case XFree86 blocks.

Also, please note that test-mmap.c has successfully finished execution
and it is no longer running while XFree86 is still hanging.

Could this be related to the fact that the nfs mmaped file is unlinked
before it is ummaped? The .nfsXXXXXXX file disappears from the NFS
server as soon as test-mmap.c exits.

What nfs_debug information would be useful in tracking this
problem? Is there any other information I can provide you?

Thank You,
 Sincerely,

   Michal


--
Michal "Saahbs" Sabala
