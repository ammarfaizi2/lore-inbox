Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270847AbRIAROU>; Sat, 1 Sep 2001 13:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270848AbRIAROC>; Sat, 1 Sep 2001 13:14:02 -0400
Received: from femail25.sdc1.sfba.home.com ([24.254.60.15]:50346 "EHLO
	femail25.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S270841AbRIARNj>; Sat, 1 Sep 2001 13:13:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Alexander Viro <viro@math.psu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Subject: Re: [RFD] readonly/read-write semantics
Date: Sat, 1 Sep 2001 10:13:18 -0700
X-Mailer: KMail [version 1.2]
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0109011226580.18705-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109011226580.18705-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Message-Id: <01090110131802.00171@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 01 September 2001 09:44 am, Alexander Viro wrote:
> On Sat, 1 Sep 2001, Ingo Oeser wrote:
> > On Sat, Sep 01, 2001 at 12:23:05AM -0400, Alexander Viro wrote:
> > > > 2) I'd like to see a readonly mount state defined as "the
> > > > filesystem will not change.  Period."  Not for system calls in
> > > > progress, not for cache synchronization, not to set an
> > > > "unmounted" flag, not for writes that are queued in the device
> > > > driver or device.  (That last one may stretch feasability, but
> > > > it's a worthy goal anyway).
> > >
> > > It doesn't work.  Think of r/o mounting of remote filesystem.  Do
> > > you suggest that it should make it impossible to change from other
> > > clients?
> >
> > It's sufficient for local file systems. Or see it this way: The
> > machine, that mounted it r/o will NOT write to it until it is
> > mounted r/w again.
>
> That's _also_ not true for remote filesystems.  We can mount the same
> filesystem over NFS again without unmounting the old instance.  Always
> could.
>
> IMO a part of the problem is that we are mixing "I'm not asking that
> to be writable" with "I won't let you write".  The former belongs
> to the mounting side, the latter - to filesystem.

It's really a band-aid, I seriously doubt anybody is going to claim that 
it's "perfect".
The state that he (and I for that matter) want is "This is mounted, we 
can read from it, but under *NO CIRCUMSTANCES* will we change the 
filesystem through this mount, ever."
In addition to the filesystem-stamping-its-foot situation, this could 
help if someone is testing a new, potentialy unstable driver (filesystem 
or block device) and wants to stop all writes IMMIEDIATELY so that they 
can check the data present on that filesystem/device.

Again, this isn't perfect, but I think it would have many potential uses 
(filesystem error would probably be the most useful application) and 
really should have been implimented long ago.
