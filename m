Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRCMJ1t>; Tue, 13 Mar 2001 04:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbRCMJ1j>; Tue, 13 Mar 2001 04:27:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:58809 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129854AbRCMJ1W>;
	Tue, 13 Mar 2001 04:27:22 -0500
Date: Tue, 13 Mar 2001 04:26:29 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: named pipe writes on readonly filesystems
In-Reply-To: <20010313102224.A17224@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.GSO.4.21.0103130424240.28460-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 13 Mar 2001, Ingo Oeser wrote:

> On Mon, Mar 12, 2001 at 09:15:33PM -0500, Alexander Viro wrote:
> > On Mon, 12 Mar 2001, Chris Mason wrote:
> > > Since fs/pipe.c:pipe_write() calls mark_inode_dirty, and it is legal to
> > > write to a named pipe on a readonly filesystem, we can end up writing an
> > > inode on a readonly FS.
> > 
> > I would check that in pipe_write()...
> 
> So atime and mtime of a named pipe are meaningless in general?
> That would make sense, since you cannot access the data anymore,
> once they are through the pipe.

Huh? They are meaningless if fs is read-only. Can't change inode in
such situation... For normal filesystems it's "how long ago somebody
did <type of access> with this FIFO".

