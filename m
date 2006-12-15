Return-Path: <linux-kernel-owner+w=401wt.eu-S1753511AbWLOVoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753511AbWLOVoa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbWLOVoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:44:30 -0500
Received: from pat.uio.no ([129.240.10.15]:60440 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753514AbWLOVo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:44:29 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michal Sabala <lkml@saahbs.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061215210642.GI6220@prosiaczek>
References: <20061215023014.GC2721@prosiaczek>
	 <1166199855.5761.34.camel@lade.trondhjem.org>
	 <20061215175030.GG6220@prosiaczek>
	 <1166211884.5761.49.camel@lade.trondhjem.org>
	 <20061215210642.GI6220@prosiaczek>
Content-Type: text/plain
Date: Fri, 15 Dec 2006 16:44:14 -0500
Message-Id: <1166219054.5761.56.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=12.0, autolearn=no, UIO_MAIL_IS_INTERNAL=-5)
X-UiO-SPAM-Test: UIO-GREYLIST 69.241.229.183 spam_score -49 maxlevel 200 minaction 2 bait 0 blacklist 0 greylist 1 ratelimit 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-15 at 15:06 -0600, Michal Sabala wrote:
> On 2006/12/15 at 13:44:44 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> > On Fri, 2006-12-15 at 11:50 -0600, Michal Sabala wrote:
> > > On 2006/12/15 at 10:24:15 Trond Myklebust <trond.myklebust@fys.uio.no> wrote
> > > > On Thu, 2006-12-14 at 20:30 -0600, Michal Sabala wrote:
> > > > > 
> > > > > `cat /proc/*PID*/wchan` for all hanging processes contains page_sync.
> > > > 
> > > > Have you tried an 'echo t >/proc/sysrq-trigger' on a client with one of
> > > > these hanging processes? If so, what does the output look like?
> > > 
> > > Hello Trond,
> > > 
> > > Below is the sysrq trace output for XFree86 which entered the
> > > uninterruptible sleep state on the P4 machine with nfs /home. Please
> > > note that XFree86 does not have any files open in /home - as reported by
> > > `lsof`. Below, I also listed the output of vmstat.
> > 
> > 
> > It is hanging because it is trying to free up memory by reclaiming pages
> > that are held by your mmaped file on NFS. Do you know why NFS is
> > hanging?
> 
> Trond,
> 
> I do not have any indication that it is the server not responding. Other
> applications which have NFS files open are continuing to work while in
> this case XFree86 blocks.
> 
> Also, please note that test-mmap.c has successfully finished execution
> and it is no longer running while XFree86 is still hanging.
> 
> Could this be related to the fact that the nfs mmaped file is unlinked
> before it is ummaped? The .nfsXXXXXXX file disappears from the NFS
> server as soon as test-mmap.c exits.

That shouldn't normally matter. The file won't be deleted until after
the last user has stopped referencing it. However it is true that the
trace you sent indicated that XFree86 was hanging in iput().

> What nfs_debug information would be useful in tracking this
> problem? Is there any other information I can provide you?

Could you just out of interest try 2.6.20-rc1?

Cheers
  Trond

