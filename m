Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310293AbSCLBTx>; Mon, 11 Mar 2002 20:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310279AbSCLBTn>; Mon, 11 Mar 2002 20:19:43 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:54330 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310291AbSCLBTf>; Mon, 11 Mar 2002 20:19:35 -0500
Date: Tue, 12 Mar 2002 02:20:46 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: oskar@osk.mine.nu, linux-kernel@vger.kernel.org
Subject: Re: directory notifications lost after fork?
Message-ID: <20020312022046.R10413@dualathlon.random>
In-Reply-To: <20020310210802.GA1695@oskar> <20020311112652.E10413@dualathlon.random> <20020312120452.3038c4bc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312120452.3038c4bc.sfr@canb.auug.org.au>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 12:04:52PM +1100, Stephen Rothwell wrote:
> Hi Andrea,
> 
> On Mon, 11 Mar 2002 11:26:52 +0100 Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > On Sun, Mar 10, 2002 at 10:08:02PM +0100, Oskar Liljeblad wrote:
> > > The code snipper demonstrates what I consider a bug in the
> > > dnotify facilities in the kernel. After a fork, all registered
> > > notifications are lost in the process where they originally
> > > where registered (the parent process). "lost" here means that
> > > the signal specified with F_SETSIG fcntl no longer is delivered
> > > when notified.
> > 
> > this should fix your problem:
> > 
> > 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.19pre2aa2/00_dnotify-fl_owner-1
> > 
> > Andrea
> 
> Can you see any reason we should not use hte patch below instead?

If somebody overrides the dnotify on the same file, he should become the
new owner, that's not handled in the below patch.

Secondly I prefer to return -EPERM to userspace if somebody tries to
drop a dnotify that it doesn't own, it gives more information back to
userspace.

On the same lines I would prefer that also a "turning_off" that fails to
find the file in the i_dnotify list , would return an error to be
strictier, but I didn't changed this bit of course.

Andrea
