Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314417AbSEUMfl>; Tue, 21 May 2002 08:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314409AbSEUMfk>; Tue, 21 May 2002 08:35:40 -0400
Received: from kim.it.uu.se ([130.238.12.178]:19587 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S314422AbSEUMfj>;
	Tue, 21 May 2002 08:35:39 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15594.16140.857729.697091@kim.it.uu.se>
Date: Tue, 21 May 2002 14:35:24 +0200
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@math.psu.edu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] possible fix for broken floppy driver since 2.5.13
In-Reply-To: <20020521132451.A13419@infradead.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Mon, May 20, 2002 at 07:01:52PM +0200, Mikael Pettersson wrote:
 > > Since 2.5.13 I've been unable to use drivers/block/floppy.c.
 > > There were two symptoms: /dev/fd0 was read-only until after
 > > the first read, and writes wrote currupt data to the media.
 > > 
 > > The patch below against 2.5.16 fixes these problems for me:
 > > 
 > > - The read-only problem was caused by a getblk() call in
 > >   floppy_revalidate() which had been commented out (2.5.13
 > >   did away with getblk() altogether.) This call is necessary,
 > >   so the patch reintroduces a private getblk() in floppy.c.
 > 
 > Please don't use getblk(), but go directly through the bio interface.
 > In 2.5 the buffer_heads are just a legacy interface for filesystems and
 > are not supposed to be used by lowlevel drivers.

I haven't got a clue on how to program Linux' block I/O interfaces.
Show me how to do a modern equivalent of getblk(dev,0,1024) + waiting
for the operation to complete and I'll update the patch ASAP.

/Mikael
