Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281471AbRKTXH7>; Tue, 20 Nov 2001 18:07:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281475AbRKTXHv>; Tue, 20 Nov 2001 18:07:51 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:44293 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S281471AbRKTXHg>; Tue, 20 Nov 2001 18:07:36 -0500
Message-Id: <200111202201.fAKM1At18356@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Mike Fedyk <mfedyk@matchmail.com>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 16:00:10 -0600
X-Mailer: KMail [version 1.3.1]
Cc: Steffen Persvold <sp@scali.no>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        root@chaos.analogic.com, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011120111730.7650A-100000@chaos.analogic.com> <200111202134.fAKLYSt15090@schroeder.cs.wisc.edu> <20011120134418.C4210@mikef-linux.matchmail.com>
In-Reply-To: <20011120134418.C4210@mikef-linux.matchmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 November 2001 15:44, Mike Fedyk wrote:

<SNIP>

> > *Any* time that you write to an executing executable, all bets are off. 
> > The most likely outcome is a big 'ol crash & burn.  With a local FS, Unix
> > prevents you from shooting yourself in the foot, but with NFS, fire
> > away.. I've done it.  It *does* let you, but...
> >
> > Solution:  Don't do that.  Shut them all down, on all clients, upgrade
> > the binaries, then restart the processes on the clients.
> >
> > As far as the scenerio that you've described, I *think* that it would
> > actually work.  When the new process is fork()ed, it gets a copy of the
> > file descriptors from it's parent, so the file is still open to it.  If
> > it the exec()s, the new image no longer has any real ties to it's parent
> > (at least, not that are relevant to this).
>
> What about processes with shared memory such as samba 2.0?

fork()ed processes are *identical* to their parents execept for the return 
value from fork().  They have the same shared memory handles, file 
descriptors, etc.  The kernel "knows" that there's an extra copy of each, and 
updates it's link counts, etc.

Actually, the real point is that it'll still be the old executable running 
with the old libraries, until you shut down the whole group.  Each of the 
processes are "linked" to the original file, so the new version will never 
run 'til the whole group is restarted.

It should just work.  I can't think of any reason why it shouldn't.

-Nick
