Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130638AbRBGAsM>; Tue, 6 Feb 2001 19:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130678AbRBGAsC>; Tue, 6 Feb 2001 19:48:02 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:57617 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S130638AbRBGArt>; Tue, 6 Feb 2001 19:47:49 -0500
Date: Tue, 6 Feb 2001 18:42:28 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@elte.hu>,
        Ben LaHaise <bcrl@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kiobuf-io-devel@lists.sourceforge.net
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
Message-ID: <20010206184228.A23674@vger.timpanogas.org>
In-Reply-To: <20010207002107.L1167@redhat.com> <Pine.LNX.4.32.0102061924300.24366-100000@devserv.devel.redhat.com> <20010207003629.M1167@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010207003629.M1167@redhat.com>; from sct@redhat.com on Wed, Feb 07, 2001 at 12:36:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 12:36:29AM +0000, Stephen C. Tweedie wrote:
> Hi,
> 
> On Tue, Feb 06, 2001 at 07:25:19PM -0500, Ingo Molnar wrote:
> > 
> > On Wed, 7 Feb 2001, Stephen C. Tweedie wrote:
> > 
> > > No, it is a problem of the ll_rw_block interface: buffer_heads need to
> > > be aligned on disk at a multiple of their buffer size.  Under the Unix
> > > raw IO interface it is perfectly legal to begin a 128kB IO at offset
> > > 512 bytes into a device.
> > 
> > then we should either fix this limitation, or the raw IO code should split
> > the request up into several, variable-size bhs, so that the range is
> > filled out optimally with aligned bhs.
> 
> That gets us from 512-byte blocks to 4k, but no more (ll_rw_block
> enforces a single blocksize on all requests but that relaxing that
> requirement is no big deal).  Buffer_heads can't deal with data which
> spans more than a page right now.


I can handle requests larger than a page (64K) but I am not using 
the buffer cache in Linux.  We really need an NT/NetWare like model 
to support the non-Unix FS's properly.

i.e.   

a disk request should be 

<disk> <lba> <length> <buffer> and get rid of this fixed block 
stuff with buffer heads. :-)

I understand that the way the elevator is implemented in Linux makes
this very hard at this point to support, since it's very troublesome 
to handling requests that overlap sector boundries.

Jeff


> 
> --Stephen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
