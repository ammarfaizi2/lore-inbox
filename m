Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263270AbSKJDTs>; Sat, 9 Nov 2002 22:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263276AbSKJDTs>; Sat, 9 Nov 2002 22:19:48 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27720 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263270AbSKJDTr>; Sat, 9 Nov 2002 22:19:47 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.44.0211091510060.1571-100000@home.transmeta.com>
	<m1of8ycihs.fsf@frodo.biederman.org>
	<1036894347.22173.6.camel@irongate.swansea.linux.org.uk>
	<m1k7jmcgo5.fsf@frodo.biederman.org>
	<20021110000346.B31205@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 20:23:50 -0700
In-Reply-To: <20021110000346.B31205@almesberger.net>
Message-ID: <m13cqacdkp.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> Eric W. Biederman wrote:
> > So my gut impression at least says an interface that ignores where
> > the image wants to live just adds complexity in other places,
> 
> Linus' alloc_kernel_pages function would actually be able to handle
> this, provided that the "validity callback" checks if the allocated
> page happens to be in one of the destination areas.
> 
> I'm not so sure if this implementation is really that much more
> compact than your current conflict resolution, though. Also, it may
> be hairy in scenarios where you actually expect to fill more than
> 50% of system memory. (But your concerns about a 128MB limit scare
> me, too. I realize that people have taken initrds to extremes I
> never quite imagined, but that still looks a little excessive :-)

I have not heard of more than about 90MB.  One of the things I would
not be surprised to see in the next couple of years as memory gets
cheaper is diskless systems that don't even bother doing NFS root and
just put everything in an initrd.  But that is not the main concern.

Since there are more polite ways of allocating memory already
implemented.  Sucking up a 16MB hunk of some ones  vmalloc space is
quite rude.  Currently the limit is pretty much 50% of system memory
or 1GB whichever is less because the code must be loaded into user
space first, and I don't touch high memory.  Although I guess if it
was mmaped read only the limit may be higher. 

I don't expect to come to close to using all of system memory
except on limited memory systems.  But it is always nice to be
polite.

Eric
