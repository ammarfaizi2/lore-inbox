Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281922AbRKUQyK>; Wed, 21 Nov 2001 11:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281917AbRKUQyC>; Wed, 21 Nov 2001 11:54:02 -0500
Received: from mta.sara.nl ([145.100.16.144]:45463 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S281904AbRKUQxo>;
	Wed, 21 Nov 2001 11:53:44 -0500
Message-Id: <200111211653.RAA26834@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: Nick LeRoy <nleroy@cs.wisc.edu>, Steffen Persvold <sp@scali.no>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Swap 
In-Reply-To: Message from Mike Fedyk <mfedyk@matchmail.com> 
   of "Tue, 20 Nov 2001 13:44:18 PST." <20011120134418.C4210@mikef-linux.matchmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 21 Nov 2001 17:53:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Nov 20, 2001 at 03:33:28PM -0600, Nick LeRoy wrote:
> > On Tuesday 20 November 2001 15:18, Mike Fedyk wrote:
> > > On Tue, Nov 20, 2001 at 10:05:37PM +0100, Steffen Persvold wrote:
> > > > Christopher Friesen wrote:
> > > > > "Richard B. Johnson" wrote:
> > > > > > On Tue, 20 Nov 2001, Wolfgang Rohdewald wrote:
> > > > > > > On Tuesday 20 November 2001 15:51, J.A. Magallon wrote:
> > > > > > > > When a page is deleted for one executable (because we can re-read
> > > > > > > > it from on-disk binary), it is discarded, not paged out.
> > > > > > >
> > > > > > > What happens if the on-disk binary has changed since loading the
> > > > > > > program? -
> > > > > >
> > > > > > It can't. That's the reason for `install` and other methods of
> > > > > > changing execututable files (mv exe-file exe-file.old ; cp newfile
> > > > > > exe-file). The currently open, and possibly mapped file can be
> > > > > > re-named, but it can't be overwritten.
> > > > >
> > > > > Actually, with NFS (and probably others) it can.  Suppose I change the
> > > > > file on the server, and it's swapped out on a client that has it
> > > > > mounted.  When it swaps back in, it can get the new information.
> > > >
> > > > This sounds really dangerous... What about shared libraries ??
> > >
> > > IIRC (if wrong flame...)
> > >
> > > When you delete an open file, the entry is removed from the directory, but
> > > not unlinked until the file is closed.  This is a standard UNIX semantic.
> > >
> > > Now, if you have a set of processes with shared memory, and one closes, and
> > > another is created to replace, the new process will get the new libraries,
> > > or even new version of the process.  This could/will bring down the entire
> > > set of processes.
> > >
> > > Apps like samba come to mind...
> > 
> > *Any* time that you write to an executing executable, all bets are off.  The 
> > most likely outcome is a big 'ol crash & burn.  With a local FS, Unix 
> > prevents you from shooting yourself in the foot, but with NFS, fire away..  
> > I've done it.  It *does* let you, but...
> > 
> > Solution:  Don't do that.  Shut them all down, on all clients, upgrade the 
> > binaries, then restart the processes on the clients.
> > 
> > As far as the scenerio that you've described, I *think* that it would 
> > actually work.  When the new process is fork()ed, it gets a copy of the file 
> > descriptors from it's parent, so the file is still open to it.  If it the 
> > exec()s, the new image no longer has any real ties to it's parent (at least, 
> > not that are relevant to this).
> > 
> 
> What about processes with shared memory such as samba 2.0?


Cool, isn't it. Thinking of 1000 ways to crash apps. As long as the meaning of 
the bits and bytes in the shm segment does not change with a newer version of 
the app, you're safe. Upgrading in single-user modes makes things a lot safer 
(yes I too usually like to live dangerous....)


-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


