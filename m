Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130771AbQKPRAc>; Thu, 16 Nov 2000 12:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbQKPRAW>; Thu, 16 Nov 2000 12:00:22 -0500
Received: from slc1038.modem.xmission.com ([166.70.8.22]:15625 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130497AbQKPRAJ> convert rfc822-to-8bit; Thu, 16 Nov 2000 12:00:09 -0500
To: Juan <piernas@ditec.um.es>
Cc: Alexander Viro <viro@math.psu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Addressing logically the buffer cache
In-Reply-To: <Pine.GSO.4.21.0011141445450.5482-100000@weyl.math.psu.edu> <3A11C480.A27E406B@ditec.um.es>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Nov 2000 09:18:31 -0700
In-Reply-To: Juan's message of "Wed, 15 Nov 2000 00:02:24 +0100"
Message-ID: <m1y9yj7uw8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juan <piernas@ditec.um.es> writes:

> Alexander Viro escribió:
> > 
> > On Tue, 14 Nov 2000, Juan wrote:
> > 
> > > Hi!.
> > >
> > > Is there any patch or project to address logically the buffer cache?.
> > > Now, you use three parameters to find a buffer in cache: device, block
> > > number, and block size. But, what about if I want to find a buffer using
> > > a super block, an inode number, and a block number within the file
> > > specified by the inode number.
> > 
> > What's wrong with using the pagecache and per-page buffer_heads?
> 
> Suppose you are implementing a log-structured file system and a process
> adds a new logical block to a file. Besides, suppose that the segment is
> 512 KBytes in size. Usually, you don't want to write the segment before
> it is full. The logical block hasn't got a physical address because you
> don't build the segment until it is written to disk. So, what happens if
> another process wants to access to the new block?.
> 
> You can't assign a physical address to the new block because the address
> can change when the buffer is written to disk.

So you don't assign a buffer head until you make the final decision.
There are some interesting issues with how you track that your data
is dirty but otherwise all is well.
> 
> Perhaps, I'm wrong, but I think that the implementation of the BSD-LFS
> needs to address logically the buffer cache.

The linux vfs is quite different from the berkley one.  The linux page
cache is much closer to the berkley block cache, then the depricated
linux block cache.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
