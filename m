Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282275AbRK2B5i>; Wed, 28 Nov 2001 20:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282277AbRK2B53>; Wed, 28 Nov 2001 20:57:29 -0500
Received: from femail15.sdc1.sfba.home.com ([24.0.95.142]:53748 "EHLO
	femail15.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S282275AbRK2B5V>; Wed, 28 Nov 2001 20:57:21 -0500
Message-ID: <3C0595B5.5B769949@ecf.utoronto.ca>
Date: Wed, 28 Nov 2001 20:56:05 -0500
From: Mark Richards <richard@ecf.utoronto.ca>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-12 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@idb.hist.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Multiplexing filesystem
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca> <3C036A83.F23E6EBE@idb.hist.no> <3C03A702.EBE823C9@ecf.utoronto.ca> <3C04C65D.5614D04A@idb.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:

> Mark Richards wrote:
> [...]
> > I'll look into Coda, but ideally I wouldn't have to copy each file to the local
> > workstation when I use it, only when it is reserved for editing.  Also, I'd like to
> > be able to store the local copy anywhere on the filesystem, if possible.
>
> Worried your drive will fill up?  The files copied to your
> drive is merely copied as a "caching" operation.  They
> still seem to reside at the server - this is totally transparent.
> And of course you can limit this caching - if too many files
> is cached some is simply thrown away.  (Or sent back
> if they were changed.) They will be re-
> loaded automatically if you ever need them again.
>
> If you really want to store them where you want instead of
> transparent access, why bother with a new FS at all?
> (I believe coda lets you specify where the caching
> will happen, if you have several partitions/drives)
>
> Simply run a script that reserves the file (by using
> the permission system) and *copy* it to
> where you want.  Check-in will consist of copying
> the altered file back, and restore normal permissions.
>
> You might even want to run a system like CVS, unless
> there is some special reason for not doing that.

Heh, it's funny that you mention that, because one of the goals of this project is to
access a CVS-like repository as if it were a filesystem.  I suppose that i'm not opposed
to on-disk caching of files; this may improve performance in some cases.  However, the
specific feature I need right now is that a file being modified by one person is
explicitly not seen by other people (they see the original version).  The parts that
need to be transparent to the user are the copying/moving of the file from one place
(network) to another (somewhere else).  Also, files created locally should not be
propagated back to the network unless the users explicitly specifies that they should.
So, this system is not totally transparent to the user (because we can't read the user's
mind to figure out what files (s)he would like to edit or 'check in'), but the
filesystem part of it should be.  Plus, it's important that local files and network
files appear in the same directory side by side, as if they were in the same directory
on the server.

I still haven't had a chance to look at Coda; maybe it does solve my problem, but
probably not quite.

Mark


>
>
> Helge Hafting
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

